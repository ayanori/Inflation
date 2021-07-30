% originally from Parameter Estimation and Inverse Problems, 3rd edition, 2018
% by R. Aster, B. Borchers, C. Thurber
%
% make sure we have a clean environment
clear
format long
rand('state',0);
randn('state',0);
% 
fidrun = fopen('sd_running.txt','w');

%Global variables for use by the mcmc function calls
global x;
% global y;
global y1;
global y2;
global y3;
global sigma;
global stepsize;

disp('Note: This example will take several minutes to run on most computers. Started at');
fprintf (fidrun,'Note: This example will take several minutes to run on most computers. Started at');
disp( fix(clock) );
fprintf( fidrun , '%d %d %d %d %d\n',fix(clock) );

% Generate the data set.
x = [-25649.41918434133 -13078.24662777915 -15665.31292542263 435.1584920527459]';
mtrue=[ -22000 ; -2500 ; 5500 ; 101 ; 7850 ; 0.0000005 ; 66 ; 35 ];
y1true = [-0.0026624	-0.0005176	0.0041308	-0.0000658 ]';
y2true = [-0.002889	-0.0036317	0.0015291	-0.000447 ]';
y3true = [0.0022859	0.0027622	0.0025065	-0.0009933 ]';

sigma = 0.1 * ones(4,1);
y1 = y1true + sigma.*randn(4,1);
y2 = y2true + sigma.*randn(4,1);
y3 = y3true + sigma.*randn(4,1);

%set the MCMC parameters
%number of skips to reduce autocorrelation of models
skip = 10000;
%burn-in steps
BURNIN = 20000;
%number of posterior distribution samples
% N=4100000;
N = 4100000;
%MVN step size
% stepsize = 0.005*ones(4,1);
% stepsizefactor = [250;250;250;100;100;100000000;0.01;0.01];
stepsizefactor = [500;500;500;10;250;0.000005;5;5];
stepsize = stepsizefactor .* ones(8,1);

% We assume flat priors here
%% initialize model at a random point on [-1,1]
% m0 = (rand(4,1)-0.5)*2;
% m0 = ( rand(4,1)-0.5 ) * 10000;

m0 = mtrue + 5 .* stepsizefactor .* randn(8,1);
%%

[mout,mMAP,pacc] = mcmc('logprior','loglikelihood','generate','logproposal',m0,N);

%%
%
% plot autocorrelations.
%
figure(1)
clf
%plot parameter correlations
laglen=10000;
lags=(-laglen:laglen)';
acorr=zeros(2*laglen+1,8);

disp('Calculating autocorrelations for fig. 1');
fprintf( fidrun , 'Calculating autocorrelations for fig. 1' );
for i = 1:8
      acorr(:,i) = calc_corr(mout(i,:)',laglen);
end

for i=1:8
  subplot(8,1,i);
  % bookfonts;
  plot([0 laglen],[0 0],'Color',[0.7 0.7 0.7],'LineWidth',3);
  hold on
  plot(lags(laglen+1:200:laglen*2+1),acorr(laglen+1:200:laglen*2+1,i),'ko');
  hold off
  ylabel(['A ( m_',num2str(i),')'])
  ylim([-0.5 1])
  if i~=8
    set(gca,'Xticklabel',[]);
  end
  % bookfonts
end
xlabel('Lag')
% bookfonts

%%
%print -depsc2 c11MCMCmcorrbefore.eps
print c11MCMCmcorrbefore.eps
%%
disp(['Displaying the autocorrelation of individual parameters before' ...
      ' thinning (fig. 1)']);

disp(['Acceptance Rate: ',num2str(pacc)]);
% fprintf(fidrun,'Acceptance Rate: %s',num2str(pacc));
  
%downsample results to reduce correlation
k = (BURNIN:skip:N);
 
mskip = mout(:,k);
  
%histogram results, and find the modes of the subdistributions as an
%estimte of the MAP model
disp(['m_map','  m_true'])
[mMAP,mtrue]
 
% estimate the 95% credible intervals
for i=1:8
  msort=sort(mskip(i,:));
  m2_5(i) = msort(round(2.5/100*length(mskip)));
  m97_5(i) =  msort(round(97.5/100*length(mskip)));
  disp(['95% confidence interval for m', num2str(i),' is [', num2str(m2_5(i)),',', num2str(m97_5(i)),']'])
  % fprintf( fidrun,'95% confidence interval for m %s is [ %s , %s ]',num2str(i),num2str(m2_5(i)),num2str(m97_5(i)) );
end

