function timeseries = read_timeseries(file)
    %function timeseries = read_timeseries(file)
    % read_timeseries reads a file in the .series format, and returns a struct containing the time series information.
    %%
    %*.series format
    %----------------------------------------------------------------------
    %1.   2012.55030326      decimal year
    %2.   0.000000           east (m)
    %3.   0.000000           north (m)
    %4.   0.000000           vertical (m)
    %5.   0.000737           sigma E
    %6.   0.001011           sigma N
    %7.   0.003164           sigma V
    %8.   -0.010870          corr EN
    %9.   0.641253           corr EV
    %10.  -0.134228          corr NV
    %11.  396057450.00       seconds
    %12.  2012               yyyy
    %13.  7                  mm   
    %14.  20                 dd
    %15.  11                 hh
    %16.  57                 mm
    %17.  30                 ss
    %%
    %Optional arguments:
    %
    % The timeseries struct has the following elements:
    %    timeseries.time        N by 1 vector of dates (decimal year)
    %    timeseries.east        series of east values
    %    timeseries.north       series of north values
    %    timeseries.vertical    series of vertical values
    %    timeseries.sigE        series of east sigmas
    %    timeseries.sigN        series of north sigmas
    %    timeseries.sigV        series of vertical sigmas
    %%
    rawdata = new_time_series;

    if (exist(file))
        fid = fopen(file, 'r');
    else
        display(['ERROR: Cannot find file:' file]);
        return;
    end

    c = textscan(fid,'%f %f %f %f %f %f %f %f %f %f %f %d %d %d %d %d %d');
    fclose(fid);
    
    rawdata.time = c(1);
    rawdata.east = c(2);
    rawdata.north = c(3);
    rawdata.vertical = c(4);
    rawdata.sigE = c(5);
    rawdata.sigN = c(6);
    rawdata.sigV = c(7);
    %%
    timeseries = new_time_series;
    timeseries.time = cell2mat(rawdata.time);
    timeseries.east = cell2mat(rawdata.east);
    timeseries.north = cell2mat(rawdata.north);
    timeseries.vertical = cell2mat(rawdata.vertical);
    timeseries.sigE = cell2mat(rawdata.sigE);
    timeseries.sigN = cell2mat(rawdata.sigN);
    timeseries.sigV = cell2mat(rawdata.sigV);
end
