% clear;
xs = [-25649.41918434133, -13078.24662777915, -15665.31292542263, 435.1584920527459]';
ys = [-10752.69397678629, -10586.49644710857, 1073.960208499746, -3259.380557641519]';
% [e,n,v] = ddisp(xs,ys);
% disp([e/2,n/2,v/2]);



[ur,vr,wr] = dike1(-23000,-2000, best_depth , best_len , best_wid , best_U , best_strike , best_dip ,xs,ys);
% [ur,vr,wr] = dike1(-23000,-2000,depth,leni,widi,U(Ui),strikei,dipi,xs,ys);
% [Uxr,Uyr,Uzr] = yangdisp(xi,yi,zi,ai,bi,10000000000,10000000000,0.25,1,real(loop(i)),imag(loop(i)),xs,ys,zs);
[u0,v0,w0] = dike1(-23000,-2000, best_depth , best_len , best_wid , best_U , best_strike , best_dip ,0,0);
% us0 = [ur-u0, vr-v0, wr-w0];
us1 = [ur-u0, vr-v0];
us2 = wr -w0;
disp(us2);

