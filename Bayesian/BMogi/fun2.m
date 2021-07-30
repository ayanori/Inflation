function y = fun2(m,x)
% function y = fun1(m,x)
y = zeros(3,1);
x2 = x2x(x);
for i = 1:3
    y(i,1) = m(4) * ( ( x2(i) - m(2) )*( (x(i)-m(1))^2 + ( x2(i) - m(2) )^2 + m(3)^2 )^(-1.5) ...
        + m(2)*( m(1)^2 + m(2)^2 + m(3)^2 )^(-1.5) );
end
end