clear;
% x = linspace(-1000,1000);
x = linspace(-5000,5000);
y = linspace(-5000,5000);
% d = linspace(0,2000);
% z = linspace(4700,4900);

for i = 1:100
    for j = 1:100
        ds = ystress(x(i),y(j),5000);
        secstr(i,j) = ds(1,2);
    end
end
% sec = secstr / 1000000000;
contourf(x,y,secstr');
colorbar;
% xlabel('y');
xlabel('east');
ylabel('north');
disp(['done.']);