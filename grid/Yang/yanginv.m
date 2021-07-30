% This process does all inversions, including determining position, shape and strength of the Yang source.
% All calculation works in SI units except those printed out.
%%
% function inside [Ux,Uy,Uz] = yangdisp(x0,y0,z0,a,b,lambda,mu,nu,P,theta,phi,x,y,z)
% a         semimajor axis [m]
% b         semiminor axis [m]
% lambda    Lame's constant [Pa]
% mu        shear modulus [Pa]
% nu        Poisson's ratio 
% P         excess pressure (stress intensity on the surface) [pressure units]
% x,y,z     coordinates of the point(s) where the displacement is computed [m]
% x0,y0,z0  coordinates of the center of the prolate spheroid (positive downward) [m]
% theta     plunge angle [rad]
% phi       trend angle [rad]
%
% Ux,Uy,Uz  displacement 
%%
disp('---process started successfully, initializing---');
xs = [-25649.41918434133, -13078.24662777915, -15665.31292542263, 435.1584920527459]';
ys = [-10752.69397678629, -10586.49644710857, 1073.960208499746, -3259.380557641519]';
% zs = [-225.2999597793727, -680.1999901627641, -324.5999964253786, 0.8227587787353]';
Dx = [-3.766967401219437, 3.323375144507840, 8.459921830070792, -1.237944584057016]';
Dy = [-6.949538684577834, -2.787623038381009, 3.571725924331061, -0.005399865062206;]';
Dz = [5.748254301439165, 1.568124105973232, 3.744902021911361, -1.465395770966372]';
Ds0 = [Dx, Dy, Dz];
Ds = Ds0 / Ds0(1,1);
%%
loop = zeros(49770);
for i = 1:158
    for j = 1:315
        loop( i + 158*j -158 ) = complex( 0.01*(i-1) , 0.01*(j-1) );
    end
end
speed = 0;
minR = 1000000000000000.0;
%%
parpool(10);
for xi = -23000:250:-23000
    for yi = -3500:500:-2000
        for zi = 5500:150:5500
            % speed = speed+1;
            % progress = speed/594*100;
            disp(['---inversing, progress: ' num2str(progress) ' %---']);
            for ai = 100:150:1201
                for bi = 1:150:ai
                    parfor i = 1:49770
                        [Uxr,Uyr,Uzr] = yangdisp(xi,yi,zi,ai,bi,10000000000,10000000000,0.25,1,real(loop(i)),imag(loop(i)),xs,ys,zs);
                        [Ux0,Uy0,Uz0] = yangdisp(xi,yi,zi,ai,bi,10000000000,10000000000,0.25,1,real(loop(i)),imag(loop(i)),0,0,0);
                        Us0 = [Uxr-Ux0, Uyr-Uy0, Uzr-Uz0];
                        Us = Us0 / Us0(1,1);
                        R = Us - Ds;
                        Nn(i) = norm(R);
                    end
                    [M,I] = min(Nn);
                    if M < minR
                        best_x = xi;
                        best_y = yi;
                        best_z = zi;
                        best_a = ai;
                        best_b = bi;
                        best_theta = real(loop(I));
                        best_phi = imag(loop(I));
                        minR = M;
                    end
                end
            end
        end
    end
end
%%
disp('---loop complete---')
disp(best_x);
disp(best_y);
disp(best_z);
disp(best_a);
disp(best_b);
disp(best_theta);
disp(best_phi);