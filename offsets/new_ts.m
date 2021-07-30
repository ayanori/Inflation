function timeseries = new_ts
    %function timeseries = ns
    % Originally developed by J. Freymuller
    % Returns a new timeseries structure. All fields have empty values.
    %
    % The timeseries struct has the following elements:
    %    timeseries.time        N by 1 vector of dates (decimal year)
    %    timeseries.east        series of east values
    %    timeseries.north       series of north values
    %    timeseries.vertical    series of vertical values
    %    timeseries.sigE        series of east sigmas
    %    timeseries.sigN        series of north sigmas
    %    timeseries.sigV        series of vertical sigmas
 
    timeseries = struct('time', [], 'east', [], 'north', [], 'vertical', [], 'sigE', [], 'sigN', [], 'sigV', [] );
