startlon = -167.05;
endlon = -166.7833333;
lons = linspace(startlon,endlon);
startlat = 53.85;
endlat = 53.916666666666667;
lats = linspace(startlat,endlat);
for i = 1:100
    for j = 1:100
        
        [x,y,z] = lld2xyz( lons(i) , (j) , 0 );
        sigma = stress(x,y,z);
        avestr(i,j) = ( sigma(1,1) + sigma(2,2) + sigma(3,3) )/3;
    end
end
%%
%contourf(lons,lats,avestr)
contourf(avestr)