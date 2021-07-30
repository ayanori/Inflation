disp('---process started successfully, initializing---');
xs = [-25649.41918434133, -13078.24662777915, -15665.31292542263, 435.1584920527459]';
ys = [-10752.69397678629, -10586.49644710857, 1073.960208499746, -3259.380557641519]';
zs = [-225.2999597793727, -680.1999901627641, -324.5999964253786, 0.8227587787353]';
Dx = [-3.766967401219437, 3.323375144507840, 8.459921830070792, -1.237944584057016]';
Dy = [-6.949538684577834, -2.787623038381009, 3.571725924331061, -0.005399865062206;]';
Dz = [5.748254301439165, 1.568124105973232, 3.744902021911361, -1.465395770966372]';
Ds0 = [Dx, Dy, Dz];
Ds = Ds0 / 1000;

best_x = -24250;
best_y = -3000;
best_z = 5200;
best_a = 600;
best_b = 300;
best_theta = 0.05;
best_phi = 0.1200;

minR = 100000000000000;

for Pi = 1:100000:99999999999
    [Uxr,Uyr,Uzr] = yangdisp(best_x,best_y,best_z,best_a,best_b,10000000000,10000000000,0.25,Pi,best_theta,best_phi,xs,ys,zs);
    [Ux0,Uy0,Uz0] = yangdisp(best_x,best_y,best_z,best_a,best_b,10000000000,10000000000,0.25,Pi,best_theta,best_phi,0,0,0);
    Us = [Uxr-Ux0, Uyr-Uy0, Uzr-Uz0];
    R = Us - Ds;
    Nn = norm(R);
    if minR > Nn
        best_P = Pi;
        minR = Nn;
    end
    progress = Pi/99999999999*100;
    disp(['---inversing, progress: ' num2str(progress) ' %---']);
end
disp(best_P);

[Uxr,Uyr,Uzr] = yangdisp(best_x,best_y,best_z,best_a,best_b,10000000000,10000000000,0.25,best_P,best_theta,best_phi,xs,ys,zs);
[Ux0,Uy0,Uz0] = yangdisp(best_x,best_y,best_z,best_a,best_b,10000000000,10000000000,0.25,best_P,best_theta,best_phi,0,0,0);
Us = [Uxr-Ux0, Uyr-Uy0, Uzr-Uz0];
disp(Us);
