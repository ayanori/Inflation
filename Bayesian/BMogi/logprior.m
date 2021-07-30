% Example 11.4
% from Parameter Estimation and Inverse Problems, 3rd edition, 2018
% by R. Aster, B. Borchers, C. Thurber
% lp=logprior(m)
%
% For this problem, our prior is uniform on m1=[0 2], m2=[-1 0], m3=[0 2],
% m4=[-1 0]
%
% m1 [-30000,-20000]
% m2 [-8000,2000]
% m3 [0,10000]
% m4 [0 999999]

function lp = logprior(m)
% if (m(1)>=0) && (m(1)<=2) && (m(2)>=-0.9) && (m(2)<=0) && (m(3)>=0) && (m(3)<=2) && (m(4)>=-0.9) && (m(4)<=0)
% if ( m(1) > -30000 ) && ( m(1) < -20000 ) && ( m(2) > -8000 ) && ( m(2) < 2000 )  && ( m(3) > 0 ) && ( m(3) < 10000 ) && ( m(4) > 0 ) && (m(4) < 900000)
if ( m(1) > -30000 ) && ( m(1) < -20000 ) && ( m(2) > -8000 ) && ( m(2) < 2000 )  && ( m(3) > 0 ) && ( m(3) < 10000 ) && ( m(4) > 0 ) && (m(4) < 900000)
    lp = 0;
else
    lp = -Inf;
end
end