@echo off
set GMT_SESSION_NAME=6860
gmt begin fi11 jpg
	gmt set FONT_ANNOT 16p,1
	
	gmt grdimage @earth_relief_01s -Ctopo -I+d -JM30c -R-167.1/-166.05/53.65/54.05 -Ba15mf5m -BWSEN
	gmt coast -S115/162/178 -Lg-166.3/54+c54+w10k+f+u -W10p,115/162/178
	
	gmt velo -Se1.5c/0.95/14 -A0.1i+z1.5c+e+a60 -W3p,navy -Gnavy observedH.txt -D0.45
	gmt plot -Sv0.1i+z1.5c+e+a60 -W3p,red3 	-Gred3 	observedV.txt
	gmt plot -Sv0.1i+z1.5c+e+a60 -W3p,white -Gwhite modelH.txt
	gmt plot -Sv0.1i+z1.5c+e+a60 -W3p,black -Gblack modelV.txt
	
	gmt plot -Sc1c -W1p,black -Gred		sites.dat
	gmt plot -Sc1c -W1p,black -Gorange1	sites1.dat
	gmt plot -Sc1c -W1p,black -Ggray	sites2.dat
	gmt text SiteText.dat -F+f12p,1,white
	
	gmt psxy -SE volcano.txt -Gdarkorange1 -W3p,red
	
gmt end show
