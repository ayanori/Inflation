function ytrue = fun(m,x)
[uxs, uys, uzs] = dike1(m(1),m(2),m(3),m(4),m(5),m(6),m(7),m(8),x,x2x(x));
[ux0, uy0, uz0] = dike1(m(1),m(2),m(3),m(4),m(5),m(6),m(7),m(8),0,0);
ytrue = [ uxs - ux0 , uys - uy0 , uzs - uz0 ];
end