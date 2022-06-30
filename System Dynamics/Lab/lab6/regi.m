%for regi
close all; clear all; clc;
syms x
f = (1 -  3*x + 5*x.^2 - 8*x.^3 + 2*x.^4)

dfdx = diff(f)


d2fdx2 = diff(dfdx)

f = @(x) 2*x.^4 - 8*x.^3 + 5*x.^2 - 3*x + 1;

dfdx = @(x) 8*x.^3 - 24*x.^2 + 10*x - 3 ;

d2fdx2 = @(x) 24*x.^2 - 48*x + 10 ;

figure(1)
subplot(3,1,1)
ezplot(f)
subplot(3,1,2)
ezplot(dfdx)
subplot(3,1,3)
ezplot(d2fdx2)

x = -6:0.1:6;
y = f(x);

figure(2)
subplot(3,1,1)
plot(x,y)


y = dfdx(x);
subplot(3,1,2)
plot(x,y)

y = d2fdx2(x);
subplot(3,1,3)
plot(x,y)
