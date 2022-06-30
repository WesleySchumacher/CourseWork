% This is an example project.  The assignment is to 
% calculate the Nth Fibonacci number for N 
%   (a) N = 5
%   (b) N = 50 
%   (c) N = 100
%
% As requested, we've put all content into a single file.
%
% The first part of this file is the top-level driver script. After 
% that are included the code for individual functions used by this 
% script or other functions. 
%
% Also, the contents of each function are separate from
% each other, not nested within each other, i.e., the layout is:
%
% % CP Part 1
% function[]=func1()
%
%    ...contents...
% end
% 
% CP Part 2
% function[]=function1()
%    ...contents...
% end
%
%------------------------------------------------------------
clc

% part (a)
N = 5;
[f_N] = fib_calc(N);
fprintf('part a: Fib term is %10i \n',f_N)

% part (b)
N = 50;
[f_N] = fib_calc(N);
fprintf('part b: Fib term is %10i \n',f_N)

% part (c)
N = 100;
[f_N] = fib_calc(N);
fprintf('part c: Fib term is %10i \n',f_N)


function[f_N]=fib_calc(N)
% Function fib_calc determines
% the Nth term of Fibonacci series
% Inputs:
%     N = # of term to calculate
% Outputs:
%   f_N = Nth term
%-----------------------------------


% initialize first 2 terms of series
f(1) = 0;
f(2) = 1;

% calculate remaining terms
for i = 3:N
    f(i) = f(i-1) + f(i-2);
    %display(f(i))
    %fprintf('The %2i term is = %10i \n',i,f(i));
end

% final Fibonacci number
f_N = f(N);

% end function
end

% MATLAB doesn't allow any text to be placed after the definition 
% of the functions
