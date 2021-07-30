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
    file = file1;
    sdata = read_time_series(file);
    len=length(sdata.time);
%%
    % flag = 0;
%%
    %t0 = sdata.time(1);
    %d = [sdata.east; sdata.north; sdata.vertical];
    %sigs = [sdata.sigE; sdata.sigN; sdata.sigV].^2;
    %W = diag(1./sigs, 0);
    %A01 = [ones(size(sdata.time)) sdata.time-t0 cos(2*pi*(sdata.time-t0)) sin(2*pi*(sdata.time-t0)) cos(4*pi*(sdata.time-t0)) sin(4*pi*(sdata.time-t0))];
    %o0 = zeros(size(A01));
    %A = [A01 o0 o0; o0 A01 o0;o0 o0 A01];
    %model = inv(A'*W*A)*A'*W*d;
%%
    uncerE = abs( sdata.sigE ./ sdata.east );
    uncerN = abs( sdata.sigN ./ sdata.north );
    uncerV = abs( sdata.sigV ./ sdata.vertical );
    for i = len-1:-1:1
        if( uncerE(i) > 5 )
            uncerE(i) = uncerE(i+1);
            % flag = flag + 1;
            % temp(flag) = sdata.time(i);
        end
        if( uncerN(i) > 5 )
            uncerN(i) = uncerN(i+1);
        end
        if( uncerV(i) > 5 )
            uncerV(i) = uncerV(i+1);
        end
    end
    uncert = [ sum(uncerE)/len , sum(uncerN)/len , sum(uncerV)/len ];
end
if 2 == 2
    file = file0;
    sdata = read_time_series(file);
    len=length(sdata.time);
%%
    uncerE = abs( sdata.sigE ./ sdata.east );
    uncerN = abs( sdata.sigN ./ sdata.north );
    uncerV = abs( sdata.sigV ./ sdata.vertical );
    % for i = 1:len
    for i = len-1:-1:1
        if( uncerE(i) > 5 )
            uncerE(i) = uncerE(i+1);
        end
        if( uncerN(i) > 5 )
            uncerN(i) = uncerN(i+1);
        end
        if( uncerV(i) > 5 )
            uncerV(i) = uncerV(i+1);
        end
    end
    uncert0 = [ sum(uncerE)/len , sum(uncerN)/len , sum(uncerV)/len ];
end
uncerta = hypot(uncert,uncert0);
display(uncerta);
%%

%writematrix(out,'..\data\1.txt','Delimiter',' ');

