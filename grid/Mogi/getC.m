%%
x = E - best_x;
y = N - best_y;
[dx,dy,dz] = mogi1(x,y,best_d+alt,1.0);
%%
xRef = -best_x;
yRef = -best_y;
%[dxRef,dyRef,dzRef] = mogi1(xRef,yRef,best_d+altRef,1.0);
[dxRef,dyRef,dzRef] = mogi1(xRef,yRef,best_d,1.0);
%%
d00 = [dx-dxRef,dy-dyRef,dz-dzRef];
%%
minR = 100000000.0;
for C = 0:1000000
    dd = C .* d00;
    R = dd - uu;
    if minR > norm(R)
        best_C = C;
        minR = norm(R);
    end
end
%%
disp(best_C);