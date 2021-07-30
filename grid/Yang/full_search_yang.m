%RMSE_TYPE: 1 = all
%           2 = horizontal only
%           3 = vertical only

function [best_x, best_y, best_d, best_a, best_b, best_dV, CHI] = full_search_yang(region, depths, semimajors, semiminors, volumes, data, reference, RMSE_TYPE)

CHI = inf;

best_x = 0;
best_y = 0;
best_d = 0;
best_a = 0;
best_b = 0;
best_dV= 0;

Nx = length(region.x);
Ny = length(region.y);
Nd = length(depths);
Na = length(semimajors);
Nb = length(semiminors);
Nv = length(volumes);


% SOURCE PARAMETERS
% a         semimajor axis
% A         geometric aspect ratio [dimensionless]
% P_G       dimennsionless excess pressure (pressure/shear modulus) 
% x0,y0     surface coordinates of the center of the prolate spheroid
% z0        depth of the center of the sphere (positive downward and
%              defined as distance below the reference surface)
theta=90;   %plunge (dip) angle [deg] [90 = vertical spheroid]
phi=0;      %trend (strike) angle [deg] [0 = aligned to North]
%
% CRUST PARAMETERS
mu=26.6E9;   % shear modulus
nu=0.25;    % Poisson's ratio 

%
% BENCHMARKS
% x,y       benchmark location
% z         depth within the crust (z=0 is the free surface)

model = struct('ux', [], 'uy', [], 'uz', [], 'x', nan, 'y', nan);

for xx=1:Nx
    model.x = region.x(xx);

    for yy=1:Ny
        model.y = region.y(yy);

        for n=1:Nd
            z0= depths(n);

            for m=1:Na
                a = semimajors(m);
                if(a<z0*2)
                    for o=1:Nv
                        delta_V = volumes(o);

                        for p=1:Nb
                          b = semiminors(p);

                          %convert dV we got from cigar to dP using equations
                          %in Redoubt paper
                          %dP = ( 2*mu*(1+nu) / 3*(1-2*nu) ) * delta_V / (pi*b^2*a);
                          V = 4/3 * pi * a * b^2;
                          %dP = delta_V/V * mu;
                          dP = ( (delta_V/V) * mu ) / ( ((b/a)^2)/3 - 0.7*(b/a) + 1.37 );
                          litho=(2600*9.81*z0);
                          if (abs(dP) <= litho) %or else we get a dike
                              [model.ux model.uy model.uz] = yang(model.x,model.y,z0,a,b/a,dP/mu,mu,nu,theta,phi,data.x,data.y, data.x.*0);
    
                              if(isa(reference, 'struct'))
                                [u_ref v_ref w_ref] = yang(model.x,model.y,z0,a,b/a,dP/mu,mu,nu,theta,phi,reference.x,reference.y,0);

                                model.ux = model.ux - u_ref;
                                model.uy = model.uy - v_ref;
                                model.uz = model.uz - w_ref;
                              end

                              tmp = chi_squared(data, model, RMSE_TYPE);

                              if(tmp < CHI)
                                  CHI     = tmp;
                                  best_x  = model.x;
                                  best_y  = model.y;
                                  best_d  = z0;
                                  best_a = a;
                                  best_b = b;
                                  best_dV = delta_V;
                                  print_debug(sprintf('chi=%f:\tx=%d y=%d, z0=%d, a=%d, b=%d, dV=%f, dP=%f, litho=%f', CHI, best_x-mean(region.x), best_y-mean(region.y), z0, best_a, best_b, best_dV/1000^3, abs(dP)/1000^3, litho/1000^3));
                              end
                          end
                        end
                    end
                end
            end
        end
    end
end

return


