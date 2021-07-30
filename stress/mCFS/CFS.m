function dCFS = CFS(x,y,z)
% function dCFS = CFS(x,y,z)
% to calculate the coulumn stress change of points underground

% fault parameters is from 2020/6/15 M4.19 earthquake (D Roman)
% cal depth 8.6 km
% strike 100
% dip 30
% rake 140																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																			

L = [0.100255822120290,0.568579021301629,1]';
N = [-0.300767466360871,1.705737063904886,1]';
M = [0.984807753012208,-0.173648177666930,0]';

lambda = 140 * pi / 180;
mu = 0.6;

sigma = mstress(x,y,z);
% T: forces on fault plane
T = sigma * L;
% dsn: d-sigma_N, normal stress on the fault plane
dsn = T' * L;
% dtdip: d-tau_dip, force along dip
dtdip = T' * N;
% dtstrike: d-tau_strike, force along dip
dtstrike = T' * M;
% dtrake: d-tau_rake, shear stress along the rake direction
dtrake = dtstrike * cos(lambda) + dtdip * sin(lambda);
% dCFS = dtrake + mu * ( dsn + dp );
dCFS = dtrake + mu * dsn;
