%--------------------------------------------------------
% MCEN 3030
% MIDTERM 01
% Spring 2020
% - Submit this file on Canvas before 9:00 pm deadline
% - Make sure your file runs and displays all answers
%   without any user intervention.
%--------------------------------------------------------
close all; clc; clear all

%----------------------
% Question 5
%----------------------
fprintf ('Question #5 \n');
g  = 9.8;   % m/s2
Cd = 0.5;   % unitless
p  = 1.2;   % kg/m3
r  = 0.117; % m

% add code for solving here

A = pi * r^2;
t = 5;

v = @(m) (((sqrt((2*m*g)/(p*A*Cd)))*(1-exp((-t)*sqrt((p*g*Cd*A)/2*m))))-19.5);
%ezplot(v)
m = fzero(v,8,optimset('Display','iter'))

fprintf('The mass of the ball at t = 5 seconds and the velocity is 19.5m/s is : %f \n',m);
fprintf('\n');


%----------------------
% Question 6
%----------------------
fprintf ('Question #6 \n');



% Add the functions for 6a and 6b at at the bottom of this file, see below
f1 = @(w,y) 3.1*y^2 +2.1*w^3 -42;
f2 = @(w,y) -3*y^3-2.5*w^2 +69;
% 6c: add code here
[W, Y] = meshgrid(-4:0.1:4);
[n, m] = size(W);
for i = 1:n
    for j = 1:m
        k = [f1(W(i,j),Y(i,j)); f2(W(i,j),Y(i,j))];
        Z(i,j) = norm(k);
    end
end
meshc(W,Y,Z)

% 6d: add code here


x = [2.2;2.7];
zero = [0;0];
k = 0;
while abs(norm(zero - f(x))) > 1e-10
    x = x - J(x)\ f(x);
end
fprintf ('The roots for this system using Newtons method with a relative error of 1e10 are: \n');
fprintf ('values of x are: %f and  %f \n', x(1), x(2));
fprintf('\n');

%----------------------
% Question 7
%----------------------
fprintf ('Question #7 \n');
n = 10;
a = ones(n,1);
w = ones(n,1) * 4;
c = [1:n]';
b = ones(n,1);
A = diag(a(2:end),-1) + diag(w) + diag(c(1:end-1),1);


% 7a: add code here for computing l and u
i = 0;
u = zeros(n);
l = zeros(n);
u(1,:) = A(1,:);
for i = 2:n
    l(i,:) = A(i,:)/u(i-1,:);
    u(i,:) = w(i)-l(i)*c(i)-1;
end


% ...7a: m,d, and c are used to make L and U
% using the following code:
%  L = eye(n) + diag(l(2:end),-1);
%  U = diag(u) + diag(c(1:end-1),1);

% 7b: add code here 
l
u
x1 = (l*u) \ b

 [L,U] = lu(A);
x2 = (L*U) \ b
% 7c: add code here and above 


%-------------------------------------------------
% include any subfunctions that you wrote for 
% any of the problems below here
%-------------------------------------------------


% 7a
function[fret]=f(x)

% f1 = @(w,y) 3.1*y^2 +2.1*w^3 -42;
% f2 = @(w,y) -3*y^3-2.5*w^2 +69;

fret = [ (3.1*x(2)^2 +2.1*x(1)^3-42);
         (-3*x(2)^3-2.5*x(1)^2+69)];
end

% 7b
function[Jret] = J(x)
% 
Jret = [(63*x(1)^2)/10 , (31*x(2))/5 ;
        -5*x(1) , -9*(x(2)^2)];
end



