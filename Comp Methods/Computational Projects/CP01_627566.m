%% Wesley Schumacher
% ME ID:627-566
% MCEN 3030 Computational Methods
%Computational Project 1
% Spring 2020

%% House-keeping
clear all; clc; close all;

%seting valuables to values
fprintf('(a)\n');
na = 5;
ma = 1e2;
eta = 10e-10;
kmaxa = 10;
%creating the Matrix and vector
[Aa,ba] = createMat(na,ma);
%calling the checknSolve funtion to solve the matrix(find Xs)
xa= ChecknSolve(Aa,ba,eta,kmaxa);
fprintf('\n');

fprintf('(b)\n');
nb = 5;
mb = 1e2;
etb = 10e-10;
kmaxb = 50;
%creating the Matrix and vector
[Ab,bb] = createMat(nb,mb);
%calling the checknSolve funtion to solve the matrix(find Xs)
xb= ChecknSolve(Ab,bb,etb,kmaxb);
fprintf('\n');

fprintf('(c)\n');
nc = 5;
mc = 1e6;
etc = 10e-10;
kmaxc = 50;
%creating the Matrix and vector
[Ac,bc] = createMat(nc,mc);
%calling the checknSolve funtion to solve the matrix(find Xs)
xc= ChecknSolve(Ac,bc,etc,kmaxc);
fprintf('\n');

fprintf('(d)\n');
nd = 20;
md = 1;
etd = 10e-10;
kmaxd = 10;
%creating the Matrix and vector
[Ad,bd] = createMat(nd,md);
%calling the checknSolve funtion to solve the matrix(find Xs)
xd= ChecknSolve(Ad,bd,etd,kmaxd);
fprintf('\n');

%% Sup-Fumctions BELOW

%% Funtion for Part1
function [A,b] = createMat(n,m)
% A function that generates an n × n matrix A and an n × 1 vector b
% Input variables:
% N  the dimension of the NxN matix.
% M  The muliplier to cause the function to be diagonally dominant
% Output variable:
% A  A Matix of random numbers
% b a vector 
%
%create a matix
A = magic(n) + eye(n) * m;

%create a vector of size in with all 0 values
b = zeros(1,n);

%going thought the vector setting each value to 1/(the value of the index)
for i = 1:n
    b(i) = 1/i;
end
%traversing the vector turned into columb vector
b=b';
end

%% Funtion for Part2
function out = check_diag(A)
% The function determines whether all rows of the matrix are diagonally dominant
%The 
% Input variables:
% A : The matrix of coefficients.
% Output variable:
% out : status variable being equal to 0 means that A is diagonally dominant
%       and being non-zero means A is not diagonally dominant
% 
%setting out initially to 0(diagonally dominant)
out = 0;
%setting n = to the size of A
n = length(A);
%for loop traversing through the matrix
for i = 1:n
    %Grapbing a row of the matrix 
    row = A(i,:);
    %checking to see if the diagonal term is greater than the sum of all
    %the other terms
    if abs(A(i,i)) < sum(abs(row))-abs(A(i,i)) 
        out = 1;
        %displaying the warning message
        warning('A is NOT diagonally dominant.')
        break;
    end
end
end

%% function for part3
function x = GaussSeidelSolver(A,b,et,kmax)
% The function solve a system of linear equations [a][x]=[b] using the Gauss Seidel Method.
% A must be a diagonally dominant matrix
% Input variables:
% A  The matrix of coefficients.
% b  A column vector of constants.
% et a number that speci?es the total relative squared error tolerance 
% kmax a number that specifies the number of iterations
% Output variable:
% x  Solution vector
% 
% setting n to the matrix dimension
n = length(A);
%puting values to unknown values vector(x)
x = zeros(n,1);
%Setting oldx to the last value of x(k-1) previous iteration
x_old = x;
for indexi = 1:n
    % setting dummy equal to the value of the diagonal
    dummy = A(indexi,indexi);
    for indexj = 1:n
        %Settig each value equal to the value divided by the diagonal
        A(indexi, indexj) = A(indexi, indexj) / dummy;
    end
    %dividing the b veector by the diagonal values as well
    b(indexi) = b(indexi)/dummy;
end

for indexi = 1:n
    % totaling up the values in the b vector
    sum = b(indexi);
    for indexj = 1:n
        if indexi ~= indexj
            %subtracting all the values in each row except for the diagonal 
            %term and muliplying them by the unknown vector
           sum = sum -A(indexi,indexj)*x(indexj);
        end
        %setting the sum equal to each x value
        x(indexi) = sum;
    end
end
%After the first iteration adding 1 to the iteration count
iter =1;
%settig relative error= a large value to initially go through the whileloop
relative_error = 10;
%while loop with conditions of (error is greater than given error and iteratin is less than iteration limit)
while(relative_error > et && iter <= kmax)
    for i = 1:n
        %setting old = each value in the x vector
        old = x(i);
        %setting sum = each value in the b vector
        sum = b(i);
        for j = 1:n
            if i ~= j
                %subtracting all the values in each row except for the diagonal 
                %term and muliplying them by the unknown vector
                sum = sum -A(i,j)*x(j);
            end
            %muliplying the sum by the privious x value
            x(i) = sum +(1.-1)*old;
        end 
    end
    %incrementing the iteration counter
    iter = iter +1;

    %setting relative error to 0 to recalculate it
    relative_error = 0;
    for j = 1:length(x) 
        %Calculating relative error using the privious iteration of x value
        relative_error = relative_error + abs((x(j)-x_old(j))/x(j));
    end
    %printing each value of error
    fprintf('Relative error on iteration %d: %f12\n',iter,relative_error);
    %if the error is smaller than the given error then print the number of
    %iterations
    if relative_error < et
        fprintf('Relative error tolerance achieved at %d iterations.\n',iter);
        break;
     %if the error is larger than the given error and the max iterations
     %has already been reached then print that the system didnt converge
     %with the given k value, needs larger k value and setting x = -999
    elseif relative_error >= et && iter == kmax
        warning('Relative error never achieved necessary tolerance. This system did not converge.');
        x = -999;
        break;
    end

    
    %setting the old value for x = the current value of x
    x_old = x;
end
end

%% Functions for part 4

function[Am,bm] = GaussElim(A,b)
% The function solve a system of linear equations [a][x]=[b] using the Gauss elimination method.
% Input variables:
% a  The matrix of coefficients.
% b  A column vector of constants.
% Output variable:
% A  Upper triangular matrix A
% b  Modified vector of constants b

AB = [A,b];
[r, c] = size(AB);
for j = 1:r-1
    for i = j+1:r
        AB(i,j:c) = AB(i,j:c)-AB(i,j)/AB(j,j)*AB(j,j:c);
    end
end
Am = AB(:,1:c-1);
bm = AB(:,c);

end

function[x]=backsubs(A,b)
% inputs 
%   A  upper triang (n x n)
%   b  column vector (n x 1);
% output
%   x  solution to Ax = b
%----------------------------
% determine n
n = length(b);
% check system
% initialize x
x = zeros(n,1);
% initial value
x(n) = b(n)/A(n,n);
% loop to find other values
for i = n-1:-1:1    %THE RIGHT CHOICE

    % store summation in tmp
    tmp = 0;
    for j=i+1:n
        tmp = tmp + A(i,j)*x(j);
    end  
    x(i) = ( b(i) - tmp ) / A(i,i);
end
end

function[x] = solveAxb(A,b)

    [Am,Bm] = GaussElim(A,b);

    x = backsubs(Am,Bm);
end

%% Function for part 5
function[x] = ChecknSolve(A,b,et,kmax)
% The function solve a system of linear equations [a][x]=[b] by using the
% correct method either elimination & backsub or guass Seidel 
% Input variables:
% A  The matrix of coefficients.
% b  A column vector of constants.
% et a number that speci?es the total relative squared error tolerance 
% kmax a number that specifies the number of iterations
% Output variable:
% x  Solution vector
%    
    %calling the diagonal check function and setting it equal to a variable
    check = check_diag(A);
    %if the checkdiag function gives a 5 value it is diagonally domanant
    %thus gauss Seidel solver should be used
    if check == 0
        %calling the seildel solver function
        x = GaussSeidelSolver(A,b,et,kmax);
        %fprintf('Gauss Seidel Method \n');
    %if the checkdiag function gives a 1 value it is not diagonally domanant
    %thus Elimination & back sub method should be used
    elseif check == 1
        %calling the Elimination & back sub function
        x = solveAxb(A,b);
        %fprintf('Gauss elimination with backsubstitution Method \n');
    end
    %printing solution to system.
    fprintf('Solution to the sysem: %d \n',x);
end