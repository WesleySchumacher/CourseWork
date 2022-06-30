

clear all; close all; clc;
figure(1)
subplot(2,3,1)
T0 = 1;
wo = 2*pi/T0;
T1 = 1;
A = 5;

t = 0:0.001:2;

y = A*T1/T0

for ii = 1:200
   an = ((2 * A)/(ii*pi)) * sin(ii*pi*T1/T0);
   y = y + an * cos(ii*wo*t);
    
end
plot(t,y)
ylim([-1 6])
title("Duty cycle: 100%")

subplot(2,3,2)
T0 = 1;
wo = 2*pi/T0;
T1 = 0.75;
A = 5;

t = 0:0.001:2;

y = A*T1/T0

for ii = 1:200
   an = ((2 * A)/(ii*pi)) * sin(ii*pi*T1/T0);
   y = y + an * cos(ii*wo*t);
    
end
plot(t,y)
title("Duty cycle: 75%")

subplot(2,3,3)
T1 = 0.5;
A = 5;

t = 0:0.001:2;

y = A*T1/T0

for ii = 1:200
   an = ((2 * A)/(ii*pi)) * sin(ii*pi*T1/T0);
   y = y + an * cos(ii*wo*t);
    
end
plot(t,y)
title("Duty cycle: 50%")

subplot(2,3,4)
T1 = 0.25;
A = 5;

t = 0:0.001:2;

y = A*T1/T0

for ii = 1:200
   an = ((2 * A)/(ii*pi)) * sin(ii*pi*T1/T0);
   y = y + an * cos(ii*wo*t);
    
end
plot(t,y)
title("Duty cycle: 25%")

subplot(2,3,5)
T1 = 0;
A = 5;

t = 0:0.001:2;

y = A*T1/T0

for ii = 1:200
   an = ((2 * A)/(ii*pi)) * sin(ii*pi*T1/T0);
   y = y + an * cos(ii*wo*t);
    
end
plot(t,y)
title("Duty cycle: 0%")