clear all; close all; clc
 
% ODE definition
f    = @(y,t) -10*y;

% range
t0   = 0;
tf   = 2;

% initial values
h    = 0.5;
y(1) = 55;
t    = t0;
i    = 0;

% desired error tolerance
tol  = 0.001;

% vectors for saving results
t_save(1) = t0;
h_save(1) = h;


while t < tf 
    
    % update counter
	i = i + 1;
    
    % get adaptive step size
    h = calc_h(f,h,t,y(i),tf,tol);
    
    % update y 
    y(i+1) = odesolve_imp(f,y(i),t,h); 
    
    % update time step
    t = t + h;
    
    % save results
    h_save(i+1,1) = h;
    t_save(i+1,1) = t;
    
end


% plot results
subplot(2,1,1)
plot(t_save,y,'-x')
xlabel('time')
ylabel('y(t)')
subplot(2,1,2)
plot(t_save(2:end),h_save(2:end),'-o')
xlabel('time')
ylabel('step size')
title('Hand-written code')



% display performance statistics
fprintf('Hand-written code: \n');
fprintf('   steps = %i \n \n', length(h_save)-1);



function [h] = calc_h(f,h,t,y,tf,tol)
% calc_h finds a step size h that gives a local truncation error
% accurate to user specified tol. 
%
% inputs:
%   h   = initial guess of step size
%   t   = current time
%   y   = current y
%   tf  = final time
%   tol = local truncation error tolerance
%
% output:
%   h   = value of step size to use
%--------------------------------------------------------------------------

% solve this twice, same h two different h
%-use 1st order and second order methods

%   Explicit method
% ynew1 = odesolve(f,y,t,h);
% ynew2 = odesolve_2ndorder(f,y,t,h);
% 
% delta = ynew2 - ynew1;
% A = delta /h^2;
% h = abs( tol/A) ^(1/2);



% implicit
ynew1 = odesolve_imp(f,y,t,h);

%with step size of h/2 -- must take two steps

ymid = odesolve_imp(f,y,t,h/2);
ynew2 = odesolve_imp(f,ymid,t+h/2,h/2);

delta = ynew2- ynew1;

A = -2* delta / h^2;
h = abs( tol/A)^(1/2);

end


function[ynew] = odesolve(f,y,t,h)
% Euler forward 1st order method
% Inputs
%   f    = ODE function
%   y    = current solution y_i
%   t    = current time t_i
%   h    = step size t_{i+1} - t_i
% Outputs
%   ynew = solution at y_{i+1}
%----------------------------------

ynew = y + h * f(y,t);

end

function[ynew] = odesolve_imp(f,y,t,h)
% Euler forward 1st order method
% Inputs
%   f    = ODE function
%   y    = current solution y_i
%   t    = current time t_i
%   h    = step size t_{i+1} - t_i
% Outputs
%   ynew = solution at y_{i+1}
%----------------------------------

ynew = y / (1+10*h);

end

function[ynew] = odesolve_2ndorder(f,y,t,h)
% Euler 2nd order mid method
% Inputs
%   f    = ODE function
%   y    = current solution y_i
%   t    = current time t_i
%   h    = step size t_{i+1} - t_i
% Outputs
%   ynew = solution at y_{i+1}
%----------------------------------

%estimate y at mid point
ymid = y + h/2 * f(y,t);
    
ynew = y + h * f(ymid, t +h/2);

end
