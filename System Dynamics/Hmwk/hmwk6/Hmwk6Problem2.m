% Lane Levine, Derrick Rasser, Wesley Schumacher
% Group 41
% Homework 6 Problem 2 MATLAB
% System Dynamics
clc; clear all; close all;

%a
figure()
subplot(3,2,1) 
Num = 36;
Dem = [1 6 36];
G1 = tf(Num,Dem);
step(G1)
title ('G1')

%b
subplot(3,2,2) 
Num = 0.36;
Dem = [1 0.6 0.36];
G2 = tf(Num,Dem);
step(G2)
title ('G2')

%c
subplot(3,2,3) 
Num = 36;
Dem = [1 18 36];
G3 = tf(Num,Dem);
step(G3)
title ('G3')

%d
subplot(3,2,4) 
Num = 0.36;
Dem = [1 1.8 0.36];
G4 = tf(Num,Dem);
step(G4)
title ('G4')

%e
subplot(3,2,5) 
Num = 1;
Dem = [1 10];
G5 = tf(Num,Dem);
step(G5)
title ('G5')

%f
subplot(3,2,6) 
Num = 10;
Dem = conv([1 1], [1 10]);
G6 = tf(Num,Dem);
step(G6)
title ('G6')