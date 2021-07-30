% to draw the contour plot of the Coulomb stress change on a certain section
clear;
x = linspace(-5000,5000);
y = linspace(-5000,5000);
z = linspace(0,10000);
if( 1 == 1 )
    for i = 1:100
        for j = 1:100
            dCFS = CFS(x(i),300,z(j));
            secstr(i,j) = dCFS;
        end
    end
    sec = secstr / 100000;
    contourf(x,z,sec');
    colorbar;
    title('E-V section view of dCFS (bar)')
    xlabel('east');
    ylabel('depth');
end
if( 1 == 2 )
    for i = 1:100
        for j = 1:100
            dCFS = CFS(x(i),y(j),0);
            secstr(i,j) = dCFS;
        end
    end
    sec = secstr / 100000;
    contourf(x,y,sec');
    colorbar;
    title('map view of dCFS (bar)')
    xlabel('east');
    ylabel('north');
end
disp(['Drawing completed. Please check figure1.']);