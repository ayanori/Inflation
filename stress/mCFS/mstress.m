function sigma = mstress(x,y,d)
% function sigma = mstress(x,y,d)
% to calculate the tensor of stress change caused by mogi source
% x,y,d: coordinates of the target point away from the source
% positive direction: east/north/down (right hand system)
% all calculation are processed in SI units
z = d - 5200;
factor = 2 * 10000000000 * 597306 * (x^2+y^2+z^2)^(-2.5);
sigma(1,1) = factor * (y^2+z^2-2*x^2);
sigma(1,2) = factor * (-3*x*y);
sigma(1,3) = factor * (-3*x*z);
sigma(2,1) = sigma(1,2);
sigma(2,2) = factor * (z^2+x^2-2*y^2);
sigma(2,3) = factor * (-3*y*z);
sigma(3,1) = sigma(1,3);
sigma(3,2) = sigma(2,3);
sigma(3,3) = factor * (x^2+y^2-2*z^2);

