% xs = linspace(-3000,3000);
% y = 10;
% ds = linspace(6000,0);
% zs = 5205 - ds;
% for i = 1:100
%     for j = 1:100
%         sigma = stress(xs(i),y,zs(j));
%         avestr(j,i) = ( sigma(1,1) + sigma(2,2) + sigma(3,3) )/3;
%     end
% end
% %%
% contourf(xs,ds,avestr)
% colorbar;

% startr = -1000;
% endr = 1000;
% rs = linspace(startr,endr);
% depths = linspace(6000,0);
% ds = 5205 - depths;
% for i = 1:100
%     for j = 1:100
%         sigma = stress(rs(i),ds(j));
%         avestr(j,i) = ( sigma(1,1) + sigma(2,2) + sigma(3,3) )/3;
%     end
% end
% % contourf(avestr);
% dds = - depths;
% contourf(rs,dds,avestr);
% colorbar;

x = linspace(-1000,1000);
d = linspace(0,2000);
z = 5205 - d;
for i = 1:100
    for j = 1:100
        sigma = stress(x(i),0,z(j));
        % avestr(j,i) = ( sigma(1,3) + sigma(2,3) + sigma(1,2) )/3;
        avestr(j,i) = sigma(1,1);
    end
end
contourf(x,-d,avestr);
colorbar;