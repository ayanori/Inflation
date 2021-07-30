function [x,y,z] = lld2xyz(lon,lat,depth)
%function[x,y] = ll2xy(lon,lat)
%convert longitude/latitude to east/north distance from reference station
%best_x: -23700	-166.9106643880366
%best_y: -2000	53.886986262288524
%best_d: 5205	
%best_C: 597552
%%
lon0 = -166.9106643880366;
lat0 = 53.886986262288524;
%%
ae = 6378136.49;
ap = 6356755.00;
x0 = ( ae^(-2) + (tan(lat0/180.0*pi))^2/(ap^2) )^(-0.5) *pi/180.0;
y0 = pi*ap/180.0;
%%
x = (lon - lon0) .* x0;
y = (lat - lat0) .* y0;
z = 5205 - depth;
end