%% Wesley Schumacher
% MCEN 3030 Computational Methods
% Spring 2020
% HW3 code
%% HomeWork3 Problem # 1
clear all; clc; close all;
M = 24.85;
a = 10;
e = 0.2;

f = @(E) E-e*sin(a*E)-M;
g = @(E) 1-2*cos(10*E);

x = 0:0.01:30;
plot(x,f(x))
ylim([-3 3]);
xlim([22 26])
ylabel('f(E)');
grid on
xlabel('E');
title('planetary orbits');

syms E;
A = vpasolve(M == E - e*sin(a*E),E);
fprintf('True value for E: %f \n', A);
%x = bisection(0,30,f);

%% HomeWork3 Problem # 2
clear all; clc; close all;
f = @(x) 3*x.^3 + 2*x -15;

%(a)
fprintf('Real roots via Bisection Method \n');
x = bisection(0,2,f);
%(b)
fprintf('Real roots via Newtons Method \n');
x1 = Newtons();

%(c)
fprintf('Real roots via fzeros method\n');
%X = fzero(f,0);
X = fzero(f,0,optimset('Display','iter')) 
fprintf('MATLAB functio: fzeros converged: x = %20.16f \n', X); fprintf('\n');

%(d)
fprintf('Real roots via solve method\n');
syms x;
x4 = solve(0 == 3*x^3 +2*x-15,x);

fprintf('MATLAB functio: solve converged:  x = %20.16f \n', min(x4)); fprintf('\n');

%(e)
fprintf('Real roots via roots method\n');
p = [3 0 2 -15];
r = roots(p);
fprintf('MATLAB functio: roots converged:  x = %20.16f \n', min(r)); fprintf('\n');

%(f)
fprintf('Real roots via Fixed point method\n');
f = @(x) ((-2*x+15)/3)^(1/3);
x2 = FixedPoint(f);

%(g)
fprintf('Real roots via Secant method\n');
x3 = Secant();

%% HomeWork3 Problem # 3
clear all; clc; close all;
f = @(x) cos(tan(x)) - tan(sin(x)) -1.5;
% xint = [4 4.65];
% x=fzero(@(x) cos(tan(x)) - tan(sin(x)) -1.5,4)
ezplot(f,[4 4.65])
grid on;

%these guesses are found using the graph. b/c for bisection a good initial guess is key
%bisection1 function is the same as bisection except it suppresses iterative output.
bisection1(4.49,4.521,f);
bisection1(4.581,4.59,f);
bisection1(4.6,4.629,f);
bisection1(4.64,4.65,f);

%% HomeWork3 Problem # 4
clear all; clc; close all;

%r = radius 
%h = height
% syms r h;
h = 25;
syms r;
S = @(r) 1800/(pi * sqrt(r^2 +h^2));
x2 = FixedPoint(S);
% S = @(r,h) pi * r* sqrt(r^2 +h^2);

% s = 1800;
% A = vpasolve(s == S(r,h),r);
 fprintf('The Radius of a cone with a height of 25m and a Surface Area of 1800m^2 is %fm \n', x2);


%% HomeWork3 Problem # 5

clear all; clc; close all;

k1 = 40000;
k2 = 40;
m = 95;
g = 9.81;
syms d;
f = @(d) ((2*k2*d.^(5/2))/5) +((k1*d.^2)/2) -m*g*d; 
d = 0 : 0.001:0.1;
plot(d,f(d))
ylabel('f(d)');
grid on
xlabel('d');
title(' Resistance force F of the spring');

x = fzero(f,0.045);
fprintf(' distance that the weight compresses the spring: %f meters \n', x);
%A = vpasolve( f(d),d)

%% HomeWork3 Problem # 6 
clear all; clc; close all;
format long
A= 5.485e-3;
B= 6.65e-6;
C = 2.805e-11;
D = -2e-17;
R0 = 100;
Rt = 300;

p = [D 0 C 0 B A 1-(Rt/R0)];
p*R0;
T = roots(p);
fprintf('Temperature  values: %20.16f degrees C  \n', T);



%% Functions
function [xroot] = bisection(xa,xb,f)

if f(xa) == 0
    xroot = xa;
    return
elseif f(xb) == 0
    xroot = xb;
    return
elseif f(xa) * f(xb) > 0
    disp('bad interval!')
    return 
end
kmax = 100;
e_rel = eps;
for k = 1:kmax   
    x(k) = (xa +xb)/2;
    if sign( f(x(k))) == sign( f(xa))
        xa = x(k);
    else
        xb = x(k); 
    end
    est_err = abs((xa-xb)/xb);
    fprintf(' at iteration  %i est_err = %20.16f \n', k, est_err);
    if (est_err <e_rel)
        fprintf('bisection converged:              x = %20.16f \n', x(k));
        xroot = x(k);
        fprintf('\n');
        return 
    end
end
disp('bisection :did not converge!')
end

function [xroot] = bisection1(xa,xb,f)

if f(xa) == 0
    xroot = xa;
    return
elseif f(xb) == 0
    xroot = xb;
    return
elseif f(xa) * f(xb) > 0
    disp('bad interval!')
    return 
end
kmax = 100;
e_rel = eps;
for k = 1:kmax   
    x(k) = (xa +xb)/2;
    if sign( f(x(k))) == sign( f(xa))
        xa = x(k);
    else
        xb = x(k); 
    end
    est_err = abs((xa-xb)/xb);
    %fprintf(' at itr %i est_err = %20.16f \n', k, est_err);
    if (est_err <e_rel)
        fprintf('bisection converged: x = %20.16f \n', x(k));
        xroot = x(k);
        return 
    end
end
disp('bisection :did not converge!')
end

function [xroot] = Newtons()
f = @(x) 3*x^3 + 2*x -15;
fp = @(x) 9*x^2 + 2;
fpp = @(x) 18*x;
xi = 1;
iter = 0;
while (abs(f(xi) -0) > eps)
    x_old = xi;
    xi = x_old - (f(x_old)/fp(x_old));
    iter = iter +1;
    est_err = abs((xi-x_old)/x_old);
    fprintf(' at iteration  %i est_err = %20.16f \n', iter, est_err);
end
xroot = xi;
fprintf('Newtons Method converged:         x = %20.16f after %i number of iterations \n', xroot,iter);
fprintf('\n');
end

%fixed point function
function [xroot] = FixedPoint(f)
%f = @(x) ((-2*x+15)/3)^(1/3);
%f = @(x) (-3*x^3-15)/2;

xi =f(0);
x_old = 0;
iter = 0;
while abs(xi-x_old) > eps
    x_old = xi;
    xi = f(x_old);
    iter = iter +1;
    est_err = abs((xi-x_old)/x_old);
    fprintf(' at iteration  %i est_err = %20.16f \n', iter, est_err);
end
xroot = xi;
fprintf('Fixed Point Method converged:     x = %20.16f after %i number of iterations \n', xroot,iter);
fprintf('\n');
end

function [xroot] = Secant()
f = @(x) 3*x^3 + 2*x -15;
x_oldold = 0;
x_old = 1;
xi = f(0);

iter = 0;
while(abs(f(xi)-0) > eps)
    x_oldold = x_old;
    x_old = xi;
    xi = x_old -((f(x_old)*(x_oldold-x_old))/(f(x_oldold)-f(x_old)));
    iter = iter +1;
    est_err = abs((xi-x_old)/x_old);
    fprintf(' at iteration  %i est_err = %20.16f \n', iter, est_err);
end
xroot = xi;
fprintf('Secant Method converged:          x = %20.16f after %i number of iterations \n', xroot,iter);
fprintf('\n');
end