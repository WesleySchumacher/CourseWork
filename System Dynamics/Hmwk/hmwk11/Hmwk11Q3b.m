% Lane Levine, Derrick Rasser, Wesley Schumacher
% Group 41
% HW11 Q3.b MATLAB

clear all; close all; clc;
format long


figure(1)
Fs=160;
t=-2:4/Fs:2; 

f = [0:1/20:1 0.95:-1/20:0 0.05:1/20:1 0.95:-1/20:0 0.05:1/20:1 0.95:-1/20:0 0.05:1/20:1 0.95:-1/20:0 ];
plot(t,f,'b')
xlim([-2 2])
xlabel('Time (sec)');
ylabel('Amplitude');
hold on;


sum = 0;
syms t
a0 = 1;
for n=1:5
        %finding the coefficients 
    an=((2*a0)/(n * pi)^2 * (cos(n*pi)-1)); 
    bn=0;    
    sum=sum+(an*cos(2*pi*n*t)+bn*sin(n*t));  
end 
ezplot(t,(sum+a0/2));
title('Question 3 Part b')
legend('Trangle Wave form with A = 1', 'Fourier Series Synthesis equation')
xlabel('Time (sec)');
ylabel('Amplitude');


% A= 1;
% A0 = A;
% ft=0;
% N=1; 
% ft = (1/2) * A;
% for n=1:0.05:A
%     %Even Function synthesis Equation
%     %ft = 1/2 Ao + sum( An * cos(n * Wo * t)
%     ft = ft +((2*A)/(n * pi)^2 * (cos(n*pi)-1)) *  cos(2*pi*n);
%     
% end
% plot(t,ft,'r');




