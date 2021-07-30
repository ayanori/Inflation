clear;
% x = linspace(-1000,1000);
x = linspace(-1500,1500);
y = linspace(-1500,1500);
% d = linspace(0,2000);
z = linspace(3000,6000);
% d = 5200 - z;
% for i = 1:100
%     for j = 1:100
%         for k = 1:100
%         sigma = ystress(x(i),y(j),d(k));
%         avestr(i,j,k) = ( sigma(1,1) + sigma(2,2) + sigma(3,3) )/3;
%         % avestr(i,j,k) = abs( (sigma(1,1) + sigma(2,2) + sigma(3,3) )/3 );
%         % avestr(i,j,k) = sigma(3,3);
%         end
%         process = ((i-1)*100+j)/100;
%         disp(['process: ' num2str(process) ' %']);
%     end
% end
% for i = 1:100
%     for k = 1:100
%         % secstr(i,k) = avestr(i,k,1);
%         secstr(i,k) = avestr(i,20,k);
%     end
% end
for i = 1:100
    for j = 1:100
        sigma = ystress(x(i),y(j),6200);
        secstr(i,j) = sigma(1,1) + sigma(2,2) + sigma(3,3);
        % secstr(i,j) = sigma(2,2);
    end
end
contourf(x,y,secstr');
colorbar;
% xlabel('y');
xlabel('x');
ylabel('y');
disp(['done.']);