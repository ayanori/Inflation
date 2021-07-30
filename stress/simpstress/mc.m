% function value = mc(i,j)
% C = 597522;
% if j==500 || j==1 || i==500 || i==1
%     value = 0;
% elseif j == 250 && i == 250
%     value = C;
% else
%     fate = rand;
%     if fate <= 0.25
%         value = mc(i-1,j);
%     elseif fate <= 0.5
%         value = mc(i+1,j);
%     elseif fate <= 0.75
%         value = mc(i,j-1);
%     else
%         value = mc(i,j+1);
%     end
% end
clear
i = 1:100;
j = 1:100;
site = i'*j;
contourf(site);
colorbar;
