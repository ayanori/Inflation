addpath /usr/local/matlab/
addpath /usr/local/matlab/t_debug
clear all;
close all;
clc

%diary(sprintf('%s_20110803.txt', mfilename));
%diary on

disp('running spurr');

%RMSE_TYPE: 1 = all
%           2 = horizontal only
%           3 = vertical only
% this selects which components are considered for misfit calculation.
RMSE_TYPE = 1;

%hack, leave 1 for inflation, -1 for deflation.
radial_coeff = 1;

%put reference site in here.
ref_site_name  = 'NOAM';

%path to where all the data sits
path_name = '/gps/analyzed/Spurr_2006';
%path_name = '../spurr';

%data file names, include path if not in same directory
%data must be in GMT psvelo format including station name!
hori_file      = [path_name '/SpurrVolc2.gmtvec'];
vert_file      = [path_name '/Spurr-vert2.gmtvec'];
%hori_file      = ['Spurr-NOAM2.gmtvec'];
%vert_file      = ['Spurr-vert2.gmtvec'];

%read in horizontal and vertical displacments
fid = fopen(hori_file);
hori_data = textscan (fid, '%f%f%f%f%f%f%f%s');
fclose(fid);

fid = fopen(vert_file);
up_data = textscan (fid, '%f%f%f%f%f%f%f%s');
fclose(fid);

%%GET STATION POSITIONS in UTM (zone 5) from file
fid = fopen([path_name '/sites.utm']);
sites_utm = textscan (fid, '%f%f%s');       %%format: lon, lat
fclose(fid);    

%%GET VOLCANO POSITIONS in UTM (zone 5) from file
fid = fopen([path_name '/volcano.utm']);
volcano_utm = textscan (fid, '%f%f%s');       %%format: lon, lat
fclose(fid);    

%round to nearest meter
sites_utm{1} = round(sites_utm{1});
sites_utm{2} = round(sites_utm{2});

volcano_utm{1} = round(volcano_utm{1});
volcano_utm{2} = round(volcano_utm{2});

%%BEGIN INVERSION/SEARCH SETTINGS

%horizontal grid spacing
interval =1000;

%horizontal grid definition  
region.x    = volcano_utm{1}-10000:interval:volcano_utm{1}+10000;          %m
region.y    = volcano_utm{2}-10000:interval:volcano_utm{2}+10000;          %m

%vertical grid definition
depths      = 1000:1000:40000;

%%TEST SETTINGS
%region.x   = volcano_utm{1};
%region.y   = volcano_utm{2};
%depths     = 1000:500:2000;

%%END INVERSION/SEARCH SETTINGS

%put all data in a struct
sta_coords = struct;

for n=1:length(sites_utm{1})
    sta_coords.(sites_utm{3}{n}) = struct('x', 0, 'y', 0);
    sta_coords.(sites_utm{3}{n}).x = sites_utm{1}(n);
    sta_coords.(sites_utm{3}{n}).y = sites_utm{2}(n);
end

%1,2    longitude, latitude of station (-: option interchanges order)
%3,4    eastward, northward velocity (-: option interchanges order)
%5,6    uncertainty of  eastward,  northward  velocities  (1-sigma)  (-:
%       option interchanges order)
%7      correlation between eastward and northward components
%8      name of station (optional).

format = struct('lon', 1, 'lat', 2, 'east', 3, 'north', 4, 'sig_e', 5, 'sig_n', 6, 'corr', 7, 'name', 8);

SPBG = struct('name', 'SPBG', 'x', sta_coords.SPBG.x, 'y', sta_coords.SPBG.y, 'z', 1093.92, 'index', find(ismember(hori_data {format.name}, 'SPBG')));
SPCG = struct('name', 'SPCG', 'x', sta_coords.SPCG.x, 'y', sta_coords.SPCG.y, 'z', 1342.72, 'index', find(ismember(hori_data {format.name}, 'SPCG')));
SPCR = struct('name', 'SPCR', 'x', sta_coords.SPCR.x, 'y', sta_coords.SPCR.y, 'z', 1004.33, 'index', find(ismember(hori_data {format.name}, 'SPCR')));
%SPCP = struct('name', 'SPCP', 'x', sta_coords.SPCP.x, 'y', sta_coords.SPCP.y, 'z', 1628.80, 'index', find(ismember(hori_data {format.name}, 'SPCP')));

%compile sites we use
%sites = [SPBG; SPCG; SPCR];
sites = [SPBG; SPCG];   %good for single mogi estimate

%set ref site 
if (strcmp(ref_site_name,'AC59'))
    refsite = AC59;
    disp(sprintf('picked reference site: %s', refsite.name));
elseif (strcmp(ref_site_name, 'AC17'))
    refsite = AC17;
    disp(sprintf('picked reference site: %s', refsite.name));
elseif (strcmp(ref_site_name,'NONE') || strcmp(ref_site_name,'NOAM'))
    refsite = 0;
else
    error(sprintf('Unknown reference site: %s', ref_site_name));
end

% %this is redundant, and needs to be converted to stuctures above.
% %for now we read the data from the structs into a different array that can
% %be thrown at the inversion
% 
for n=1:size(sites)
    east_r(n)  = 0.01 .* hori_data{format.east} ( sites(n).index(1) ) ;
    north_r(n) = 0.01 .* hori_data{format.north}( sites(n).index(1) ) ;
    up_r(n)    = 0.01 .* up_data{format.north} ( sites(n).index(1) ) ;

    esig(n)  = 0.01 .* hori_data{format.sig_e} ( sites(n).index(1) )
    nsig(n)  = 0.01 .* hori_data{format.sig_n}( sites(n).index(1) )
    usig(n)  = 0.01 .* up_data{format.sig_n} ( sites(n).index(1) )    
end

% 
radial_r = sqrt(east_r.^2+north_r.^2);

% create data struct
% create data struct
data_r = struct('x', [], 'y', [], 'lons', [], 'lats', [], 'heights', [], ...
                'uz', [], 'ur', [], 'ue', [], 'un', [], 'esig', [], 'nsig', [],'usig', []);

% put stuff in 
data_r.x       = [sites(:).x];
data_r.y       = [sites(:).y];
data_r.uz      = up_r;
data_r.ue      = east_r;
data_r.un      = north_r;
data_r.esig    = esig;
data_r.nsig    = nsig;
data_r.usig    = usig;
data_r.ur      = radial_r.*radial_coeff;
data_r.lons    = hori_data{format.lon}([sites(:).index]); %lons
data_r.lats    = hori_data{format.lat}([sites(:).index]); %lats
data_r.heights = [sites(:).z];

%%TEST SETTINGS
region.x   = volcano_utm{1}-10000:1000:volcano_utm{1}+10000;
region.y   = volcano_utm{2}-10000:1000:volcano_utm{2}+10000;
depths     = 1000:1000:20000; 
as         = 500:500:10000;   %19000
bs         = 0:50:500;
volumes    = [0.005:0.005:0.04].*1000^3;                   %-0.0207 * 1000^3;

t_debug on;

disp(' ');
disp(' ');
disp('Closed Pipe (inv):');
disp('-----------------------------------------------------');
[y_best_x, y_best_y, y_best_d, y_best_a, y_best_b, y_best_dV, y_rmse] = full_search_yang(region, depths, as, bs, volumes, data_r, refsite, RMSE_TYPE);
