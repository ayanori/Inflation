% Grid search. Inversion to dike source.
clear;
format long
disp('This may take several quarters on most computers.');
fix(clock)
%% Non-linear Part
% All calculation works in SI units except those printed out.
%%
% function inside [u,v,w] = dike(x0,y0,d,length,width,U,strike,x,y)
% a         semimajor [m]
% b         semiminor [m]
% x,y       coordinates of the point(s) where the displacement is computed [m]
% x0,y0     coordinates of the center of the dike (positive downward) [m]
% strike    trend angle [digree]
% 
% u,v,w     displacement 
%%
disp('---process started successfully, initializing---');
xs = [-25649.41918434133 -13078.24662777915 -15665.31292542263 435.1584920527459]';
ys = [-10752.69397678629, -10586.49644710857, 1073.960208499746, -3259.380557641519]';
% zs = [-225.2999597793727, -680.1999901627641, -324.5999964253786, 0.8227587787353]';
Dx = [-0.0026624	-0.0005176	0.0041308	-0.0000658 ]';
Dy = [-0.002889	-0.0036317	0.0015291	-0.000447 ]';
Dz = [0.0022859	0.0027622	0.0025065	-0.0009933 ]';
Ds0 = [Dx, Dy, Dz];
% Ds0 = [Dx, Dy, Dz];
% Ds = Ds0 / Ds0(1,1);
%%
wid = [10 50 100 500 1000 5000];
len = [1 5 10 50 100 500 1000];
U = [ 0.0000001 0.0000005 0.000001 0.000005 0.00001 0.0001 0.001 0.1];
%%
% x = -23000
% y = -2000
% depth = 5500;
    for dip = 5:10:85
            for le = 1:7
                for wi = 100:250:8000
                    for Ui = 1:8
                    % parfor i = 1:49770
                        for strike = 31:5:181
                            [ur,vr,wr] = dike1(-23000,-2000,5500,len(le),wid(wi),U(Ui),strike,dip,xs,ys);
                            [u0,v0,w0] = dike1(-23000,-2000,5500,len(le),wid(wi),U(Ui),strike,dip,0,0);
                            %%
                            us0 = [ur-u0, vr-v0, wr-w0];
                            %%
                            % us = us0 / us0(1,1);
                            % R = us - Ds;
                            %%
                            R = us0 - Ds0; 
                            M = norm(R);
                        % [M,I] = min(Nn);
                            if M < minR
                                best_len = len(le);
                                % best_wid = leni*wl(wi);
                                best_wid = wid(wi);
                                best_strike = strike;
                                best_U = U(Ui);
                                best_dip = dip;
                                minR = M;
                            end
                        end
                    end
                end
            end
    end
%%
disp('---loop complete---')
% disp([best_x best_y best_d best_len best_wid best_strike best_U]);
disp('best_len best_wid best_strike best_dip best_U');
disp([best_len best_wid best_strike best_dip best_U]);
fix(clock)
