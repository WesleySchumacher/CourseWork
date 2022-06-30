% MCEN 3030 
% Spring 2020
% Driver script for zipper  ODE
clear all; close all; clc

% parameters
global c d

c = 3.6; 
d = 1;

% initial conditions
x_init = 1;
s_init = 1;
a_init = 1;

% integration range
t_init  = 0;
t_final = 1000;

v_init = [x_init s_init a_init];
tspan  = [t_init t_final];

% error control:
options = odeset('RelTol',0.00001);


% solve
[t,v] = ode45(@zipperODE, tspan, v_init, options);

% analyze solution
x = v(:,1);
s = v(:,2);
a = v(:,3);
j = -( c * a - d * x.* s.^2 + x.^3);

subplot(2,1,1)
plot(t,x,'-r')
xlabel('x')
ylabel('position')
subplot(2,1,2)
plot(x,s,'-b')
xlabel('position')
ylabel('velocit')

function [dvdt] = zipperODE(t,v)
%v(1) = x 
%v(2) = s 
%v(3) = a

%parameters and constrants
global  c d

% dx/dt
dvdt(1) = v(2);

%ds/dt = 
dvdt(2) =  v(3);

%da/dt = 
dvdt(3) =  -( c * v(3) - d * v(1) * v(2)^2 + v(1)^3);

%transpose vector
dvdt = dvdt';

end