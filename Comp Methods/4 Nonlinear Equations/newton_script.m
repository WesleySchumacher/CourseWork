%--------------------
% MCEN 3030
% Spring 2020
% example using Newton's method
% for root finding
%--------------------
clear all; clc; close all

% sample function f(x) = x^3 - 2 * x + 2
f = @(x) 3*x^3 + 2 * x - 15;

% check plot
ezplot(f,[-2,2]); grid on; set(gca,'FontSize',18)

% define derivative
fp = @(x) 9 * x^2 +2 ;

% find root
xroot = newton(-1.6, f, fp);

[X,Y] = meshgrid([-3:0.01:3],[-2:0.01:2]);
[n,m] = size(X);

for j = 1:n
    for k = 1:m
        
        x_comp = X(j,k) + i * Y(j,k);
        f_val = f(x_comp);
        Z(j,k) = norm( f_val );
        
        
        x_root = newton(x_comp, f, fp);
        
        
        %sort answers
        if abs(imag(x_root)) < 1e-10
            C(j,k) = -1;
        else
            C(j,k) = 1;
        end
    end
end
meshc(X,Y,Z)
xlabel('X real')
ylabel('Y img')


%x_root = newton(-0.3+1.6i, f, fp);

figure()
surf(X,Y,C, 'edgecolor', 'none')
view(0,90)

% bad initial guess causes oscillations
% xroot = newton(0, f, fp);
% 
% 
% sample function f(x) = x^3 - 2 * x + 2
% f = @(x) x^4 - (x-1)*exp(x)
% 
% check plot
% ezplot(f,[-2,6]); grid on; set(gca,'FontSize',18)
% 
% define derivative
% fp = @(x) 4*x^3 - exp(x)*(x - 1) - exp(x)
% 
% actually eventually converges:
% xroot = newton(-2, f, fp);
% 
% fails to converge:
% xroot = newton(0, f, fp);
% 
% converges normally:
% xroot = newton(5, f, fp);

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
    
    %fprintf(' at itr %i x = %20.15f with est_err = %20.16f \n',...
    %    k, x(k+1), est_err);
    
    % convergence criteria for relative error
    if est_err  < e_rel
        %fprintf(' Newton  converged: x = %20.16f \n', x(k))
        xroot = x(k);
        return
    end
    
end
     
disp('Newton : did not converge!')
xroot = NaN;
end



   
    
    