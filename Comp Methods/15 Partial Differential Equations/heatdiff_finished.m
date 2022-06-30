% MCEN 3030
% Spring 2020
% Transient heat diffusion  
% fully explicit

clear all; clc; close all
global dx nx a

% setup discrete system and constants
L  = 10;            % length
dx = 02.5;
nx = L/dx+1;

a  = 1;

tf = 100;
dt = 0.01;
nt = tf/dt+1;

x  = 0:dx:L;
To = 20;

% boundary values
TA = 40;
TB = 200;

kmax = nt;

s = dt*a/dx^2


% initial condition
T = zeros(nx,kmax);
T(:,1)=To;

% BC's
T(1,:)=TA;
T(nx,:)=TB;

% plot initial conditions
plot(x,T(:,1),'-k')
xlabel('x')
ylabel('T')
hold on

%Explicit
for k = 1:kmax-1
    
    for i = 2:nx-1
        
        T(i,k+1)  = T(i,k) + s * (T(i-1,k) - 2 * T(i,k) + T(i+1,k));
        
    end
    
    %plot intermediate solutions
    plot(x,T(:,k+1),'-b')
    drawnow
    
end

%plot final equilibrium solution
plot(x,T(:,k+1),'-r')


%plot Temperature vs time for a few points in space
figure()
plot(0:dt:tf,T(5,:),'-b')
hold on
plot(0:dt:tf,T(20,:),'-r')
plot(0:dt:tf,T(30,:),'-m')
legend('T_5','T_{20}','T_{30}')
xlabel('t')
ylabel('T')
