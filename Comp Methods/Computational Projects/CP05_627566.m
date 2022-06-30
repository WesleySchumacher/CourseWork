%% Wesley Schumacher
% ME ID:627-566
% MCEN 3030 Computational Methods
% Spring 2020
%Computational Project 5

%% House-keeping Runner function
clear all; clc; close all;
format long

fprintf('Problem #1 \n')
fprintf(' part (a) \n')
h      = 0.1;
tinit  = 1;
tfinal = 10;
yinit  = -5;

f1 = @(y,t) y^2 -t;
y1  = euler_imp_non(f1,yinit, tinit, tfinal, h);
fprintf(' y(%i) = %f  \n',tfinal, y1(end))
t    = [tinit:h:tfinal];
subplot(2,1,1)
plot(t,y1)
xlabel('time')
ylabel('y(t)')
title('part(a)')


fprintf(' part (b) \n')
h      = 0.001;
tinit  = 0;
tfinal = 4;
yinit  = 1;

f = @(y,t) y*(t/2)^3 -1.5*sin(y);
y2  = euler_imp_non(f,yinit, tinit, tfinal, h);
fprintf(' y(%i) = %f   \n',tfinal, y2(end))
fprintf(' see Figure 1 \n')
t    = [tinit:h:tfinal];
subplot(2,1,2)
plot(t,y2)
xlabel('time')
ylabel('y(t)')
title('part(b)')
fprintf(' \n')


fprintf('Problem #2 \n')
fprintf(' part (a) \n')

% ODE definition
f    = @(y,t) -200*y+200*t-40;
% range
t0   = 0;
tf   = 1;
% initial values
h    = 0.1;
ya(1) = 1;
t    = t0;
i    = 0;
tol  = 0.001;
% vectors for saving results
t_save(1) = t0;
h_save(1) = h;
while t < tf 
    
    % update counter
	i = i + 1;
    
    % get adaptive step size
    h = calc_h(f,h,t,ya(i),tf,tol);
    
    % update y 
    ya(i+1) = odesolve_imp(f,ya(i),t,h); 
    
    % update time step
    t = t + h;
    
        % save results
        h_save(i+1,1) = h;
        t_save(i+1,1) = t;
    
    if (t+h) > tf
       h = tf-t; 
    end
end

fprintf(' y(%i) = %f  \n',tf, ya(end))

fprintf(' part (b) \n')

% display performance statistics
fprintf('Hand-written code: \n');
fprintf('   steps = %i \n', length(h_save)-1);

fprintf(' part (c) \n')
fprintf(' see Figure 2 \n')

% plot results
figure();

plot(t_save,ya,'-x')
xlabel('time')
ylabel('y(t)')
title('2.c Final solution y(t) ')

fprintf(' part (d) \n')
fprintf(' see Figure 3 \n')
figure();
plot(t_save(2:end),h_save(2:end),'-o')
xlabel('time')
ylabel('h')
title('2.d h vs t')



fprintf(' part (e) \n')
% integration range
t0   = 0;
tf   = 1.0;

% initial values
y(1) = 1;

tspan   = [t0 tf];
yinit   = y(1);

%Explicit
[t1, y]=ode23(@fODE,tspan,yinit);

%implicit
[t2, y4]=ode23s(@fODE,tspan,yinit);


% calculate the step sized used
for i = 2:length(t1)
    h1(i)=t1(i)-t1(i-1); 
end

% calculate the step sized used
for i = 2:length(t2)
    h2(i)=t2(i)-t2(i-1); 
end

% display performance statistics
fprintf('Explicit \n');
fprintf('MATLAB ode23: \n');
fprintf('   steps = %i \n ', length(h)-1)
fprintf(' y(1) = %f  \n', y(end))

% display performance statistics
fprintf('Implicit \n');
fprintf('MATLAB ode23s: \n');
fprintf('   steps = %i \n ', length(h1)-1)
fprintf(' y(1) = %f  \n', y4(end))

figure()
subplot(2,2,1)
plot(t1,y,'-bx')
xlabel('t')
ylabel('y')
title('ode 23 (Explicit)')
subplot(2,2,2)
plot(t2,y4,'-bx')
xlabel('t')
ylabel('y')
title('ode 23s (Implicit)')
subplot(2,2,3)
plot(t1, h1,'-o')
xlabel('t')
ylabel('h')
title('ode 23 (Explicit)')
subplot(2,2,4)
plot(t2, h2,'-o')
xlabel('t')
ylabel('h')
title('odes 23s (Implicit)')

fprintf(' see Figure 4 \n')
fprintf(' \n')
%% Sup-Fumctions BELOW


%% Function for question 2
function [y] = euler_imp_non(f, yinit, tinit, tfinal, h)
%--------------------------------------------------
% ODE IVP solver with Euler implicit (bwd) method
% inputs:
%  f      = ODE function = dy/dt
%  yinit  = initial value, y(tinit)
%  tinit  = initial time
%  tfinal = final time
%  h      = time step, t(i+1) - t(i)
% output:
%  y      = ODE solution y(t)
%--------------------------------------------------

% initialize values
y(1) = yinit;
t    = [tinit:h:tfinal];
imax1 = length(t);
% solve

for i = 1:imax1-1
    
    g = @(x) x-y(i)-h*(f(x, t(i+1)));
	y(i+1) = fzero(g,y(i));
    
end

end

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


if (t+h) > tf
   h = tf-t; 
end

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

g = @(x) x-y(1)-h*(f(x, t+h));
	ynew = fzero(g,y(1));

end


function[dydt]=fODE(t,y)
% note: to use with MATLABs intermal solvers, the arguments 
%       of the function need to be in the order t,y

dydt =  - 200 * y + 200*t - 40;

end