if( 1 == 1 )
    format long
    clear;

% iflag = 1;
    iflag = 2;
% 1 for MREP_in, 2 for MREP_not_in

    init;
    locate;
    getC;

% fid1 = fopen('MREP_in.txt','w');
    fid1 = fopen('MREP_not_in.txt','w');
    fprintf ( 1, ' Best x : %10i  \n' , best_x);
    fprintf ( fid1, ' Best x : %10i  \n' , best_x);
    fprintf ( 1, ' Best y : %10i  \n' , best_y);
    fprintf ( fid1, ' Best y : %10i  \n' , best_y);
    fprintf ( 1, ' Best d : %10i  \n' , best_d);
    fprintf ( fid1, ' Best d : %10i  \n' , best_d);
    fprintf ( 1, ' Best C : %10i  \n' , best_C);
    fprintf ( fid1, ' Best C : %10i  \n' , best_C);

% no MREP: -22200 -3150 5200 490280
% MREP: -22150 -1400 4350 585656
end