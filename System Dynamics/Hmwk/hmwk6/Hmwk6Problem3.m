% Lane Levine, Derrick Rasser, Wesley Schumacher
% Group 41
% Homework 6 Problem 2 MATLAB
% System Dynamics
clc; clear all; close all;

%a
figure()
Num = [1 +22];
Den = conv([1 11], [1 2 4]);
G1 = tf(Num,Den);
DCgain = 22/(11);
step(G1)
hold on
G2 = tf(DCgain, [1 2 4]);
step(G2)
legend('original system','approximated system','Location','SouthEast')
title ('G(s)')