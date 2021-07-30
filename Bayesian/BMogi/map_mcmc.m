%% %plot a scatter plot and histogram of the posterior distribution
mlims  = [-22200 -19750; -3400 1600; 100 4000; 600000 925000];
mtrue=[-0008.91; 110.38886; 1150.33; 896997];

figure(2)
clf
for i=1:4
  for j=1:4
    subplot(4,4,4*(i-1)+j)
    if i==j
      hist(mskip(i,:));
      h = findobj(gca,'Type','patch');
      set(h,'FaceColor','k')
      set(gca,'Yticklabel',[]);
      xlim(mlims(i,:));
      bookfonts
    else
      plot(mskip(j,:),mskip(i,:),'k.','Markersize',6,'Color',[0.6 0.6 0.6]);
      hold on
      % plot the true answer as a large black dot
      plot(mtrue(j),mtrue(i),'k.','Markersize',24);
      % plot the accepted answers as gray dots
      plot(mMAP(j),mMAP(i),'ko','Markersize',12,'LineWidth',3);
      % plot the 95% ci as a box
      plot([m2_5(j),m97_5(j)],[m2_5(i),m2_5(i)],'k-','LineWidth',1);
      plot([m2_5(j),m97_5(j)],[m97_5(i),m97_5(i)],'k-','LineWidth',1);
      plot([m2_5(j),m2_5(j)],[m2_5(i),m97_5(i)],'k-','LineWidth',1);
      plot([m97_5(j),m97_5(j)],[m2_5(i),m97_5(i)],'k-','LineWidth',1);
      xlim(mlims(j,:));
      ylim(mlims(i,:));
      bookfonts
      hold off
    end
  end
end

subplot(4,4,1)
ylabel('m_1')
bookfonts
subplot(4,4,5)
ylabel('m_2')
bookfonts
subplot(4,4,9)
ylabel('m_3')
bookfonts
subplot(4,4,13)
ylabel('m_4')
bookfonts
subplot(4,4,13)
xlabel('m_1')
bookfonts
subplot(4,4,14)
xlabel('m_2')
bookfonts
subplot(4,4,15)
xlabel('m_3')
bookfonts
subplot(4,4,16)
xlabel('m_4')
bookfonts

print -depsc2 c11MCMCscat.eps
disp('Displaying the true parameters, thinned points, and 95% confidence intervals (fig. 2)');

%plot parameter sample histories
% figure(3)
% clf
% for i=1:4
%   subplot(4,1,i)
%   plot([1 length(mskip)],[mtrue(i) mtrue(i)],'Color',[0.6 0.6 0.6],'LineWidth',3);
%   hold on
%   plot(mskip(i,:),'ko')
%   hold off
%   if i~=4
%     set(gca,'Xticklabel',[]);
%   end
%   xlim([1 length(mskip)])
% end
% xlabel('Sample Number')
% subplot(4,1,1)
% ylabel('m_1')
% bookfonts
% subplot(4,1,2)
% ylabel('m_2')
% bookfonts
% subplot(4,1,3)
% ylabel('m_3')
% bookfonts
% subplot(4,1,4)
% ylabel('m_4')
% bookfonts
% 
% print -depsc2 c11MCMCmhist.eps
% disp('Displaying the true parameters and thinned sample histories (fig. 3)');
% 
% %plot parameter correlations
% figure(4)
% clf
% laglen=50;
% lags=(-laglen:laglen)';
% acorr=zeros(2*laglen+1,4);
% for i=1:4
%   acorr(:,i)=calc_corr(mskip(i,:)',laglen);
%   subplot(4,1,i);
%   plot([0 laglen],[0 0],'Color',[0.7 0.7 0.7],'LineWidth',3);
%   hold on
%   plot(lags(laglen+1:laglen*2+1),acorr(laglen+1:laglen*2+1,i),'ko');
%   hold off
%   ylabel(['A ( m_',num2str(i),')'])
%   ylim([-0.5 1])
%    bookfonts
%   if i~=4
%     set(gca,'Xticklabel',[]);
%   end
% end
% xlabel('Lag')
% bookfonts
% print -depsc2 c11MCMCmcorr.eps
% disp('Displaying the autocorrelation of thinned parameter samples (fig. 4)');