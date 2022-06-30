% MCEN 3030
% Spring 2020
% Heat example BVP
% With finite difference

clear all; clc; close all

% setup discrete system and constants
L  = 10;            % length
N  = 60;             % # of nodes
dx = L/(N -1);      % spacing
h  = 0.01;
b  = - h * dx^2;
x  = 0:dx:L;
Ta = 20;

% boundary values
TA = 40;
TB = 400;



A = [b-2 1 0 0; 1 b-2 1 0; 0 1 b-2 1; 0 0 1 b-2];

C = [b*Ta - TA; b*Ta; b*Ta; b*Ta - TB];

%generic definition that scales with N
C  = zeros(N-2,1);
C(:) = b*Ta;
C(1) = C(1) - TA;
C(end) = C(end) - TB;

%Diag
A = (b-2)*diag(ones(N-2,1),0) + 1*diag(ones(N-3,1),-1) + 1*diag(ones(N-3,1),+1);

%alternative loop method
A = zeros(N-2,N-2);
for i = 1:N-2
    A(i,i) = b-2;
    if i>1
        A(i,i-1) = 1;
    end
    if i < N-2
        A(i,i+1) = 1;
    end
end
% solve 
T = [TA; A\C; TB];

% plot
plot(x,T,'-bx')
xlabel('x')
ylabel('T(x)')

