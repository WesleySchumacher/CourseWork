% Lane Levine, Derrick Rasser, Wesley Schumacher
% System Dynamics
% Homework 12

clear;
clc;

A = 1;
t = linspace(-2,2,100);
T = 1;
w0 = (2*pi) / T;

a0 = (6*A) / 8;
bn = 0;
% an = ((2*A) / ((n*pi)^2)) * (cos(n*pi) - 1);
a = 0;
for n = 1:20
    
    a = a + (((2*A / (n*pi)) * (sin(n*pi/2) + ((1 / (n*pi)) * (cos(n*pi/2) - 1)))) * cos(n * w0 * t));
    
end

ft = (a0 / 2) + a + bn;

figure(1)
plot(t,ft,'b')
xlabel('t')
ylabel('Amplitude')
title('Fourier Series n = 20')
grid on