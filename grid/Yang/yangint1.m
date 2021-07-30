function[U1,U2,U3] = yangint1(x,y,z,z0,theta,a1,b1,a,b,csi,mu,nu,Pdila)
%%
sint = sin(theta);
cost = cos(theta);
ys = y*sint;
yc = y*cost;
z1s = (z-z0)*sint;
z1c = (z-z0)*cost;
z2s = (z+z0)*sint;
z2c = (z+z0)*cost;
R1 = sqrt( x^2 + (y-csi*cost)^2 + (z-z0-csi*sint)^2 );
R2 = sqrt( x^2 + (y-csi*cost)^2 + (z+z0+csi*sint)^2 );
%%
beta = ( (ys+z2c)*cost + (1+sint)*(R2+(z+z0)*sint+csi-ys) )/( cost*x + 10^(-15) );
%%
fl = csi*x/(R2+z+z0+csi*sint) + 3/cost/cost*(x*sint*log(R2+z+z0+csi*sint)-x*log(R2+z2s-yc+csi)+2*(ys+z2c)*atan(beta)) ...
    + 2*x*log(R2+z2s-yc+csi) - 4*(z+z0)*atan(beta)/cost;
%%
U1 = a*b*b/(csi^3*16&mu*(1-nu))*( x*a1/R1/(R1+yc+z1s-csi) + b1*x*log(R1+yc+z1s-csi) + ...
    b1*x*(yc-z1s+csi)/(R1+yc+z1s-csi) + (3-4*nu)*x*( -a1/R2/(R2-yc+z2s+csi) -b1*(log(R2-yc+z2s+csi)+(-yc+z2s-csi)/(R2-ys+z2s+csi)) ) -2*Pdila*...
    ( csi*x/R1+x*log(R1+yc+z1s-csi)+(3-4*nu)*x*(csi/R2 -log(R2+z2s+csi-yc)) -4*(1-nu)*(1-2*nu)*fl) );
U2 = 0;
U3 = 0;