% MCEN 3030
% Spring 2020
% Transient heat diffusion  
% fully explicit

clear all; clc; close all

% setup discrete system and constants
L  = 10;            % length
dx = 0.01;
nx = L/dx+1;

a  = 1;

tf = 100;
dt = 0.1;
nt = tf/dt+1;

x  = 0:dx:L;
To = 20;

% boundary values
TA = 40;
TB = 200;

kmax = nt;

s = dt*a/dx^2;

%initial conditions
T = zeros(nx,kmax);
T(:,1) = To;

%boundary conditions
T(1,:) = TA;
T(end,:) = TB;

plot(x,T(:,1),'-k')
xlabel('x')
ylabel('T')
hold on

for k = 1:kmax -1
    
    for i = 2:nx-1
        
        T(i,k+1) = T(i,k) + s *( T(i-1,k) -2* T(i,k) + T(i+1,k));
    end
   
    plot(x, T(:,k+1), '-b')
    
end






















