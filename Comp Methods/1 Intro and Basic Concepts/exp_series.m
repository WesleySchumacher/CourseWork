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

exp_est(x,6)
    

% % ignore this for now
for n = 1:8
    
    exp_x = exp_est(x,n);
    
    % true error percent
    error_tru = abs( ( exp_x - exp(x) ) / exp(x) ) * 100;
    
    fprintf('%i terms: exp_x = %f, true error = %f \n', n, exp_x, error_tru)
    
end



% add a loop here to compute the following sum: 
% y = sum ( x^(i-1) / (i-1)! ) for i from 1 to n
function y = exp_est(x,n)
%inputs:
% x = exponents argument
% y


y =0;
for i = 1:n
    
   y = y + x^(i-1)/ factorial(i-1);
    
end


end

% %% Part 1 
% n = 5;
% m = 100;
% [A1,b1] = createMat(n,m);
% 
% %% Part 2
% %A = [3, -0.1, -0.2;0.1,7,-0.3;0.3,-0.2,10];
% %b = [7.85;-19.3;71.4];
% statuscheck = check_diag(A1);
% 
% %% Part 3
% if statuscheck ==0
% xvalues = GaussSeidelSolver(A1,b1,1e-10,n);
% end
% 
% %% Part 4
% 
% n = 100;
% A = hilb(n);
% b = ones(n,1);
% 
% % our code
% x = solveAxb(A1,b1);
% 
% % try with inverse of A
% x2 = A1\b1;
% 
% %% Part 5
% x1= ChecknSolve(A1,b1,1e-10,length(A1));
% 
% %% Park 6



