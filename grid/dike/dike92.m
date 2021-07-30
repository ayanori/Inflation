function [u,v,w] = dike92(x0,y0,d,length,width,U,dip,strike,x,y,z)
% function [u,v,w] = dike(x,y,d,length,width,dV,strike)
% calculate displacements from dike source
% u horizontal displacement (east)
% v horizontal displacement (north)
% w vertical displacement (positive upward)
% 
% x,y,d location of dike source
% length,width,dV,strike
width2 = width / 2;
dx = width*sin(strike);
dy = width*cos(strike);
xi = x0 - dx;
xf = x0 + dx;
yi = y0 - dy;
yf = y0 + dy;
zb = d + length;
[u,v,w] = o92('tensile',xi,yi,xf,yf,d,zb,U,dip,10000000000,10000000000,x,y,z);
end
