% Example 11.4
% from Parameter Estimation and Inverse Problems, 3rd edition, 2018
% by R. Aster, B. Borchers, C. Thurber
% lp=logprior(m)
%
% For this problem, our prior is uniform on m1=[0 2], m2=[-1 0], m3=[0 2],
% m4=[-1 0]
%
% mtrue=[-23000; -2500; 4700; 500; 300; 3600000000; 0.01; 0.73];
% mlims  = [-23500 -22500; -2750 -2250; 4500 4900; 3400000000 3800000000; 0.001 0.019; 0.71 0.75];

function lp = logprior(m)
% if (m(1)>=0) && (m(1)<=2) && (m(2)>=-0.9) && (m(2)<=0) && (m(3)>=0) && (m(3)<=2) && (m(4)>=-0.9) && (m(4)<=0)
if ( m(1) > -30000 ) && ( m(1) < -20000 ) && ( m(2) > -4000 ) && ( m(2) < 2000 )  && ( m(3) > 0 ) && ( m(3) < 1000 ) && ( m(4) > 0 ) && (m(4) < 1000) && ( m(5) > 0 ) && (m(5) < 1000) && ( m(6) > 0 ) && (m(6) < 1000000000) && ( m(7) > 0 ) && (m(7) < 3.1416) && ( m(8) > 0 ) && (m(8) < 1.5708)
    lp = 0;
else
    lp = -Inf;
end
end