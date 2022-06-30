%--------------------
% MCEN 3030
% Spring 2020
% example using Newton's method
% for root finding and fractal plot
%--------------------
clear all; clc; close all

% sample function f(x) = 3*x^3 + 2 * x - 15
f = @(x) 3 * x.^3 + 2 * x - 15;

% check plot
ezplot(f,[-3,3]); grid on; set(gca,'FontSize',18)

% define derivative
fp = @(x) 9 * x^2 + 2;

% find one root
xroot = newton(-1.6, f, fp);

% note that there are actually 3 roots;
roots([3 0 2 -15])

% search for roots in complex plan
% settting up a domain from -3 to 3 in the real axis
% and -2 to 2 in the imaginary axis
% with a grid spacing of 0.01
[X,Y] = meshgrid([-3:0.01:3],[-2:0.01:2]);
[n,m] = size(X);
for j = 1:n
    for k = 1:m
        
        % build complex number
        x_comp = X(j,k) + i * Y(j,k);
        
        % evaluate our function
        f_val  = f(x_comp);
        
        % define z-axis as norm of f_val (ie dist from root)  
        Z(j,k) = norm(f_val);
        
        % find root
        x_root = newton(x_comp,f,fp);
        
        % C saves which root was found
        %
        % the real root
        if abs(imag(x_root)) < 1e-10           
            C(j,k) = 0;
        % one of the imaginary roots
        elseif imag(x_root) < 0 
            C(j,k) = -1;
        % the other imaginary root
        else
            C(j,k) = 1;
        end
        
    end
end

% plot the function
figure()
meshc(X,Y,Z)
xlabel('x (real)')
ylabel('y (imag)')
zlabel('||f||')

% try one point at a time for illustration
%newton(1.5 + 0.8*i,f,fp)

% plot the result of newton's method initiated at each point
figure()
surf(X,Y,C,'edgecolor','none')
view(0,90)
xlabel('x (real)')
ylabel('y (imag)')


function[xroot]=newton(x_init,f,fp)
%---------------------------------------------
% inputs:
%  x_init = initial guess of root
%       f = function to find roots of
%      fp = df/dx
% ouputs:
%   xroot = root of f(x) 
%----------------------------------------------


kmax  = 100;
e_rel = eps;    % machine precision

% initialize
x(1) = x_init;

for k = 1:kmax
    
    % update solution using Newton
    x(k+1) = x(k) - f(x(k)) / fp(x(k));
       
    % error estimate
    est_err = abs( ( x(k+1) - x(k) ) / x(k+1));
    
%     fprintf(' at itr %i x = %20.15f with est_err = %20.16f \n',...
%         k, x(k+1), est_err);
    
    % convergence criteria for relative error
    if est_err  < e_rel
%         fprintf(' Newton  converged: x = %20.16f \n', x(k))
        xroot = x(k);
        return
    end
    
end
     
disp('Newton : did not converge!')
xroot = NaN;
end



   
    
    