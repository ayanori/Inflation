function dCFS = CFS1(x,y,z)
% function dCFS = CFS(x,y,z)
%
% L = [0.4848096202,0.8746197071,0]';

x1 = x- - z*0.2343536442;
y1 = y- - z*0.1299043462;

A = [0.8746197071, 0.4848096202; -0.4848096202, 0.8746197071];

C = [x1,y1] * inv(A);

dCFS0 = ystress(C(1),C(2),z);
dCFS = dCFS0(1,2);