%--------------------
% MCEN 3030
% Spring 2020
% L04 in class
% Exponential series
%--------------------

% always include this as your first line
close all; clc; clear all

% find exp(x) for x = 0.5 
x     = 0.5;

kmax = 8;
etol = 1;

% try up to n = 8
for k = 1:kmax
    
    exp_x = exp_est(x,k);
    
    % approx error percent
    error_approx = abs( ( exp_x - ? ) / ? ) * 100;
    
    fprintf('%k terms: exp_x = %f, approx error = %f \n', k, exp_x, error_approx)
    
    if error_approx < etol
        disp('converged to within tolerance')
        break
    end
end
% 



function y = exp_est(x,n)
% Calculate series approximation of exp(x)
% inputs:
%  x = exponent argument
%  n = # of terms in series
% outputs
%  y = estimate of exp(x) 

y = 0;
for i = 1:n
    
   y = y + x^(i-1) / factorial(i-1);
    
end

end






