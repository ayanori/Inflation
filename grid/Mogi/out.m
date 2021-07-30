%best_x: -23700	-166.9106643880366
%best_y: -2000	53.886986262288524
%best_d: 5700 -> 5205	
%best_C: 541976 -> 597552
%%
x = E - best_x;
y = N - best_y;
%[dx,dy,dz] = mogi1(x,y,alt+best_d,best_C);
[dx,dy,dz] = mogi1(x,y,best_d,best_C);
%%
xRef = -best_x;
yRef = -best_y;
%[dxRef,dyRef,dzRef] = mogi1(xRef,yRef,altRef+best_d,best_C);
[dxRef,dyRef,dzRef] = mogi1(xRef,yRef,best_d,best_C);
%%
if 1 == 1
    de = (dx - dxRef) .* 1000.0;
    dn = (dy - dyRef) .* 1000.0;
    M = [lon, lat, de, dn];
    %writematrix(M,'mhorizontal.txt','Delimiter','tab');
end
%%
if 2 == 2
    vert = zeros(4,1);
    dv = (dz - dzRef) .* 1000.0;
    M1 = [lon, lat, vert, dv];
    %writematrix(M1,'mvertical.txt','Delimiter','tab');
end
%%
[latV,lonV]=ll2xy(best_x,best_y,0);
deltaV = 3.14159265359 * best_C / 0.75;
disp(deltaV);