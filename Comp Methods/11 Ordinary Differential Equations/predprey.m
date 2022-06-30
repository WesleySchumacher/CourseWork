% MCEN 3030 
% Spring 2020
% Driver script for Lotka-Volterra ODE
clear all; close all; clc

% parameters
global a b c d

a = 3; 
b = 1;
% a = 50; 
% b = 1;
%c = 2; 
%d = 1;
c = 2; 
d = 1;

% initial conditions
x_init = 5;
y_init = 5;

% integration range
t_init  = 0;
t_final = 10;

v_init = [x_init y_init];
tspan  = [t_init t_final];

% error control:
options = odeset('RelTol',0.00001);


% solve
[t,v] = ode45(@predpreyODE, tspan, v_init, options);

% analyze solution
x = v(:,1);
y = v(:,2);

subplot(2,1,1)
plot(t,x,'-rx')
hold on
plot(t,y,'-bx')
xlabel("t")
ylabel("population")
legend("rabbits","fox")

% % calculate stepsize h
for i = 1:length(t) - 1
    h(i) = t(i+1) - t(i);    
end

subplot(2,1,2)
plot(t(1:end-1),h,'-xb')
xlabel('t')
ylabel('h(t)')

fprintf(' total steps taken = %i \n', length(h));

function [dvdt] = predpreyODE(t,v)
%v(1) = x = rabbits
%v(2) = y = fox

%parameters and constrants
global a b c d

% dx/dt = ax -byx
dvdt(1) = a * v(1) - b * v(1) * v(2);

%dy/dt = -cy +dxy
dvdt(2) = -c * v(2) + d * v(1) * v(2);

%transpose vector
dvdt = dvdt';

end