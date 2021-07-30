%%
clear
rand('state',0);
randn('state',0);
disp('Note: This procedure will take about tens of minutes to run on most computers')

%% %Global variables
global x;
global y1;
global y2;
global y3;
global sigma;
global stepsize;

% Generate the data set.
x = [-25649.41918434133 -13078.24662777915 -15665.31292542263 435.1584920527459]';
mtrue=[-23700; -2000; 5205; 600000];
% y1true = fun1(mtrue,x);
% y2true = fun2(mtrue,x);
% y3true = fun3(mtrue,x);
y1true = [-2.6624	-0.5176	4.1308	-0.0658 ]';
y2true = [-2.889	-3.6317	1.5291	-0.447 ]';
y3true = [2.2859	2.7622	2.5065	-0.9933 ]';

sigma = 0.1 * ones(4,1);
% y = ytrue+sigma.*randn(size(ytrue));
y1 = y1true + sigma.*randn(4,1);
y2 = y2true + sigma.*randn(4,1);
y3 = y3true + sigma.*randn(4,1);

%set the MCMC parameters
%number of skips to reduce autocorrelation of models
skip = 5000;
%burn-in steps
BURNIN = 20000;
%number of posterior distribution samples
% N=4100000;
N = 500000;
%MVN step size
stepsizefactor = [500;500;500;100000];
stepsize = stepsizefactor .* ones(4,1);

% We assume flat priors here
%% initialize model at a random point on [space]
m0 = mtrue + 2 * stepsizefactor .* randn(4,1);
%%

[mout,mMAP,pacc]=mcmc('logprior','loglikelihood','generate','logproposal',m0,N);

%% % plot autocorrelations.
figure(1)
clf
%plot parameter correlations
laglen = 10000;
lags = (-laglen:laglen)';
acorr = zeros(2*laglen+1,4);

disp('Calculating autocorrelations for fig. 1')
for i = 1:4
      acorr(:,i) = calc_corr(mout(i,:)',laglen);
end

for i = 1:4
  subplot(4,1,i);
  bookfonts;
  plot([0 laglen],[0 0],'Color',[0.7 0.7 0.7],'LineWidth',3);
  hold on
  plot(lags(laglen+1:200:laglen*2+1),acorr(laglen+1:200:laglen*2+1,i),'ko');
  hold off
  ylabel(['A ( m_',num2str(i),')'])
  ylim([-0.5 1])
  if i ~= 4
    set(gca,'Xticklabel',[]);
  end
  bookfonts
end
xlabel('Lag')
bookfonts

%%
%print -depsc2 c11MCMCmcorrbefore.eps
print c11MCMCmcorrbefore.eps
%%
disp(['Displaying the autocorrelation of individual parameters before' ...
      ' thinning (fig. 1)']);

%  %track accepted new models to report acceptance rate

disp(['Acceptance Rate: ',num2str(pacc)]);
  
%downsample results to reduce correlation
k=(BURNIN:skip:N);
 
mskip=mout(:,k);
  
%histogram results, and find the modes of the subdistributions as an
%estimte of the MAP model
disp(['m_map','  m_true'])
[mMAP,mtrue]
 
% estimate the 95% credible intervals
for i=1:4
  msort=sort(mskip(i,:));
  m2_5(i) = msort(round(2.5/100*length(mskip)));
  m97_5(i) =  msort(round(97.5/100*length(mskip)));
  disp(['95% confidence interval for m', num2str(i),' is [', num2str(m2_5(i)),',', num2str(m97_5(i)),']'])
end