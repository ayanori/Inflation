function [dr,dz] = mogi(x,y,d,C)
%function [dr,dz] = mogi(x,y,d,C)
%Given a set of distances (x,y) in carthesian coordinates away from...
% a source location, a source depth d and a source strength C,...
% returns radial and horizontal displacements at these points.
r = hypot(x,y);
factor = C./(hypot(r,d).^3);
dr = factor .* r;
dz = factor .* d;
end
