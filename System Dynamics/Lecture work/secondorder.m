clear all; close all; clc;

%first order system
Khat = 1;
a = 10;
DW = 0.001;
w = DW:DW:100;
Mag = Khat *a./(sqrt(a.^2 + w.^2));
figure(1)
plot(w,Mag)
%loglog
figure(2)
subplot(2,1,1)
plot(log10(w),log10(Mag))
Phase = -atan2(w,a);
subplot(2,1,2)
plot(log10(w), Phase*180/pi)

%second order system
m = 1;
b = 0.1; %underdamped
k = 1;
wn = sqrt(k/m);
zeta = b/(2*m*wn);
Mag = Khat * wn^2 ./ sqrt((wn.^2- w.^2).^2 + 4*zeta^2 *wn^2);
figure(3)
plot(w,Mag)
figure(4)
plot(log10(w),20*log10(Mag))

m = 1;
b = 0.01; %more underdamped
k = 1;
wn = sqrt(k/m);
zeta = b/(2*m*wn);
Mag2 = Khat * wn^2 ./ sqrt((wn.^2- w.^2).^2 + 4*zeta^2 *wn^2);
hold on
plot(log10(w),20*log10(Mag2)) % dangerous because we can get close to resonancy

%bode plot function
figure(5)
G = tf(1, [m b k])
bode(G)

figure(6)
G = tf([20], [1e-6 0.1 1300 4e7])
bode(G)


