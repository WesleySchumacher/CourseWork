%--------------------
% MCEN 3030
% Spring 2020
% L05 driver script
% Scaling
%--------------------
clear all ;clc; close all

% define vector test sizes
n = [100:100:1000];


% test solution speeds for various size problems
for i = 1 : length(n)
    
    
    % make A, b
    A = hilb(n(i))+eye(n(i));
    b = ones(n(i),1);

    % solve linear system and save computational time
    
    tic 
    x1 = inv(A)*b;
    time1(i) = toc;
    
    tic
    x2 = A\b;
    time2(i) = toc;
    
    %plot(time(i),x(i) )

end



% make a plot of time for each method on y axis
% vs n^k on the x axis. Most linear for 
% (a) n   vs t
subplot(2,2,1)
plot(n, time1)
hold on
plot(n, time2)
ylabel('time');
xlabel('n');
legend('invA', 'backslash','location','northwest');
%set(gca,'FontSize', 18);
% (b) n^2 vs t
subplot(2,2,2)
plot(n.^2,time1)
hold on
plot(n.^2,time2)
ylabel('time');
xlabel('n^2');
legend('invA', 'backslash','location','northwest');
% (c) n^3 vs t
subplot(2,2,3)
plot(n.^3, time1)
hold on
plot(n.^3, time2)
ylabel('time');
xlabel('n^3');
legend('invA', 'backslash','location','northwest');
% (d) n^4 vs t
subplot(2,2,4)
plot(n.^4,time1)
hold on
plot(n.^4,time2)
ylabel('time');
xlabel('n^4');
legend('invA', 'backslash','location','northwest');
% (e) all nearly the same




% supporting functions:

 function[x] = solveAxb(A,b)
 % Input
 % - A matrix (nxn)
 % - b vector (nx1)
 % Output
 % - x = ....
 %-------------------------

% Step 1
[Am, bm] = GaussElim(A,b);

% Step 2
x = backsubs(Am,bm);

 end
function[Am,bm] = GaussElim(A,b)
% The function solve a system of linear equations [a][x]=[b] using the Gauss
% elimination method.
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

% find other values
for i = n-1:-1:1
    
    tmp = 0;
    
    for j = i+1 : n
        tmp = tmp + A(i,j) * x(j);
    end
    
    x(i) = ( b(i) - tmp ) / A(i,i);

end

end