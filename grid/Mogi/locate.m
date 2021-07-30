%This script loops to iterate over x, y, depth to locate.
minR = 100000000.0;
for xi = -26000:50:-21000
    progress = (xi+26000)/50;
    disp(['Progress: ' num2str(progress) ' %']);
    for yi = -4000:50:0
        for di = 3000:50:9000
            %%
            x = E - xi;
            y = N - yi;
            %[dx,dy,dz] = mogi1(x,y,alt+di,1.0);
            [dx,dy,dz] = mogi1(x,y,di,1.0);
            %%
            xRef = -xi;
            yRef = -yi;
            % [dxRef,dyRef,dzRef] = mogi1(xRef,yRef,di,1.0);
            [dxRef,dyRef,dzRef] = mogi1(xRef,yRef,di,1.0);
            %%
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