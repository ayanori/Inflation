function dCFS = CFS(x,y,z)
% function dCFS = CFS(x,y,z)
%
L = [0.5773502692,-0.5773502692,0.5773502692]';
N = [0.7071067812,-0.7071067812,0]';
M = [0.7071067812,0.7071067812,0]';
lambda = 0;
mu = 0.6;
sigma = dstress(x,y,z);
T = sigma * L;
dsn = T' * L;
dtdip = T' * N;
dtstrike = T' * M;
dtrake = dtstrike * cos(lambda) + dtdip * sin(lambda);
% dCFS = dtrake + mu * ( dsn + dp );
dCFS = abs( dtrake + mu * ( dsn ) );
