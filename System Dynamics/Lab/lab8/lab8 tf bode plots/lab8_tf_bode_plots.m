% Wesley Schumacher
% Group 41
% Lab 8 experiment MATLAB

clc;close all;
%lab8 bode plots

R = 5.1*10^3;
C = 3.3*10^-6;

figure(1)
subplot(2,2,1)
G = tf(1, [R*C 1])
bode(G)
title('RC 33uF')

R = 5.1*10^3;
C = 0.1*10^-6;

subplot(2,2,2)
G = tf(1, [R*C 1])
bode(G)
title('RC 0.1uF')

R = 5.1*10^3;
C = 3.3*10^-6;

subplot(2,2,3)
G = tf(1, [1/(R*C) 1])
bode(G)
title('CR 33uF')

R = 5.1*10^3;
C = 0.1*10^-6;

subplot(2,2,4)
G = tf(1, [1/(R*C) 1])
bode(G)
title('CR 0.1uF')


