%% Wesley Schumacher
% ME ID:627-566
% MCEN 3030 Computational Methods
% Spring 2020
%Computational Project 4

%% House-keeping Runner function
clear all; clc; close all;
format long

fprintf('Problem #1 (function Name: simpson13)\n')
fprintf(' See code section 1 \n')
fprintf(' \n')

fprintf('Problem #2 \n')
%question 2 testing simpson 1/3 with 4x +x^3
f=@(x) (4*x + x^3);
n =10;
I1 = simpson13(f,0,10,n);
fprintf('Using Simsons 1/3 Method with a number of intervals of %i the integral approximation is: %f \n',n, I1)
fprintf(' \n')

fprintf('Problem #3 \n')
fprintf(' See code section 3 (function Name: RichardsonEx)\n')
fprintf(' \n')

fprintf('Problem #4 \n')
%question 4 testing Richardson Extrapolation with x^2 -x^5
f=@(x) (x^2 -x^5);
n =10;
I2 = RichardsonEx(f,0,10,n);
fprintf('Using Richardson extrapolation Method with a number of intervals of %i the integral approximation is: %f \n',n, I2)
fprintf(' \n')

fprintf('Problem #6 \n')
fprintf(' See code section 6 (function Name: adaptiveintegration)\n')
fprintf(' \n')

fprintf('Problem #6 \n')
%question 6
g = 9.8;     %gravity   [m/s^2]
u = 1800;    %velocity  [m/s]
m = 160000;  %mass      [kg]
q = 2500;    %fuel consumption rate   [kg/s]

f=@(t) (u * log(m/(m-q*t))-g*t);

I3 = adaptiveintegration(f,0,30,1e-3);
fprintf('The distance the rocket will travel accurate to a millimeter is %f  \n',I3)
fprintf(' \n')

tic
fprintf('Problem #7 \n')
%question 7
error = 0.01;
%this matlab calulation takes some time but it does converge to a value of 49.040007 
I4 = (adaptiveintegration(@bat_func_1,0,7,error/2) - adaptiveintegration(@bat_func_2,0,7,error/2))*2;
h = toc ;
fprintf('The area of the bat sign is: %f units^2 \n',I4)
fprintf(' \n')
%% Sup-Fumctions BELOW

%% Function for question 1
function[out] = simpson13(f,xo,xi, int)
% function that uses Simpson’s 1/3 method to integrate any function given
% Input variables:
% the function name.
% integration range.
% and the number of intervals
% Output variable:
% numerical value of the integral
if mod(int,2) == 1
    fprintf('inappropriate number of interval requested \n')
else
    
    h = (xi - xo)/ int;
    n = xo:h:xi;
    I = (h/3)* (f(xo)) + (h/3)* (f(xi)) ;
    for i = 2:int
        if mod(i,2) == 0
             I = I + (h/3) * (4* f(n(i)));
        else
             I = I + (h/3) * (2* f(n(i)));
        end      
    end
 out = I;
end
end

%% Function for question 3
function[out] = RichardsonEx(f,xo,xi, int)
% function that uses the function from part (1) to estimate an even more accurate value of the integral using Richardson extrapolation
% Input variables:
% the function equation.
% integration range.
% and the number of intervals
% Output variable:
% numerical value of the integral very accurate
if mod(int,2) == 1
    fprintf('inappropriate number of interval requested \n')
else
    I1 = simpson13(f,xo,xi, int);
    I2 = simpson13(f,xo,xi, int*2);
end
out = ((16*I2) -I1)/15;
end

%% Function for question 5
function[out] = adaptiveintegration(f,a,b, er)
% function that performs adaptive integration
% Input variables:
% a user de?ned function
% an integration range
% desired absolute error tolerance
% Output variable:
% numerical value of the integral

N = 4;
err_est = 999;

while err_est > er
    
    A = RichardsonEx(f,a,b,N);
    
    %errror est in A
    err_est = abs( A - RichardsonEx(f,a,b,N/2))/3;
   
    
    fprintf('simpsons richardson with %i interval gives %f with err est %e \n',N, A, err_est)
    N = 2* N;
end

  out = A;
end


function val_out = bat_func_1(xv)
syms x y
eq1 = ((x/7)^2*sqrt(abs(abs(x)-3)/(abs(x)-3))+(y/3)^2*sqrt(abs(y+3/7*sqrt(33))/(y+3/7*sqrt(33)))-1);
%eq2 = (abs(x/2)-((3*sqrt(33)-7)/112)*x^2-3+sqrt(1-(abs(abs(x)-2)-1)^2));
eq3 = (9*sqrt(abs((abs(x)-1)*(abs(x)-.75))/((1-abs(x))*(abs(x)-.75)))-8*abs(x));
eq4 = (3*abs(x)+.75*sqrt(abs((abs(x)-.75)*(abs(x)-.5))/((.75-abs(x))*(abs(x)-.5))));
eq5 = (2.25*sqrt(abs((x-.5)*(x+.5))/((.5-x)*(.5+x))));
eq6 = (6*sqrt(10)/7+(1.5-.5*abs(x))*sqrt(abs(abs(x)-1)/(abs(x)-1))-(6*sqrt(10)/14)*sqrt(4-(abs(x)-1)^2));

% eq2 is tricky to evaluate, so it's quickest to represent it using a
% spline. 
xf = [3  ,  4,  5.2, 6.7, 6.9, 7];
yf = [2.7,2.5, 2.05, .95, 0.5, 0];

for n = 1:length(xv)
    
    xd = xv(n);
    
    xd = abs(xd);
    
    % there's a singularity at 1
    if xd == 1
        xd = 1.00000000001;
    end
    
    % and one at 0.5
    if xd == 0.5
        xd = 0.49999999999;
    end
    
    % and one at 0.75
    if xd == 0.75
        xd = 0.749999999999;
    end
    
    if      xd <= 0.5
        
        val(n) = subs(eq5,xd);
        
    elseif  xd > 0.5 && xd <= 0.75
        
        val(n) = subs(eq4,xd);
        
    elseif  xd > 0.75 && xd <= 1.0

        val(n) = subs(eq3,xd);
        
    elseif  xd > 1.0 && xd <= 3.0
        
        val(n) = subs(eq6,xd);
        
    elseif  xd > 3.0
        
        % hermite spline value at xd
        val(n) = pchip(xf,yf,xd);       
    end   
end
if strcmp(class(val),'sym')
    val_out = eval(val);
else
    val_out = val;
end
end


function val_out = bat_func_2(xv)

syms x y

eq2 = (abs(x/2)-((3*sqrt(33)-7)/112)*x^2-3+sqrt(1-(abs(abs(x)-2)-1)^2));

% eq2 is tricky to evaluate, so it's quickest to represent it using a
% spline. 
xf = [3  ,  4,  5.2, 6.7, 6.9, 7];
yf = [2.7,2.5, 2.05, .95, 0.5, 0];
for n = 1:length(xv)
    xd = xv(n);
    xd = abs(xd);
    if      xd <= 4
        val(n) = subs(eq2,xd);
    else
        % hermite spline value at xd
        val(n) = -pchip(xf,yf,xd);
    end  
end

if strcmp(class(val),'sym')
    val_out = eval(val);
else
    val_out = val;
end
end