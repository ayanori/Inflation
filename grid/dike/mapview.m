east = linspace(-40000,0);
north = linspace(-20000,20000);
for i = 1:100
    for j = 1:100
        [u,v,w] = ddisp(east(i),north(j));
        % dike(x0,y0,d,length,width,U,strike,x,y)
        disp(i,j) = hypot(u,v);
    end
end
contourf(east,north,disp');
colorbar;