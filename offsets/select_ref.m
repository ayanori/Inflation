function subtract = select_ref(s_file,r_file)

    station = read_time_series(s_file);
    reference = read_time_series(r_file);

    lens = length(station.time);
    lenr = length(reference.time);
    
    subtract = new_time_series;
    n = int16(1);
    for i = 1:lens
        for j = 1:lenr
            if abs( station.time(i) - reference.time(j) )<0.0014
                subtract.time(n,1) = station.time(i);
                subtract.east(n,1) = station.east(i) - reference.east(j);
                subtract.north(n,1) = station.north(i) - reference.north(j);
                subtract.vertical(n,1) = station.vertical(i) - reference.vertical(j);
                % subtract.sigE(n,1) = sqrt(station.sigE(i)^2 + reference.sigE(j)^2);
                % subtract.sigN(n,1) = sqrt(station.sigN(i)^2 + reference.sigN(j)^2);
                % subtract.sigV(n,1) = sqrt(station.sigV(i)^2 + reference.sigV(j)^2);
                n = n+1;
            end
        end
    end
    disp('--------Information: Selection complete!--------');
    end
