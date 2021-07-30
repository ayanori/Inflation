clear
format long
rand('state',0);
randn('state',0);

%Global variables for use by the mcmc function calls
global x;
global y1;
global y2;
global y3;
global sigma;
global stepsize;

disp('Note: This example will take several minutes to run on most computers')

% Generate the data set.
x = [-25649.41918434133 -15665.31292542263 435.1584920527459]';
mtrue = [-22300; -3100; 5500; 520803];
% y1true = fun1(mtrue,x);
% y2true = fun2(mtrue,x);
% y3true = fun3(mtrue,x);
y1true = [-0.0026624	0.0041308	-0.0000658 ]';
y2true = [-0.002889		0.0015291	-0.000447 ]';
y3true = [0.0022859		0.0025065	-0.0009933 ]';

sigma = 0.0005 * ones(3,1);
% y = ytrue+sigma.*randn(size(ytrue));
y1 = y1true + sigma.*randn(3,1);
y2 = y2true + sigma.*randn(3,1);
y3 = y3true + sigma.*randn(3,1);

%set the MCMC parameters
%number of skips to reduce autocorrelation of models
skip=10000;
%burn-in steps
BURNIN=100000;
%number of posterior distribution samples
% N=4100000;
N = 6100000;
%MVN step size
stepsizefactor = [100;100;100;25000];
stepsize = stepsizefactor .* ones(4,1);

% We assume flat priors here
%% initialize model at a random point on [-1,1]
% m0 = (rand(4,1)-0.5)*2;
% m0 = ( rand(4,1)-0.5 ) * 10000;
m0 = mtrue + 2.5 .* stepsizefactor .* randn(4,1);
%%

[mout,mMAP,pacc]=mcmc('logprior','loglikelihood','generate','logproposal',m0,N);

%%
%
% plot autocorrelations.
%

figure(1)
clf
%plot parameter correlations
laglen=10000;
lags=(-laglen:laglen)';
acorr=zeros(2*laglen+1,4);

disp('Calculating autocorrelations for fig. 1')
for i=1:4
      acorr(:,i)=calc_corr(mout(i,:)',laglen);
end

for i=1:4
  subplot(4,1,i);
  % bookfonts;
  plot([0 laglen],[0 0],'Color',[0.7 0.7 0.7],'LineWidth',3);
  hold on
  plot(lags(laglen+1:200:laglen*2+1),acorr(laglen+1:200:laglen*2+1,i),'ko');
  hold off
  ylabel(['A ( m_',num2str(i),')'])
  ylim([-0.5 1])
  if i~=4
    set(gca,'Xticklabel',[]);
  end
  bookfonts
end
xlabel('Lag')
% bookfonts

%%
%print -depsc2 c11MCMCmcorrbefore.eps
print c11MCMCmcorrbefore.eps
%%
disp(['Displaying the autocorrelation of individual parameters before' ...
      ' thinning (fig. 1)']);

%  %track accepted new models to report acceptance rate
%  nacc=0;
%   
%   %sample the posterior here
%   for t = 2:N,
%       %calculate a candidate model
%    c=m(:,t-1)+randn(4,1).*stepsize;
%       %calculate acceptance probability for c,m(:,t-1)
%       lnprobacc=getlnprobacc(m(:,t-1),c,x,y,sigma);
%       if log(rand) < lnprobacc
%           m(:,t)=c;
%           nacc=nacc+1;
%       else
%           m(:,t)=m(:,t-1);
%       end
%   end
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

