% function epsilon = strain(r,d)
% % function epsilon = strain(r,d)
% % to calculate strain at given point underground
% % (r,d) refers to the distances from source
% % direction: r-horizontal away source; d-up
% % all calculations are done in meters
% C = 597552;
% factor = (hypot(r,d))^(-5) * C;
% epsilon(1,1) = factor * ( d*d - 2*r*r );
% epsilon(1,2) = 0;
% epsilon(1,3) = factor * ( -3*d*r );
% epsilon(2,1) = 0;
% epsilon(2,2) = 0;
% epsilon(2,3) = 0;
% epsilon(3,1) = epsilon(1,3);
% epsilon(3,2) = 0;
% epsilon(3,3) = factor * ( r*r - 2*d*d );function epsilon = strain(r,d)
function epsilon = strain(x,y,z)
C = 597552;
factor1 = x^2+y^2+z^2;
factor2 = factor1^(-2.5) * C;
epsilon(1,1) = factor2 * ( factor1 - 3*x*x );
epsilon(1,2) = factor2 * ( -3*x*y );
epsilon(1,3) = factor2 * ( -3*x*z );
epsilon(2,1) = epsilon(1,2);
epsilon(2,2) = factor2 * ( factor1 - 3*y*y );
epsilon(2,3) = factor2 * ( -3*y*z );
epsilon(3,1) = epsilon(1,3);
epsilon(3,2) = epsilon(2,3);
epsilon(3,3) = factor2 * ( factor2 - 3*z*z );
