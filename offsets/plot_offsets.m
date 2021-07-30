figure('Color','white');
%%
ax1 = subplot('Position',[0.1,0.62,0.875,0.23]);
x = sdata.time;
y1 = 1000.*sdata.east;
y2 = 1000.*fitdata.east;
p=plot(x,y1,'k.',x,y2,'r');
p(2).LineWidth = 2;
xticklabels({});
ylabel('East (mm)');
%text(0.675,1.075,'Motion rate: -7.00 mm/yr','Units','normalized','Color','r');
text(0.675,1.075,'Motion rate: -1.09±0.13 mm/yr','Units','normalized','Color','r');
%title({'2521 daily solutions (2012.55 \sim 2020.54) | Lat: 53.8096\circ, Lon: -166.7483\circ, Elev: 786.70 m';''});
%title({'2231 daily solutions (2012.55 \sim 2020.28) | Lat: 53.8096\circ, Lon: -166.7483\circ, Elev: 786.70 m';''});
%title({'2443 daily solutions (2011.58 \sim 2019.99) | Lat: 53.9147\circ, Lon: -166.7879\circ, Elev: 431.10 m';''});
title({'1969 daily solutions (2013.62 \sim 2020.47) | Lat: 53.8081\circ, Lon: -166.9405\circ, Elev: 331.80 m';''});
%%
ax2 = subplot('Position',[0.1,0.36,0.875,0.23]);
x = sdata.time;
y1 = 1000.*sdata.north;
y2 = 1000.*fitdata.north;
p=plot(x,y1,'k.',x,y2,'r');
p(2).LineWidth = 2;
xticklabels({});
ylabel('North (mm)');
text(0.675,1.075,'Motion rate: -1.12±0.09 mm/yr','Units','normalized','Color','r');
%text(0.675,1.075,'Motion rate: -0.68 mm/yr','Units','normalized','Color','r');
%%
ax3 = subplot('Position',[0.1,0.1,0.875,0.23]);
x = sdata.time;
y1 = 1000.*sdata.vertical;
y2 = 1000.*fitdata.vertical;
p=plot(x,y1,'k.',x,y2,'r');
p(2).LineWidth = 2;
%text(0.675,1.075,'Motion rate: 3.92 mm/yr','Units','normalized','Color','r');
text(0.675,1.075,'Motion rate: 1.23±0.63 mm/yr','Units','normalized','Color','r');
%%
xlabel('Decimal Year');
ylabel('Up (mm)');
%sgtitle('Station MSWB in ITRF14');
sgtitle('Station MAPS relative to site DUTC');
