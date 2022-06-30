% Lane Levine, Derrick Rasser, Wesley Schumacher
% Group 41
% Lab 2 MATLAB

clc;

% Read in the data that was collected using WaveForms
[Voltage] = xlsread('Lab2Part4.csv');

% Extract each column (time, step function value, voltage value)
time1 = Voltage(:,1);
step1 = Voltage(:,2);
voltage1 = Voltage(:,3);

% Find data for 0.2 second interval
t1 = time1(4001:5601);
v1 = voltage1(4159:5759);
s1 = step1(4157:5757);

% Plot experimental input
plot(t1,s1,'k','Linewidth',2)
hold on

% Plot experimental output
plot(t1,v1,'g','Linewidth',4)

% Define R, C, and Time Constant
R1 = 5.1*10^3;
C1 = 3.3*10^-6;
tau = R1*C1;

% Define a time interval and timestep
t = 0:0.01:0.2;

% Define theoretical output equation
Vout = 1 - exp(-t./tau);

% Plot theoretical output
plot(t,Vout,'b','Linewidth',3)

% Plot simulation output from Simulink
plot(out.tout,out.simout,'--r','Linewidth',2)
grid on
xlabel('Time (s)')
ylabel('Voltage (V)')
title('Response of RC Circuit')
legend('Experimental Input (Vin)','Experimental Output','Theoretical Output',...
    'Simulation Output')


