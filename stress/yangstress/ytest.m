clear;

e = linspace(-8000,8000);
n = linspace(-8000,8000);
v = linspace(0,4000);

for i = 1:100
    for j = 1:100
        [ux,uy,uz] = ydisp(e(i),n(j),0);
        sec(i,j) = hypot(ux,uy);
    end
end

contourf(e,n,sec');
colorbar;