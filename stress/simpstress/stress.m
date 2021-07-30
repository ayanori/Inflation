% function sigma = stress(r,d)
% % function sigma = stress(r,d)
% % all calculation are done in SI
% mu = 10000000000;
% lambda = 10000000000;
% cosum = lambda + 2 * mu;
% epsilon = strain(r,d);
% strains = [ epsilon(1,1) , epsilon(2,2) , epsilon(3,3) , 2*epsilon(2,3) , 2*epsilon(3,1) , 2*epsilon(1,2) ]';
% mat = [ cosum,  lambda, lambda, 0,      0,      0;
%         lambda, cosum,  lambda, 0,      0,      0;
%         lambda, lambda, cosum,  0,      0,      0;
%         0,      0,      0,      mu,     0,      0;
%         0,      0,      0,      0,      mu,     0;
%         0,      0,      0,      0,      0,      mu ];
% stresses = mat * strains;
% sigma = [ stresses(1),              0.5*stresses(6),        0.5*stresses(5);
%           0.5*stresses(6),          stresses(2),            0.5*stresses(4);
%           0.5*stresses(5),          0.5*stresses(4),        stresses(3) ];function sigma = stress(r,d)
% function sigma = stress(x,y,z)
% mu = 10000000000;
% lambda = 10000000000;
% cosum = lambda + 2 * mu;
% epsilon = strain(x,y,z);
% strains = [ epsilon(1,1) , epsilon(2,2) , epsilon(3,3) , 2*epsilon(2,3) , 2*epsilon(3,1) , 2*epsilon(1,2) ]';
% mat = [ cosum,  lambda, lambda, 0,      0,      0;
%         lambda, cosum,  lambda, 0,      0,      0;
%         lambda, lambda, cosum,  0,      0,      0;
%         0,      0,      0,      mu,     0,      0;
%         0,      0,      0,      0,      mu,     0;
%         0,      0,      0,      0,      0,      mu ];
% stresses = mat * strains;
% sigma = [ stresses(1),              0.5*stresses(6),        0.5*stresses(5);
%           0.5*stresses(6),          stresses(2),            0.5*stresses(4);
%           0.5*stresses(5),          0.5*stresses(4),        stresses(3) ];
function sigma = stress(x,y,z)
factor = 2 * 10000000000 * 597552 * (x^2+y^2+z^2)^(-2.5);
sigma(1,1) = factor * (y^2+z^2-2*x^2);
sigma(1,2) = factor * (-3*x*y);
sigma(1,3) = factor * (-3*z*x);
sigma(2,1) = sigma(1,2);
sigma(2,2) = factor * (z^2+x^2-2*y^2);
sigma(2,3) = factor * (-3*y*z);
sigma(3,1) = sigma(1,3);
sigma(3,2) = sigma(2,3);
sigma(3,3) = factor * (x^2+y^2-2*z^2);
