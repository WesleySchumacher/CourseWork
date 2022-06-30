clear all; close all

global h Ta

% define parameters
Ta = 20;
h  = 0.01;
L  = 10;

x_init  = 0;
x_final = L;
v1_init  = 40;  
guess = 30+(30-36)/(403.7-473.9)*(400-403.4)
%v2_init  = 30;  % just a guess! 
%v2_init  = 30;  % just a guess! 
v2_init  = 29.7094;  % just a guess! 

x_span = [x_init x_final];
v_span = [v1_init v2_init];

[x, v] = ode45(@diffeq, x_span, v_span);

T = v(:,1);

fprintf('T(L) estimated with dT(0)/dx = %.1f is %.1f \n ', v2_init, T(end))

plot(x,T,'-m')
xlabel('x')
ylabel('T')


function[dvdx] = diffeq(x,v)

global h Ta

% v(1) = T
% v(2) = y = dT/dx

dvdx(1) = v(2);
dvdx(2) = h * ( v(1) - Ta );

dvdx = dvdx';

end

