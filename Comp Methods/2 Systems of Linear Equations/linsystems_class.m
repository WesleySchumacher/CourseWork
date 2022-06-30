%--------------------
% MCEN 3030
% Spring 2020
% L03 driver script
% linear systems inclass
%--------------------

clear all; clc; close all
% TEST your backsubstitution code
% % Here is some code that makes a non-singular upper triangular matrix
% % and also plots it in 3D
% % Define a 
% % %t define system size
n = 10;


A = zeros(n,n);
for i = 1:n
    for j = i:n
        A(i,j)=randi([1,n],1);
    end
    A(i,i) = A(i,i) + n;
end

% visualize a matrix using surf
%surf(A,'edgecolor','none')
zlabel('A_{i,j}')
xlabel('x colums')   % rows or columns?
ylabel('y rows')   % rows or columns?
title('diagonal matrix')

% 
% % define b 
b = rand(n,1);
% 
% % solve
x = backsubs(A,b);
% 
% % check accuracy
 error = norm(A*x - b)

% 
% 
% TEST your GaussElim + Backsubs code
% 
% % setup
n = 100;
A = hilb(n);
b = ones(n,1);

% our code
x = solveAxb(A,b);
error = norm(A*x - b);
fprintf('error in my code is %e \n',error)

% try with inverse of A
x = inv(A)*b;
error = norm(A*x - b);
fprintf('error using inv(A) is %e \n',error)
% 
% 

%(a) out code
%(b) inv(A)
%() about the same

A1 = [3, -0.1, -0.2;0.1,7,-0.3;0.3,-0.2,10];
b1 = [7.85;-19.3;71.4];
% This is the end of the script s
% No "end" statement needed
% At the bottom of this script we can add
% the definitions of functions so that 
% everything is in a single file .
% 
% Define functions = here:
% 
function[x] = solveAxb(A,b)

% Imputs
%- A mattrics (nxn)
%-
% Step 1
[Am,Bm] = GaussElim(A,b);
% Step 2
[x] = backsubs(Am, Bm);
 end

% no other MATLAB code is allowed after
% the definition of functions

