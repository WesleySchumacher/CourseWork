%% Wesley Schumacher
% ME ID:627-566
% MCEN 4043 System Dynamics
% Fall 2020
% HW2

%% House-keeping Runner function
clc; close all;

DT = 0.001;
t1 = 0:DT:1;
t2 = 1 + DT:DT:2;
t3 = 2 + DT:DT:15;
t = [t1 t2 t3];

y1 = t1 - (2 / sqrt(3)) * exp((1/2)* -t1) .* sin((sqrt(3)/2) * t1);
y2 = (t2 - (2 / sqrt(3)) * exp((1/2)* -t2) .* sin((sqrt(3)/2) .* t2) - 2 * ((t2-1) - (2 / sqrt(3) * exp((-1/2) * (t2-1))) .* sin((sqrt(3)/2) .* (t2-1))));
y3 = (t3 - (2 / sqrt(3)) * exp((-1/2)* t3) .* sin((sqrt(3)/2) .* t3)) - 2 * ((t3-1) - (2 / sqrt(3) * exp((-1/2)* (t3-1))) .* sin((sqrt(3)/2) * (t3-1))) + ((t3-2) -(2/sqrt(3)) * exp(( -1/2) * (t3-2)) .* sin((sqrt(3)/2) * (t3-2)));


y = [y1 y2 y3];
plot(t,y, 'linewidth',8);
xlabel("t")
ylabel("y(t)")
title("Problem 5")


hold on
plot(out.tout, out.HW2, 'k', 'linewidth',4 )
plot(t1,y1, 'r', 'linewidth',4);
plot(t2,y2, 'g', 'linewidth',4);
plot(t3,y3, 'b', 'linewidth',4);

legend("input x(t)","simulation", "Theory(Segment 1)", "Theory(Segment 2)", "Theory(Segment 3)")
xlim([0,15]);
