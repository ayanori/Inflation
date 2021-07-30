% Example 11.4
% from Parameter Estimation and Inverse Problems, 3rd edition, 2018
% by R. Aster, B. Borchers, C. Thurber
%
% computes the forward problem y=p(1)*exp(p(2)*x)+p(3)*x*exp(p(4)*x)
% 
% from Parameter Estimation and Inverse Problems, 2nd edition, 2011
% by R. Aster, B. Borchers, C. Thurber
function y=fun(m,x)
% y=m(1).*exp(m(2)*x)+m(3).*x.*exp(m(4)*x);
% y(1,1) = m(4) * ( (x(1,1)-m(1))/sqrt( (x(1,1)-m(1))^2 + (x(2,1)-m(2))^2 + m(3)^2 ) - (x(1,1)-m(1))/sqrt( (x(1,1)-m(1))^2 + (x(2,1)-m(2))^2 + m(3)^2 ) );
% mtrue=[-23700; -2000; 5205; 597306];
% a(1) = m(1) * (-40000);
% a(2) = m(2) * 4000;
% a(3) = m(3) * 10000;
% a(4) = m(4) * (-1000000);
% 0.5925 0.5 0.5205 0.597306
% y = a(4) .* ( (x-a(1))./(sqrt( (x-a(1)).^2 + (x2x(x)-a(2)).^2 + a(3).^2 )).^3 + a(1)./(sqrt( a(1).^2 + a(2).^2 + a(3).^2 )).^3 );
for i = 1:4
    y(i,1) = m(4) * ( (x(i)-m(1))*( (x(i)-m(1))^2 + (x2x(x(i))-m(2))^2 + m(3)^2 )^(-1.5) ...
        + m(1)*( m(1)^2 + m(2)^2 + m(3)^2 )^(-1.5) );
end