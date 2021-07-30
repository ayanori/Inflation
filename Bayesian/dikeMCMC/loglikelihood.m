% Example 11.4
% from Parameter Estimation and Inverse Problems, 3rd edition, 2018
% by R. Aster, B. Borchers, C. Thurber
% l=loglikelihood(m)
%
function l=loglikelihood(m)
%
% global variables.
%
global x;
% global y;
global y1;
global y2;
global y3;
global sigma;
%
% Compute the standardized residuals.
%
% fvec = (y-fun(m,x))./sigma;
funtemp = fun(m,x);
fun1 = funtemp(:,1);
fun2 = funtemp(:,2);
fun3 = funtemp(:,3);
fvec1 = (y1-fun1) ./ sigma;
fvec2 = (y2-fun2) ./ sigma;
fvec3 = (y3-fun3) ./ sigma;
fvec = [ fvec1 ; fvec2 ; fvec3 ];
%
% The log likelihood is (-1/2)*sum(fvec(i)^2,i=1..n);
%
l = (-1/2)*sum(fvec.^2);
%
end