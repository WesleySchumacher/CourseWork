% MCEN 3030
% Spring 2020
% Heat example BVP
% With finite difference

clear all; clc; close all

% setup discrete system and constants
L  = 10;            % length
N  = 6;             % # of nodes
dx = L/(N -1);      % spacing
h  = 0.01;
b  = - h * dx^2;
x  = 0:dx:L;
Ta = 20;

% boundary values
TA = 40;
TB = 400;

A = (b-2)*diag(ones(N-2,1),0) + 1*diag(ones(N-3,1),-1) + 1*diag(ones(N-3,1),+1);

C = [b*Ta - TA; b*Ta; b*Ta; b*Ta - TB];

T = [TA; A\C; TB];
% solve 
% (a) T =  A \ c;
% (b) T = [TA; A\c; TB];
% (c) T = [TA A\c TB];
% (d) T = A / c;
% (e) none of these

% plot
plot(x,T,'-bx')
xlabel('x')
ylabel('T(x)')

