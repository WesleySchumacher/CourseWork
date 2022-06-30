% Wesley Schumacher
% In class F-16 example  MATLAB
% System Dynamics

clc; clear all; close all;

figure()
Num = 1;
Den = [1 -2 -3];
G1 = tf(Num,Den);
step(G1)

%using feed back control to make it stable
figure()
G = tf(1,[1 -2 -3])
pzmap(G)


K = 40
%controller
C = K * tf([1 20], 1)
T = C * G/(1 + C*G)
zpk(T)
T = minreal(T)
zpk(T)
pzmap(T)
step(T)
