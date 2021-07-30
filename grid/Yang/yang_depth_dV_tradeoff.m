%RMSE_TYPE: 1 = all
%           2 = horizontal only
%           3 = vertical only

function CHI = yang_depth_dV_tradeoff(region, a, b, depths, volumes, data, reference, RMSE_TYPE)

Nd = length(depths);
No = length(volumes);

CHI = zeros(Nd, No);

depths = depths;

theta=0.1;   %plunge (dip) angle [deg] [90 = vertical spheroid]
phi=0;      %trend (strike) angle [deg] [0 = aligned to North]
%
% CRUST PARAMETERS
mu=26.6E9;   % shear modulus
nu=0.25;    % Poisson's ratio 


% BENCHMARKS
% x,y       benchmark location
% z         depth within the crust (z=0 is the free surface)

model = struct('ux', [], 'uy', [], 'uz', [], 'x', nan, 'y', nan);

model.x = region.x(1);
model.y = region.y(1);


for r=1:Nd
    z0= depths(r);
    if(a<z0*2)

        for q=1:No
            delta_V = volumes(q);
            
            V = 4/3 * pi * a * b^2;
            dP = ( (delta_V/V) * mu ) / ( ((b/a)^2)/3 - 0.7*(b/a) + 1.37 );

            [model.ux model.uy model.uz] = yang(model.x,model.y,z0,a,b/a,dP/mu,mu,nu,theta,phi,data.x,data.y, data.x.*0);
            
            if(isa(reference, 'struct'))
                [u_ref v_ref w_ref] = yang(model.x,model.y,z0,a,b/a,dP/mu,mu,nu,theta,phi,reference.x,reference.y,0);

                model.ux = model.ux - u_ref;
                model.uy = model.uy - v_ref;
                model.uz = model.uz - w_ref;
            end

            CHI(r,q)     = chi_squared(data, model, RMSE_TYPE);
        end
    end
end



return


