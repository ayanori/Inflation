%%
facRef = best_C * ( best_x*best_x+best_y*best_y+best_d*best_d )^(-2.5);
unRef(1,1) = facRef * (abs( (4*best_x*best_x+best_y*best_y+best_d*best_d)*100/best_x ) + abs( 3*best_x*best_y*100/best_y ));
unRef(1,2) = facRef * (abs( (best_x*best_x+4*best_y*best_y+best_d*best_d)*100/best_y ) + abs( 3*best_x*best_y*100/best_x ));
unRef(1,3) = facRef * 600*best_d;
%%
facSt = best_C * ( x.*x + y.*y + best_d.*best_d ).^(-2.5);
unSt(:,1) = (facSt .* (abs( (4.*x.*x+y.*y+ best_d.*best_d).*100./x ) + abs( 3.*x.*y.*100./y )))';
unSt(:,2) = (facSt .* (abs( (x.*x+4.*y.*y+ best_d.*best_d).*100./y ) + abs( 3.*x.*y.*100./x )))';
unSt(:,3) = (facSt .* 600.*best_d)';
%%
unMod(:,1) = unSt(:,1) + unRef(1,1);
unMod(:,2) = unSt(:,2) + unRef(1,2);
unMod(:,3) = unSt(:,3) + unRef(1,3);