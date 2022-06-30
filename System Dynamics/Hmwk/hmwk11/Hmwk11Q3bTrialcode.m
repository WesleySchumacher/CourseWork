% Lane Levine, Derrick Rasser, Wesley Schumacher
% Group 41
% HW11 Q3.b MATLAB

clear all; close all; clc;
format long

figure(1)
fs = 100;         % Sampling frequency (samples/sec)
t = -2:4/fs:2;      % Time Vector
w = 1;             % Triangle Width
x = tripuls(t+1.5,w);   % Sampled aperiodic triangle
x1 = tripuls(t+0.5,w);   % Sampled aperiodic triangle
x2 = tripuls(t-0.5,w);   % Sampled aperiodic triangle
x3 = tripuls(t-1.5,w);   % Sampled aperiodic triangle
plot(t,x,t,x1,t,x2,t,x3);
xlim([-2 2])
xlabel('Time (sec)');
ylabel('Amplitude');

figure(2)
t = -2:1/25:-1;     % Time Vector
w = 1;             % Triangle Width
x = tripuls(t+1.5,w);   % Sampled aperiodic triangle
plot(t,x,'b')
xlim([-2 2]);
hold on
t = -1:1/25:0;     % Time Vector
w = 1;             % Triangle Width
x = tripuls(t+0.5,w);   % Sampled aperiodic triangle
plot(t,x,'b')
t = 0:1/25:1;     % Time Vector
w = 1;             % Triangle Width
x = tripuls(t-0.5,w);   % Sampled aperiodic triangle
plot(t,x,'b')
plot(t,x,'b')
t = 1:1/25:2;     % Time Vector
w = 1;             % Triangle Width
x = tripuls(t-1.5,w);   % Sampled aperiodic triangle
plot(t,x,'b')

figure(3)
t = -2:1/25:-1;     % Time Vector
w = 1;             % Triangle Width
x = tripuls(t+1.5,w);   % Sampled aperiodic triangle
plot(t,x,'b')
xlim([-2 2]);
hold on
t = -1:1/25:0;     % Time Vector
w = 1;             % Triangle Width
x = tripuls(t+0.5,w);   % Sampled aperiodic triangle
plot(t,x,'b')
t = 0:1/25:1;     % Time Vector
w = 1;             % Triangle Width
x = tripuls(t-0.5,w);   % Sampled aperiodic triangle
plot(t,x,'b')
plot(t,x,'b')
t = 1:1/25:2;     % Time Vector
w = 1;             % Triangle Width
x = tripuls(t-1.5,w);   % Sampled aperiodic triangle
plot(t,x,'b')

