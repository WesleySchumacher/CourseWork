%Mcen 2020

%spring 2020
clear all; clc; close all;
format long;


f =  @(x) x^4 + exp(2*x)-333*x;
dfdx = @(x)  2*exp(2*x) +4*x^3 -333;

xi = 3;

h = .1;

fd_1st = ( f(xi +h) - f(xi)) / h

dfdx(xi)
fprintf(' h         err_true  err_est \n');
fprintf(' -----------------------------\n');
 for n = 1:8
    h_save(n) = h;
    
    fd_1st(n) = ( f(xi+h) -f(xi) ) / h;
    
    %true relative error
    err_tru(n) = abs((dfdx(xi)-fd_1st(n)) /dfdx(xi));
    
    %estimate relative error
    if n>1
        err_est(n) = abs((fd_1st(n)-fd_1st(n-1)) /  fd_1st(n));
        fprintf(' %f %f %f \n', h_save(n-1), err_tru(n-1), err_est(n-1));
    end
    
    h = h/10;
 end
    