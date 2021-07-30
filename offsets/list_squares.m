% To calculate fitting coefficients using least squares.
% This script does all computations in meters.
%%
clear;
%%
file1 = '..\data\MAPS_igs14.series';
file2 = '..\data\MREP_igs14.series';
file3 = '..\data\MSWB_igs14.series';
file4 = '..\data\AV09_igs14.series';
file0 = '..\data\DUTC_igs14.series';
%%
if 1 == 1
    %file = file4;
    %sdata = read_time_series(file);
    sdata = select_reference(file1,file0);
%%
    t0 = sdata.time(1);
    d = [sdata.east; sdata.north; sdata.vertical];
    % sigs = [sdata.sigE; sdata.sigN; sdata.sigV].^2;
    % W = diag(1./sigs, 0);
    A01 = [ones(size(sdata.time)) sdata.time-t0 cos(2*pi*(sdata.time-t0)) sin(2*pi*(sdata.time-t0)) cos(4*pi*(sdata.time-t0)) sin(4*pi*(sdata.time-t0))];
    o0 = zeros(size(A01));
    A = [A01 o0 o0; o0 A01 o0;o0 o0 A01];
    % model = inv(A'*W*A)*A'*W*d;
    model = inv(A'*A)*A'*d;
%%
    model_d = A*model;
    len=length(sdata.time);
    fitdata=sdata;
    fitdata.east  =model_d(0*len+1:1*len);
    fitdata.north =model_d(1*len+1:2*len);
    fitdata.vertical=model_d(2*len+1:3*len);
%%
    %out = [fitdata.time,fitdata.east,fitdata.north,fitdata.vertical];
    %writematrix(out,'..\data\MSWB.txt','Delimiter',' ');
    %writematrix(out,'..\data\MSWB_AV09.txt','Delimiter',' ');
end
disp(len);
%disp(1000.*model);
%%
out = 1000.*model;
realout = [ out(2) ; out(8) ; out(14) ];
disp(realout);
%writematrix(out,'..\data\1.txt','Delimiter',' ');
%%
if(1 == 1)
    resid = d - model_d;
    sig(1) = std(resid(0*len+1:1*len));
    sig(2) = std(resid(1*len+1:2*len));
    sig(3) = std(resid(2*len+1:3*len));
    disp(sig*500);
end
