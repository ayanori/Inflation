function epsilon = dstrain(x,y,z)
% function epsilon = ystrain(x,y,z)
% use difference rather than differential to calculate strain

% [ux,uy,uz] = ddisp(x,y,z);

[uxxp,uyxp,uzxp] = ddisp(x+0.01,y,z);
[uxxm,uyxm,uzxm] = ddisp(x-0.01,y,z);
[uxyp,uyyp,uzyp] = ddisp(x,y+0.01,z);
[uxym,uyym,uzym] = ddisp(x,y-0.01,z);
[uxzp,uyzp,uzzp] = ddisp(x,y,z-0.01);
[uxzm,uyzm,uzzm] = ddisp(x,y,z+0.01);

dux_dx = 50 * ( uxxp - uxxm );
dux_dy = 50 * ( uxyp - uxym );
dux_dz = 50 * ( uxzm - uxzp );
duy_dx = 50 * ( uyxp - uyxm );
duy_dy = 50 * ( uyyp - uyym );
duy_dz = 50 * ( uyzm - uyzp );
duz_dx = 50 * ( uzxp - uzxm );
duz_dy = 50 * ( uzyp - uzym );
duz_dz = 50 * ( uzzm - uzzp );

epsilon(1,1) = dux_dx;
epsilon(1,2) = 0.5 * ( dux_dy + duy_dx );
epsilon(1,3) = 0.5 * ( dux_dz + duz_dx );
epsilon(2,1) = epsilon(1,2);
epsilon(2,2) = duy_dy;
epsilon(2,3) = 0.5 * ( duy_dz + duz_dy );
epsilon(3,1) = epsilon(1,3);
epsilon(3,2) = epsilon(2,3);
epsilon(3,3) = duz_dz;
