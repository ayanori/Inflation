function [u,v,w] = dike1(x0,y0,d,length,width,U,strike,dip,x,y)
% function [u,v,w] = dike(x,y,d,length,width,dV,strike)
% calculate displacements from dike source
% u horizontal displacement (east)
% v horizontal displacement (north)
% w vertical displacement (positive upward)
% 
% x,y,d location of dike source
% length,width,dV,strike
width2 = width / 2;
strike = strike*pi/180;
dx = width2*sin(strike);
dy = width2*cos(strike);
xi = x0 - dx;
xf = x0 + dx;
yi = y0 - dy;
yf = y0 + dy;
zb = d + length;
[u,v,w] = okada('tensile',xi,yi,xf,yf,d,zb,U,dip,10000000000,10000000000,x,y);
end
