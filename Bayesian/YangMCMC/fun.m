% from Parameter Estimation and Inverse Problems, 2nd edition, 2011
% by R. Aster, B. Borchers, C. Thurber
function ytrue = fun(m,x)
[uxs, uys, uzs] = yangdisp(m(1),m(2),m(3),m(4),m(5),10^10,10^10,0.25,m(6),m(7),m(8),x,x2x(x),[0;0;0;0]);
[ux0, uy0, uz0] = yangdisp(m(1),m(2),m(3),m(4),m(5),10^10,10^10,0.25,m(6),m(7),m(8),0,0,0);
ytrue = [ uxs - ux0 , uys - uy0 , uzs - uz0 ];
end