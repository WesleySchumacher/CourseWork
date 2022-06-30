%--------------------
% MCEN 3030
% Spring 2020
% L02 in class
% Exponential series
%--------------------

% always include this as your first line
close all; clc; clear all

% find exp(x) for x = 0.5 
x     = 0.5;


% try up to n = 8
for n = 1:8
    
    exp_x = exp_est(x,n);
    
    % true error percent
    error_tru = abs( ( exp_x - exp(x) ) / exp(x) ) * 100;
    
    fprintf('%i terms: exp_x = %f, true error = %f \n', n, exp_x, error_tru)
    
    if error_tru < 1
        display('converged to within 1% error')
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






