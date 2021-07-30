%plot a scatter plot and histogram of the posterior distribution
% mtrue=[-23000; -2500; 4700; 500; 300; 3600000000; 0.01; 0.73->42];
% mtrue=[ -23000 ; -2500 ; 5500 ; 101 ; 7850 ; 0.0000005 ; 66 ; 35 ];
mlims  = [-25000 -14000; -3600 3900; 2200 9900; 0 540; 0 14500; 0.0000000001 0.000001; 7 175; 0 82];

figure(2)
clf
for i=1:8
  for j=1:8
    subplot(8,8,8*(i-1)+j)
    if i==j
      hist(mskip(i,:));
      h = findobj(gca,'Type','patch');
      set(h,'FaceColor','k')
      set(gca,'Yticklabel',[]);
      xlim(mlims(i,:));
      % bookfonts
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
      % bookfonts
      hold off
    end
  end
end

subplot(8,8,1)
ylabel('m_1')
% bookfonts
subplot(8,8,9)
ylabel('m_2')
% bookfonts
subplot(8,8,17)
ylabel('m_3')
% bookfonts
subplot(8,8,25)
ylabel('m_4')
% bookfonts
subplot(8,8,33)
ylabel('m_5')
subplot(8,8,41)
ylabel('m_6')
subplot(8,8,49)
ylabel('m_7')
subplot(8,8,57)
ylabel('m_8')
subplot(8,8,57)
xlabel('m_1')
% bookfonts
subplot(8,8,58)
xlabel('m_2')
% bookfonts
subplot(8,8,59)
xlabel('m_3')
% bookfonts
subplot(8,8,60)
xlabel('m_4')
% bookfonts
subplot(8,8,61)
xlabel('m_5')
subplot(8,8,62)
xlabel('m_6')
subplot(8,8,63)
xlabel('m_7')
subplot(8,8,64)
xlabel('m_8')

print -depsc2 c11MCMCscat.eps
disp('Displaying the true parameters, thinned points, and 95% confidence intervals (fig. 2)');

%plot parameter sample histories
figure(3)
clf
for i=1:4
  subplot(4,1,i)
  plot([1 length(mskip)],[mtrue(i) mtrue(i)],'Color',[0.6 0.6 0.6],'LineWidth',3);
  hold on
  plot(mskip(i,:),'ko')
  hold off
  if i~=4
    set(gca,'Xticklabel',[]);
  end
  xlim([1 length(mskip)])
end
xlabel('Sample Number')
subplot(8,1,1)
ylabel('m_1')
% bookfonts
subplot(8,1,2)
ylabel('m_2')
% bookfonts
subplot(8,1,3)
ylabel('m_3')
% bookfonts
subplot(8,1,4)
ylabel('m_4')
% bookfonts
subplot(8,1,5)
ylabel('m_5')
% bookfonts
subplot(8,1,6)
ylabel('m_6')
% bookfonts
subplot(8,1,7)
ylabel('m_7')
% bookfonts
subplot(8,1,8)
ylabel('m_8')
% bookfonts

print -depsc2 c11MCMCmhist.eps
disp('Displaying the true parameters and thinned sample histories (fig. 3)');

%plot parameter correlations
figure(4)
clf
laglen=50;
lags=(-laglen:laglen)';
acorr=zeros(2*laglen+1,4);
for i=1:8
  acorr(:,i)=calc_corr(mskip(i,:)',laglen);
  subplot(8,1,i);
  plot([0 laglen],[0 0],'Color',[0.7 0.7 0.7],'LineWidth',3);
  hold on
  plot(lags(laglen+1:laglen*2+1),acorr(laglen+1:laglen*2+1,i),'ko');
  hold off
  ylabel(['A ( m_',num2str(i),')'])
  ylim([-0.5 1])
   % bookfonts
  if i~=8
    set(gca,'Xticklabel',[]);
  end
end
xlabel('Lag')
% bookfonts
print -depsc2 c11MCMCmcorr.eps
disp('Displaying the autocorrelation of thinned parameter samples (fig. 4)');
fix(clock)