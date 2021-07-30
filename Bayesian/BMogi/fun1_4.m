function y = fun1_4(m,x)
% function y = fun1(m,x)
y = zeros(4,1);
x2 = x2x4(x);
for i = 1:4
    y(i,1) = m(4) * ( (x(i)-m(1))*( (x(i)-m(1))^2 + ( x2(i) - m(2) )^2 + m(3)^2 )^(-1.5) ...
        + m(1)*( m(1)^2 + m(2)^2 + m(3)^2 )^(-1.5) );
end
end