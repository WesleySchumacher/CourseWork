%% Wesley Schumacher
% ME ID:627-566
% MCEN 4043 System Dynamics
% Fall 2020
% Lab 1
clear all; clc; close all;
%% House-keeping Runner function
clear all; clc; close all;

% In the first lab session you will familiarize yourself with Matlab and Simulink by modeling a simple
% RC circuit and plotting its response to various stimuli
%Define time horizon 
time_start = 0;
time_final = 2;
t_step = 5000;

% Define the input function Vin(t):
vin_t = linspace(time_start,time_final,t_step);
freq = 1*2*pi;
vin=sin(vin_t*freq);

%Call the ode45 function to solve ODE:
Tspan = [time_start time_final];
IC = 0;
options=odeset("RelTol",1e-4);
[vout_t,vout]=ode45(@(t,y)ode_RC(t,y,vin_t,vin),Tspan,IC,options);

%Plot the solution Vin(t) and Vout(t):
figure;
plot(vin_t,vin);
hold on;
plot(vout_t, vout,'r--');
axis([0 1 -1 1]);
grid on;
xlabel('Seconds');
ylabel('Volts');
legend('V_{in}','V_{out}');

figure(1)
plot(t,vin,t,vout,'--')
axis([0 1 -1 1])
grid on
xlabel('seconds')
ylabel('Volts')

%% ODE_RC fumction
function dydt = ode_RC(t,y,gt,g)
R = 4.99e3;
C = 3.35e-6;
k = 1/(R*C);
g = interp1(gt,g,t); % Interpolate the data set (gt,g) at time t
dydt = -k*y + k*g; % Evalute ODE at time t
end