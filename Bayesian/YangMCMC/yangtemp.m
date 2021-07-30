function u = yangtemp(m,x)
% function u = yangtemp(m,x)
% a dispensable function, to make this routine clearer
function ytrue = fun(m,x)
    [ux, uy, uz] = yangdisp(m(1),m(2),m(3),m(4),m(5),10^10,10^10,0.25,m(6),m(7),m(8),x,x2x(x),0);
ytru    e = [ux,uy,uz]; 
end