function stre = stress_new(x,y,z)
C = 597552;
factor = ( x^2 + y^2 + z^2 )^(1.5);
stre = C * factor;