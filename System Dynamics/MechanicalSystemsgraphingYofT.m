clear all
clc
close all

DT = 0.001;
t1 = 0:DT:2;
t2 = 2 + DT:DT:5;
t = [t1 t2];

RC = 0.1;
% lowering your RC value will cause it to charge higher RC = 0.1

y1 = 1 - exp(-t1/RC);
y2 = - exp(-t2/RC) + exp(-(t2-2)/RC);

y = [y1 y2];
plot(t,y, 'linewidth',8)
%changing line witdth to 8 and make RC = 0.1
hold on
plot(t1,y1, 'r', 'linewidth',2)
plot(t2,y2, 'g', 'linewidth',2)