file5 = "..\data\DUTC_igs14.series";
file1 = "..\data\MAPS_igs14.series";
file2 = "..\data\MREP_igs14.series";
file3 = "..\data\MSWB_igs14.series";
file4 = "..\data\AV09_igs14.series";
files = [ file1 ; file2 ; file3 ; file4 ; file5 ];
%%
for sitenum = 1:5
    file = files(sitenum);
    rawdata = read_ts(file);
    data16 = new_ts;
    data18 = new_ts;
%%
    i = int16(1);
    while rawdata.time(i) < 2016.001
        data16.time(i,1) = rawdata.time(i);
        data16.east(i,1) = rawdata.east(i);
        data16.north(i,1) = rawdata.north(i);
        data16.vertical(i,1) = rawdata.vertical(i);
        i = i+1;
    end
    i = length(rawdata.time);
    j = int16(1);
    while rawdata.time(i) > 2017.999
        data18.time(j,1) = rawdata.time(i);
        data18.east(j,1) = rawdata.east(i);
        data18.north(j,1) = rawdata.north(i);
        data18.vertical(j,1) = rawdata.vertical(i);
        i = i-1;
        j = j+1;
    end
%%
    if 1 == 1
        sdata = data16;
        t016 = sdata.time(1);
        d = [sdata.east; sdata.north; sdata.vertical];
        A01 = [ones(size(sdata.time)) sdata.time-t016 cos(2*pi*(sdata.time-t016)) sin(2*pi*(sdata.time-t016)) cos(4*pi*(sdata.time-t016)) sin(4*pi*(sdata.time-t016))];
        o0 = zeros(size(A01));
        A = [A01 o0 o0; o0 A01 o0;o0 o0 A01];
        model16 = inv(A'*A)*A'*d;
    end
%%
    if 1 == 1
        sdata = data18;
        t018 = sdata.time(1);
        d = [sdata.east; sdata.north; sdata.vertical];
        A01 = [ones(size(sdata.time)) sdata.time-t018 cos(2*pi*(sdata.time-t018)) sin(2*pi*(sdata.time-t018)) cos(4*pi*(sdata.time-t018)) sin(4*pi*(sdata.time-t018))];
        o0 = zeros(size(A01));
        A = [A01 o0 o0; o0 A01 o0;o0 o0 A01];
        model18 = inv(A'*A)*A'*d;
    end
%%
    t16 = 2016-t016;
    east16 = model16(1) + model16(2)*t16 + model16(3)*cos(2*pi*t16) + model16(4)*sin(2*pi*t16) + model16(5)*cos(4*pi*t16) + model16(6)*sin(4*pi*t16);
    north16 = model16(7) + model16(8)*t16 + model16(9)*cos(2*pi*t16) + model16(10)*sin(2*pi*t16) + model16(11)*cos(4*pi*t16) + model16(12)*sin(4*pi*t16);
    vertical16 = model16(13) + model16(14)*t16 + model16(15)*cos(2*pi*t16) + model16(16)*sin(2*pi*t16) + model16(17)*cos(4*pi*t16) + model16(18)*sin(4*pi*t16);
    t18 = 2018-t018;
    east18 = model18(1) + model18(2)*t18 + model18(3)*cos(2*pi*t18) + model18(4)*sin(2*pi*t18) + model18(5)*cos(4*pi*t18) + model18(6)*sin(4*pi*t18);
    north18 = model18(7) + model18(8)*t18 + model18(9)*cos(2*pi*t18) + model18(10)*sin(2*pi*t18) + model18(11)*cos(4*pi*t18) + model18(12)*sin(4*pi*t18);
    vertical18 = model18(13) + model18(14)*t18 + model18(15)*cos(2*pi*t18) + model18(16)*sin(2*pi*t18) + model18(17)*cos(4*pi*t18) + model18(18)*sin(4*pi*t18);
    east0(sitenum,1) = ( east18 - east16 ) * 500.0;
    north0(sitenum,1) = ( north18 - north16 ) * 500.0;
    vertical0(sitenum,1) = ( vertical18 - vertical16 ) * 500.0;
%%
end
%%
if 1 == 1
    for sitenum = 1:4
        east(sitenum,1) = east0(sitenum,1)-east0(5,1);
        north(sitenum,1) = north0(sitenum,1)-north0(5,1);
        vertical(sitenum,1) = vertical0(sitenum,1)-vertical0(5,1);
    end
end
%%
%cell = {'MSWB',east,north,vertical};
%cell{1,:} = {'MAPS',east,north,vertical};
%cell{2,:} = {'MREP',east,north,vertical};
%cell{3,:} = {'MSWB',east,north,vertical};
%cell{4,:} = {'AV09',east,north,vertical};
%cell = {cell1{1,1},cell1{1,2},cell1{1,3},cell1{1,4};cell2{1,1},cell2{1,2},cell2{1,3},cell2{1,4};cell3{1,1},cell3{1,2},cell3{1,3},cell3{1,4};cell4{1,1},cell4{1,2},cell4{1,3},cell4{1,4}};
%writecell(cell,'1.txt','Delimiter',' ');
%%
