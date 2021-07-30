clear;

x = linspace(-5000,5000);
y = linspace(-5000,5000);

z = linspace(0,10000);

for i = 1:100
    for j = 1:100
        % dCFS = CFS(x(i),y(j),9000);
        dCFS = CFS(x(i),y(j),0);
        secstr(i,j) = dCFS;
    end
end
sec = secstr / 100000;
contourf(x,y,sec');
colorbar;
% xlabel('y');
title('map view of dCFS (bar)')
xlabel('east');
ylabel('north');
disp(['done.']);