function [disx,disy,disz] = ddisp(x,y,z)
% function disp = ydisp(x,y,z)
% to simplify displacement function
% [disx,disy,disz] = okada92('tensile',-23250.143,250.086,-23249.857,249.914,6500,6501,0.5,121,10000000000,10000000000,x,y,z);
% [disx1,disy1,disz1] = dike92(-23000,-2000,6500,16,1,0.01,11,x,y,z);
% [disxr,disyr,diszr] = dike92(-23000,-2000,6500,16,1,0.01,11,0,0,0);
% disx = disx1-disxr;
% disy = disy1-disyr;
% disz = disz1-diszr;
% function [u,v,w] = dike(x0,y0,d,length,width,U,strike,x,y)
% function [u v w dwdx dwdy eea gamma1 gamma2] = okada92(fault,xi,yi,xf,yf,zt,zb,U,delta,mu,nu,x,y,z)
depth = 5000;
length = 4000;
width = 4000;
strike = 61;
dip = 15;
U = 0.00000005;
[disx,disy,disz] = dike92(0,0,depth,length,width,U,dip,strike,x,y,z);
end