syms x;
limit(((sqrt(4+x)-2)/x), x, 0);
x1 = 1e-13:-1e-16:1e-16;

y = (((1/4)-((sqrt(4+x1)-2)./x1))./(1/4)).*100;

plot(x1,y)
title('plot of relative percent error');