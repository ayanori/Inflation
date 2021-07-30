% save('temp.mat','mskip','m2_5','m97_5');
% clear;
% load('temp.mat');
% format long
% 
% len = size(mskip);
% j = 1;
% for i = 1:len(2)
%     if (mskip(1,i)<m2_5(1)) || (mskip(1,i)>m97_5(1)) || (mskip(2,i)<m2_5(2))...
%             || (mskip(2,i)>m97_5(2)) || (mskip(3,i)<m2_5(3)) || (mskip(3,i)>m97_5(3))...
%             || (mskip(4,i)<m2_5(4)) || (mskip(4,i)>m97_5(4))
%         continue;
%     else
%         m95(:,j) = mskip(:,i);
%         j = j+1;
%     end
% end
% 
% E = [ -25649.41918434133 -13078.24662777915 -15665.31292542263 435.15849205275 ]';
% N = [ -10752.69397678629 -10586.49644710857 1073.96020849975 -3259.38055764152 ]';
% len95 = size(m95);
% for i = 1:len95(2)
%     x = E - m95(1,i);
%     y = N - m95(2,i);
%     [dx,dy,dz] = mogi1(x,y,m95(3,i),m95(4,i));
%     [dxRef,dyRef,dzRef] = mogi1(-m95(1,i),-m95(2,i),m95(3,i),m95(4,i));
%     mp95(i,:,:) = [dx-dxRef,dy-dyRef,dz-dzRef];
% end


e1 = mp95(:,1,1);
n1 = mp95(:,1,2);
plot(e1,n1,'k.');
hold on
k = boundary(e1,n1,0.01);
plot(e1(k),n1(k));

clear x

F = @(p,x) p(1)*x(:,1).^2 + p(2)*x(:,1).*x(:,2) + p(3)*x(:,2).^2 + p(4)*x(:,1) + p(5)*x(:,2) + 1;

x = [e1(k),n1(k)];
p0 = [1, 1, 1, 1, 1];

p=nlinfit(x, zeros(size(x, 1), 1), F, p0);

xmin = min(x(:, 1));
xmax = max(x(:, 1));
ymin = min(x(:, 2));
ymax = max(x(:, 2));

ezplot(@(x, y) F(p, [x, y]), [xmin, xmax+0.0001, ymin, ymax]);

plot([0 -0.00200244689],[0 -0.003449607853],'LineWidth',2)
% annotation('textarrow',[0 -0.00200244689],[0 -0.003449607853]);

% xlim([ -0.0031 0.0002 ])
% ylim([ -0.0049 0.0002 ])
axis equal

% -2.002446888103653  -3.449607853391742
% 0.853752485478001  -1.582473774790551
% 2.643891851288565   1.553858968747210
% -0.020059355594491  -0.127208192992409




            
            


