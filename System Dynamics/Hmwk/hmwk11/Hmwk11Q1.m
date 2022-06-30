% Lane Levine, Derrick Rasser, Wesley Schumacher
% Group 41
% HW11 Q1 MATLAB

clear all; close all; clc;
format long


G = tf(10000,[1 10001 10000])
bode(G)

p = [1 10001 10000];
r = roots(p)
