% MCEN 3030
% Spring 2020
% Transient heat diffusion  
% fully explicit

clear all; clc; close all
global dx nx a

% setup discrete system and constants
L  = 10;            % length
dx = 0.25;
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
% for k = 1:kmax-1
%     
%     for i = 2:nx-1
%         
%         T(i,k+1)  = T(i,k) + s * (T(i-1,k) - 2 * T(i,k) + T(i+1,k));
%         
%     end
%     
%     plot intermediate solutions
%     plot(x,T(:,k+1),'-b')
%     drawnow
%     
% end
% 
% plot final equilibrium solution
% plot(x,T(:,k+1),'-r')
% 
% 
% plot Temperature vs time for a few points in space
% figure()
% plot(0:dt:tf,T(5,:),'-b')
% hold on
% plot(0:dt:tf,T(20,:),'-r')
% plot(0:dt:tf,T(30,:),'-m')
% legend('T_5','T_{20}','T_{30}')
% xlabel('t')
% ylabel('T')

%Implicirt

tic
% Make A 
A = -s *diag(ones(nx-3,1),-1) + (1+ 2*s)*diag(ones(nx-2,1),0) + -s*diag(ones(nx-3,1),+1);
[L,U] = lu(A);
    
for k = 1:kmax-1
    
    
    %make B
    b = T(2:nx-1,k);
    b(1) = b(1) + s* TA;
    b(end) = b(end) + s*TB;
    
    %solve
    T(2:nx-1,k+1) = U\(L\b);
    
    % plot intermediate solutions
      %plot(x,T(:,k+1),'-b')
      %drawnow
    
end
toc
% plot final equilibrium solution
plot(x,T(:,k+1),'-r')


% % plot Temperature vs time for a few points in space
% figure()
% plot(0:dt:tf,T(5,:),'-b')
% hold on
% plot(0:dt:tf,T(20,:),'-r')
% plot(0:dt:tf,T(30,:),'-m')
% legend('T_5','T_{20}','T_{30}')
% xlabel('t')
% ylabel('T')




global a dx nx

t_init = 0;
t_final = tf;
tspan = [t_init t_final];

%[T1 T2 T3 T4 T5
v_init = [TA ones(1,nx-2)* To TB];

[t,v] = ode23s(@heatdiffODE,tspan,v_init);



% plot final equilibrium solution
plot(x,T(:,end),'-r')
% plot Temperature vs time for a few points in space
figure()
plot(t,T(5,:),'-b')
hold on
plot(t,T(20,:),'-r')
plot(t,T(30,:),'-m')
legend('T_5','T_{20}','T_{30}')
xlabel('t')
ylabel('T')


function[dvdt] = heatdiffODE(t,v)

global a dx nx 
%V is T

% Dirchlet BCs are handled by definition of v_init
dvdt(1) = 0;
dvdt(nx) = 0;

%if I had Neumann BCs, they would be if statments inside loop over i


for i = 2:nx-1
    
    dvdt(i) = a / dx^2 *(v(i-1) -2 * v(i) + v(i+1));
    
end

dvdt = dvdt';
end


































