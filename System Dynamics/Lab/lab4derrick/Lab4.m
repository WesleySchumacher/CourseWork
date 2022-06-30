% Lane Levine, Derrick Rasser, Wesley Schumacher
% Group 41
% Lab 4 MATLAB
%System Dynamics
clc; clear all; close all;
%% Impulse Response

ex3 = xlsread('Ex3.csv');
% pulse at cell 2247

x_exp = ex3((2247:4561),3);%input
y_exp = ex3((2247:4561),2);%output
h_exp = 200*y_exp;
t = linspace(0,.4,length(x_exp))';
plot(t,h_exp)
axis([0 0.4 -2 70])
xlabel('Time (s)')
ylabel('h(t) (V)')


%% Random Noise 

ex4 = xlsread('Ex4.csv');
x4 = ex4(:,3);%input
y4 = ex4(:,2);%output
t4 = ex4(:,1)-ex4(1,1);
figure(2)
plot(t4,x4,'b')
hold on
plot(t4,y4,'g','linewidth',2)
xlabel('Time (s)')
ylabel('Input and Output (V)')
%title('Random Input and Output')
legend('Random Input','Output')


% Convolution
dT = .0001;
y5 = dT*conv(x4,h_exp);

figure(3)
plot(t4,y4,'b')
hold on
plot(t4,y5(1:length(t4)),'g')
xlabel('Time (s)')
ylabel('Output (V)')
%title('Output')
legend('Convolution Result','Experiment')
