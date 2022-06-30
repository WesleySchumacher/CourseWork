close all; clc; clear all

% integration range
t0   = 0;
tf   = 0.5;

% initial values
y(1) = 1;

% MATLAB internal solver needs tspan in this form in order 
% for you to see what step sizes it takes.  If you want 
% to get the answer interpolated to a fixed dt, you could 
% use tspan=[t0:dt:tf] but inside ode23 it will still be 
% updating the stepsize adaptively
tspan   = [t0 tf];
yinit   = y(1);

% MATLAB returns two vectors, t and y, that define the solution y(t)
% at the set of discrete points used by the ode solver

%Explicit
%[t y]=ode23(@fODE,tspan,yinit);

%implicit
[t y]=ode23s(@fODE,tspan,yinit);


% calculate the step sized used
for i = 2:length(t)
    h(i)=t(i)-t(i-1); 
end

% display performance statistics
fprintf('MATLAB ode23: \n');
fprintf('   steps = %i \n ', length(h)-1)

figure()
subplot(2,1,1)
plot(t,y,'-bx')
xlabel('t')
ylabel('y')
subplot(2,1,2)
plot(t, h,'-o')
xlabel('t')
ylabel('h')
title('ode 23')

function[dydt]=fODE(t,y)
% note: to use with MATLABs intermal solvers, the arguments 
%       of the function need to be in the order t,y

dydt =  - 1000 * y + 2000 + 1000 * t;

end
