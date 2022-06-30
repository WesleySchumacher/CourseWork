% Wesley Schumacher
% System Dynamics
% Fourier Synthesis Example MATLAB

clear all; close all; clc;
format long
Fs=150;
 t=0:1/Fs:4-1/Fs;
 f=2;
 x=square(2*pi*f*t);
 figure;
 plot(t,x);
 axis([0 1 -2 2]);
 % Approximation with Fourier decomposition
 y=0;
 N=11; 
 for r=1:2:N
    y=y+sin(2*pi*f*t*r)/r;
 end
 hold on;
 plot(t,y,'r');
 xlabel('t');
 ylabel('magnitude');
 hold off;