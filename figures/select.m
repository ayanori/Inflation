%%
clear;
format long;
%%
sfile='section.txt';
load(sfile);

lon = section(:,1); height = section(:,2);
%%
% flag = 0; nflag = 0;
% nsites = length(lon);
% for isite = 1:nsites
%     if( abs(es(isite)) > 10 | abs(ns(isite)) > 10 )
%         nflag = nflag+1;
%         continue
%     end
%     flag = flag+1;
%     a(flag,1) = lon(isite);
%     b(flag,1) = lat(isite);
%     c(flag,1) = es(isite);
%     d(flag,1) = ns(isite);
% end
% EN_new = [a b c d];
% writematrix(EN_new);
%%
x = [ -166.8877417052913 -166.9053157620627 -166.9053157620627];
y = [-5200 -6800 -5800];


%%
plot(lon,height,'linewidth',2);
ylim([-9750 2000]);
hold on
scatter(x,y,'filled');

rectangle('Position',[-166.9286377854486,-9547.9326,0.098284715744966,4824.6736],'Curvature',[1,1],'linewidth',1.5,'edgecolor',[0.93 0.69 0.13]);

xlabel('Longitude (deg)');
ylabel('Altitude (m)');
yticks([-8000 -6000 -4000 -2000 0 2000]);
texts = {' 2016-2018 inflation, grid search',' 1993-1995 inflation, Lu et al',' 2002-2010 deflation, Lu et al'};
text(x,y,texts);
text(-166.825,-8000,' 2016-2018 inflation, MCMC')


