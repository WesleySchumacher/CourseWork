%--------------------
% MCEN 3030
% Spring 2020
% example using Newton's method
% for root finding
%--------------------
clear all; clc; close all


[X,Y] = meshgrid(-5:0.1:5,-5:0.1:5);
[n,m] = size(X);
for i = 1:n
    for j = 1:m
        
        x = [X(i,j); Y(i,j)];
        
        Z(i,j) = norm(f(x));
        % (a) norm(x)
        % (b) f(x)
        % (c) norm(f(x))
        % (d) [x(2), x(1); 2*x(1) 1]
        % other
        
        
        
    end
end
meshc(X,Y,Z)

% a good initial guess would be? 
% (a) x = [0, 0]
% (b) x = [2.5, -3]
% (c) x = [0, 0]
% (d) x = [1, 0]
% (e) other
x = [2.5; -3]
% 
x = x- J(x) \f(x)
x = x- J(x) \f(x)
x = x- J(x) \f(x)
x = x- J(x) \f(x)

function[fret]=f(x)

fret(1,1) = (x(1) * x(2) + 7);
fret(2,1) = (x(1)^2 + x(2) -4);

end

function[Jret]=J(x)

Jret = [ x(2), x(1); 2*x(1), 1];

end



   
    
    