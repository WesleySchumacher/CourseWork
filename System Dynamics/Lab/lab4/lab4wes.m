% h, x_exp, y_exp
% you must fine and calculate DT
%y = DT * conv(x_exp,h) 

% Lane Levine, Derrick Rasser, Wesley Schumacher
% Group 41
% Lab 4 MATLAB

clc;close all;

% Read in the data that was collected using WaveForms
[Voltage] = xlsread('Lab4hofxdata.csv');
[Voltage1] = xlsread('Lab4xinyout.csv');

% Extract each column (time, step function value, voltage value)
time1 = Voltage(:,1);
step1 = Voltage(:,2);
voltage1 = Voltage(:,3);

time2 = Voltage1(:,1);
step2 = Voltage1(:,2);
voltage2 = Voltage1(:,3);

% Find data for 0.2 second interval
a = 4500;
b = 5601;
t1 = time1(4530:5881)  - 2.02029242;
v1 = 200* voltage1(4530:5881); %4159
s1 = step1(4530:5881);

t2 = time2(1500:5881);
v2 = voltage2(1500:5881);
s2 = step2(1500:5881);

figure(1)
% Plot experimental input
plot(t1,v1,'b','Linewidth',1)
xlabel('Time (s)')
ylabel('h(t) (V)')

figure(2)
% Plot experimental output
plot(t2,s2,'b','Linewidth',1)
hold on
plot(t2,v2,'g','Linewidth',2)
xlabel('Time (s)')
ylabel('Input and Output (V)')
title('Random Input and Output')
legend('Random Input','Output')


figure(3) 
y = 0.001 * conv(s2,v1) ;
%plot(t2,y,'b','Linewidth',1)

plot(t2,v2,'g','Linewidth',1)
xlabel('Time (s)')
ylabel('Output (V)')
title('Output')
legend('Convolution Result','Experiment')




