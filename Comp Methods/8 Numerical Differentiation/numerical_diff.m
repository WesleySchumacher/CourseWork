% MCEN 3030
% Spring 2020

% Numerical Differentiation example
clear all; clc; close all

%---------------------------
% analytic
%--------------------------- 
f    = @(x) x^4 + exp(2*x)-333*x;
dfdx = @(x) 2*exp(2*x) + 4*x^3 - 333;   % pretend we don't know this...

% evaluate our function at x = 3
xi = 3;

% initial interval
h = .1;


fprintf(' h        err_tru   err_est \n')
fprintf('---------------------------\n')

% try for smaller intervals
for n = 1:8
    
    h_save(n)  = h;
    
    % 2 point forward FD
    fd_1st(n) =  ( f(xi+h) - f(xi) ) / h;
    
    % true relative error: just using to confirm our estimated error
    % is reasonable
    err_tru(n) = abs ( ( dfdx(xi) - fd_1st(n) ) / dfdx(xi) );
    
    
    % estimated relative error in n-1'th estimate
    if n > 1
        err_est(n-1) = abs ( ( fd_1st(n) - fd_1st(n-1) ) / fd_1st(n) );
        
        
        fprintf(' %f %f %f \n', h_save(n-1), err_tru(n-1), err_est(n-1));
        
    end
    
    % decrease h
    h = h / 10;
    
end

  
