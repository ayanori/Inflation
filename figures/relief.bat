@echo off
REM Date:    2020-08-10T10:58:52
REM User:    16095
REM Purpose: Purpose of this script
REM Set a unique session name:
set GMT_SESSION_NAME=6860
gmt begin figure1 jpg
	gmt set FONT_ANNOT 22p,1
	
	gmt grdimage @earth_relief_01s -Ctopo -I+d -JM30c -R-167.1/-166.05/53.65/54.05 -Ba15mf5m -BWSEN
	gmt coast -S115/162/178 -Lg-167/54.03+c54+w5k+f+u -W10p,115/162/178
	
	gmt plot legends.dat -W4p,lightyellow -G115/162/178 -L

	gmt velo -Se1.5c/0.95/14 -A0.1i+z1.5c+e+a60 -W3p,navy -Gnavy observedH.txt -D0.45
	gmt plot -Sv0.1i+z1.5c+e+a60 -W3p,red3 -Gred3 observedV.txt
	gmt plot -Sc1.5c -W1.5p,black -Gred sites.dat
	gmt plot -Sc1.5c -W1.5p,black -Gorange1 sites1.dat
	gmt plot -Sc1.5c -W1.5p,black -Ggray sites2.dat
	gmt text SiteText.dat -F+f20p,1,white
	gmt text -F+f22p,1,black+jL legend1.txt
	
	gmt inset begin -DjBR+w4i/2.84i+o0.15i/0.15i -F+gwhite+p1p+c0.1c
		gmt coast -R-200/-120/40/70 -JM?c -Baf -A100 -Glightyellow -S115/162/178 -N1/1p -N2/0.25p
		gmt plot -St1c -W3p,darkorange1 -Gred figure1.dat
	gmt inset end
gmt end show
