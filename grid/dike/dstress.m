 function sigma = dstress(x,y,z)
% function sigma = dstress(x,y,z)

mu = 10^10;
lambda = 10^10;
% cosum = lambda + 2 * mu;

epsilon = dstrain(x,y,z);

% strains = [ epsilon(1,1) , epsilon(2,2) , epsilon(3,3) , 2*epsilon(2,3) , 2*epsilon(3,1) , 2*epsilon(1,2) ]';
% 
% mat = [ cosum,  lambda, lambda, 0,      0,      0;
%         lambda, cosum,  lambda, 0,      0,      0;
%         lambda, lambda, cosum,  0,      0,      0;
%         0,      0,      0,      mu,     0,      0;
%         0,      0,      0,      0,      mu,     0;
%         0,      0,      0,      0,      0,      mu ];
% 
% stresses = mat * strains;
% 
% sigma = [ stresses(1),              0.5*stresses(6),        0.5*stresses(5);
%           0.5*stresses(6),          stresses(2),            0.5*stresses(4);
%           0.5*stresses(5),          0.5*stresses(4),        stresses(3) ];

theta = epsilon(1,1) + epsilon(2,2) + epsilon(3,3);
product = lambda * theta;
sigma(1,1) = 2 * mu * epsilon(1,1) + product;
sigma(1,2) = 2 * mu * epsilon(1,2);
sigma(1,3) = 2 * mu * epsilon(1,3);
sigma(2,1) = sigma(1,2);
sigma(2,2) = 2 * mu * epsilon(2,2) + product;
sigma(2,3) = 2 * mu * epsilon(2,3);
sigma(3,1) = sigma(1,3);
sigma(3,2) = sigma(2,3);
sigma(3,3) = 2 * mu * epsilon(3,3) + product;