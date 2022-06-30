% Lane Levine, Derrick Rasser, Wesley Schumacher
% Group 41
% HW11 Q3.b MATLAB

clear all; close all; clc;
%% Question 3
figure(1)
Fs=160;
t=-2:4/Fs:2; 

f = [0:1/20:1 0.95:-1/20:0 0.05:1/20:1 0.95:-1/20:0 0.05:1/20:1 0.95:-1/20:0 0.05:1/20:1 0.95:-1/20:0 ];
plot(t,f,'b--','LineWidth',2)
xlim([-2 2])
hold on;
A = 1;
t = linspace(-2,2,100);

a0 = A;
bn = 0;
% an = ((2*A) / ((n*pi)^2)) * (cos(n*pi) - 1);
a = 0;
for n = 1:100
    
    a = a + (((2*A) / ((n*pi)^2)) * (cos(n*pi) - 1) * cos(n * 2 * pi * t));
    
end

ft = (a0 / 2) + a + bn;

plot(t,ft,'r')
title('Question 3 Part b')
legend('Location','southoutside')
legend('Trangle Wave form with A = 1', 'Fourier Series Synthesis equation')
xlabel('Time (sec)');
ylabel('Amplitude');
grid on
