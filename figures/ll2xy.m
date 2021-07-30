function [x,y] = ll2xy(lon,lat,direction)
%function[x,y] = ll2xy(lon,lat)
%convert longitude/latitude to east/north distance from reference station
%or do the contrary if direction=0
%reference station: site DUTC( -166.54848600066168 , 53.905013000620606 )
%%
lon0 = -166.54848600066168;
lat0 = 53.905013000620606;
%lon0 = -166.54183600062353;
%lat0 = 53.875635000401964;
%%
ae = 6378136.49;
ap = 6356755.00;
x0 = ( ae^(-2) + (tan(lat0/180.0*pi))^2/(ap^2) )^(-0.5) *pi/180.0;
y0 = pi*ap/180.0;
%%
if direction == 1
    x = (lon - lon0) .* x0;
    y = (lat - lat0) .* y0;
else if direction == 0
        x = lon ./ x0 + lon0;
        y = lat ./ y0 + lat0;
    else
        disp('Warning: invalid parameter in function ll2xy');
    end
end