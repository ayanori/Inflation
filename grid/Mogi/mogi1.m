function [dx,dy,dz] = mogi1(x,y,d,C)
%function [dr,dz] = mogi1(x,y,d,C)
%Something like mogi.m but
%...with x and y seperated.
r = hypot(x,y);
factor = C./(hypot(r,d).^3);
dx = factor .* x;
dy = factor .* y;
dz = factor .* d;
end
