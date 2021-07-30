x = 114514;
y = 1919;
z = 810;
z0 = 1017;
theta = 0.5;
a1 = 500;
b1 = 300;
a = 500;
b = 300;
csi = 1;
mu = 10000000000;
nu = 0.25;
Pdila = 5000;



[U1,U2,U3] = yangint(x,y,z,z0,theta,a1,b1,a,b,csi,mu,nu,Pdila);
[U4,U5,U6] = yangint1(x,y,z,z0,theta,a1,b1,a,b,csi,mu,nu,Pdila);
disp(U1);
disp(U4);
disp(U2);
disp(U5);
disp(U3);
disp(U6);