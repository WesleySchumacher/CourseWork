


%% HomeWork1 Problem # 4
syms x;
limit(((sqrt(4+x)-2)/x), x, 0);
x1 = 1e-13:-1e-16:1e-16;

y = (((1/4)-((sqrt(4+x1)-2)./x1))./(1/4)).*100;

plot(x1,y)
title('plot of relative percent error');



%% HomeWork1 Problem # 5
x =( 0.988:0.001:1.012);
y1 = (x-1).^7;
y2 = x.^7-7*x.^6+21*x.^5-35*x.^4+35*x.^3-21*x.^2+7*x-1;
plot(x,y1);
xlabel('x');
title('plot of seventh order polynomials');
hold on;
e = y2;
plot(x,e);
legend('(x-1).^7','(x.^7-7*x.^6+21*x.^5-35*x.^4+35*x.^3-21*x.^2+7*x-1)');


%% HomeWork1 Problem # 6
pi.^2/6
s = 0;
p = 10000000;
for v = 1.0:p
   s = s +( (1/(v.^2)));
end
disp(s)

s2 =0;
for n = p:-1:1
   s2 = s2 + ( (1/(n.^2)));
end
disp(s2)

s-s2


%% HomeWork1 Problem # 7 part A
s = 0;
for m = 1.0:40
    
    
   s =s + ((-1).^(m-1) .* (1/(2.*m-1)));
   b(m) = s*4;
   
end
disp(b);

x = 1.0:40;
subplot(2,1,1);
plot(x,b)

title('plot of the approximation of pi');
xlabel('x');
ylabel('approximate pi value');


% approximate relative percent error
%y2 = ((pi - (4 .* ((-1).^(x-1) .* (1./(2.*x-1))))) ./ pi) .* 100;
y2 = ((pi - b) ./ pi) .* 100;

%true relative percent error
%y3 = abs(pi - (4 .* ((-1).^(x-1) .* (1./(2.*x-1))))./ (4 .* ((-1).^(x-1) .* (1./(2.*x-1))))) .*  100;
y3 = abs((b - pi)./ b) .*  100;

subplot(2,1,2);
plot(x, y2)
xlabel('x');
ylabel('Percentage Error');
title('plot of pi approximation error');
hold on;
plot(x, y3)
legend('approximate relative percent error','true relative percent error');
hold off;


%% HomeWork1 Problem 7 part B

pi

s = 0;
for m = 1.0:10000000
    
   s =s + 4 .* ((-1).^(m-1) .* (1/(2.*m-1)));
   if abs(s-pi) < 0.0000001
       i = m;
       m = 10000001;
   end
   
end

disp(s);
disp(i);

