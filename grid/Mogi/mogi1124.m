clear;

lon = [-166.94045499970332, -166.74834499953678, -166.78787999952465, -166.54183600062353]';
lat = [53.80809500027836, 53.809592999967826, 53.914693000449454, 53.875635000401964]';
[E,N] = ll2xy(lon,lat,1);

xg = -20000;
yg = 1000;
zg = 5000;
Cg = 10^10;

x = E - xg;
y = N - yg;
[dx,dy,dz] = mogi1(x,y,zg,Cg);
[dxRef,dyRef,dzRef] = mogi1(-xg,-yg,zg,Cg);
modelo = [dx-dxRef,dy-dyRef,dz-dzRef];
% disp(model_d);
dadj = modelo .* [1.1,0.90,1.1;0.90,1.1,0.90;1.1,0.90,1.1;0.90,1.1,0.90];

u0 = dadj/dadj(1);
minR = 100000000.0;
for xi = -20000:10:-19000
    progress = (xi+30000)/180;
    disp(['Progress: ' num2str(progress) ' %']);
    for yi = 1000:10:1100
        for di = 5000:10:5100
            x = E - xi; y = N - yi;
            [dx,dy,dz] = mogi1(x,y,di,1.0);
            [dxRef,dyRef,dzRef] = mogi1(-xi,-yi,di,1.0);
            model_d = [dx-dxRef,dy-dyRef,dz-dzRef];
            d0 = model_d ./ model_d(1);
            R = d0 - u0;
            nn = norm(R);
            if minR > nn
                best_x = xi;
                best_y = yi;
                best_d = di;
                minR = nn;
            end
        end
    end
end
disp(best_x);
disp(best_y);
disp(best_d);

x = E - best_x;
y = N - best_y;
[dx,dy,dz] = mogi1(x,y,best_d,1.0);
xRef = -best_x;
yRef = -best_y;
[dxRef,dyRef,dzRef] = mogi1(-best_x,-best_y,best_d,1.0);
d00 = [dx-dxRef,dy-dyRef,dz-dzRef];
minR = 100000000.0;
for C = 10^9:10^6:10^11
    dd = C .* d00;
    R = dd - modelo;
    if minR > norm(R)
        best_C = C;
        minR = norm(R);
    end
end
disp(best_C);