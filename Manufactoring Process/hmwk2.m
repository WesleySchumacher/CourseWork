%% Wesley Schumacher
% MCEN 4026 Manufactoring
% Spring 2020
% HW2 Problem 5

Q = 0.004 /60; %[m^3 / sec] 
r = 5 * 0.001; %[m]
A = pi* r^2;
Vel = Q/A;
l = 20 * 0.001; %[m]
p = 2700; %[kg/m^3]
n = 4 *10^-3; %[Pa*s]
V = pi* r^2 *l;
s = V/Q;
v = l/s;

Re = (p *v *2*r)/n

figure(1)
Q = 0.001/60:0.00001:0.016/60;
s = V* Q.^-1;
v1 = l*s.^-1;
Re = (p *v1 *2*r)/n;
plot(Q,Re)
xlabel("Volumetric Flow Q [m^3/s]")
ylabel("Re")
title("Re as a function of Q")

figure(2)
radius = 1.25/1000:0.0001:20/1000;
Q = 0.004 /60; %[m^3 / sec] 
l = 20 * 0.001; %[m]
V = pi.* radius.^2 *l;
s = V.* Q.^-1;
v = l*s.^-1;
Re = (p .*v .*2.*radius)./n;
plot(radius,Re)
xlabel("Radius [m]")
ylabel("Re")
title("Re as a function of radius")

figure(3)
lenght = 5/1000:0.0001:80/1000;
r = 5 * 0.001; %[m]
V = pi* r^2 .*lenght;
s = V* Q.^-1;
v = lenght.*s.^-1;
Re = (p .*v .*2.*r)./n;
plot(lenght,Re)
xlabel("length [m]")
ylabel("Re")
title("Re as a function of length")


