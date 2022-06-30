%% Wesley Schumacher
% ME ID:627-566
% MCEN 3030 Computational Methods
% Spring 2020
% Home work 5

%% Question 1
clear all; clc; close all; 

%part (a)
y = @(t) 5* exp((2/3) * sin(3*t+4)- 2/3*sin(4));
yt = @(t) 5* exp((2/3) * sin(3*t+4)- 2/3*sin(4));
t = 0:0.01:2;
figure(1)
subplot(2,2,1)
plot(t,y(t))
title("Part(a) plot of exact solution")
xlabel('t')
ylabel('y(t)')
legend('true')




%part (b)
fprintf("Question 1 part (b)  \n");

f = @(y,t) 2*y*cos(3*t+4);
h      = 0.25;
tinit  = 0;
tfinal = 2;
yinit  = 5;

y1  = euler_exp(f,yinit, tinit, tfinal, h);
sol_fwd_explicit1 = y1(end);
fprintf("Solution to ODE using Euler's foward (Explicit) method with h = 0.25 is: %f12  \n", sol_fwd_explicit1);

%error = abs( y(2) - sol_fwd_explicit);
error1 = abs((y1(end) - yt(tfinal)) );% / yt(tfinal));
fprintf("The global errorr(in comparison to the true analytical solution): %f12  \n", error1);
t    = [tinit:h:tfinal];
subplot(2,2,2)
t1 = 0:0.01:2;
plot(t1,yt(t1))
hold on
plot(t,y1)


%part (c)
fprintf("Question 1 part (c)  \n");
h      = 0.125;
t    = [tinit:h:tfinal];
y2  = euler_exp(f,yinit, tinit, tfinal, h);
sol_fwd_explicit2 = y2(end);
fprintf("Solution to ODE using Euler's foward (Explicit) method with h = 0.125 is: %f12  \n", sol_fwd_explicit2);

plot(t,y2)
title("Part(b) and part (c)")
xlabel('t')
ylabel('y(t)')
legend('true',"h=0.25" ," h=0.125", 'Location', 'Northwest')

%error = abs( y(2) - sol_fwd_explicit);
error2 = abs((y2(end) - yt(tfinal)) );
fprintf("The global errorr(in comparison to the true analytical solution): %f12  \n", error2);
errordiff = abs( error1 -  error2);
fprintf("The numerical estimate for y(2) is far more accurate with a smaller value of h \n the difference in acccuracy can be calculated by finding the difference of the error:%f \n", errordiff );



%part (d)
fprintf("Question 1 part (d)  \n");
%Euler explicit 2 point centered finite difference formula
h      = 0.25;
t    = [tinit:h:tfinal];

y3  = twopoint(f,yinit, tinit, tfinal, h);
sol_2pt = y3(end);
fprintf("Solution to ODE using 2 point method with h = 0.25 is: %f12  \n", sol_2pt);

%error = abs( y(2) - sol_fwd_explicit);
error3 = abs((y3(end) - yt(tfinal)) );% / yt(tfinal));
fprintf("The global errorr(in comparison to the true analytical solution): %f12  \n", error3);

subplot(2,2,3)
t1 = 0:0.01:2;
plot(t1,yt(t1))
hold on
plot(t,y3)
title("Part(c) plot of 2point method")
xlabel('t')
ylabel('y(t)')
legend('true',"h=0.25", 'Location', 'Northwest')


%part (e)
fprintf("Question 1 part (e)  \n");
h      = 0.25;
t    = [tinit:h:tfinal];

y4  = euler_mid(f,yinit, tinit, tfinal, h);
sol_mid = y4(end);
fprintf("Solution to ODE using Midpoint method with h = 0.25 is: %f12  \n", sol_mid);

%error = abs( y(2) - sol_fwd_explicit);
error4 = abs((y4(end) - yt(tfinal)) );% / yt(tfinal));
fprintf("The global errorr(in comparison to the true analytical solution): %f12  \n", error4);

subplot(2,2,4)
t1 = 0:0.01:2;
plot(t1,yt(t1))
hold on
plot(t,y4)
title("Part(d) plot of Midpoint method")
xlabel('t')
ylabel('y(t)')
legend('true',"h=0.25", 'Location', 'Northwest')

%% Question 2
clear all; clc; close all; 

R = 4;
r = 0.04;
g = 9.81;
f = @(y,t) -(r^2 * sqrt(2*g*y))/ (2*y*R- y^2);

h      = 0.04;
yinit  = 6.5;

[time,height]  = euler_expa(f,yinit, h);
fprintf("The number of seconds it takes for the tank to drain completely is: %f12 seconds  \n", time);
fprintf("The number of minutes it takes for the tank to drain completely is: %f12 minutes  \n", time/60);
 
fprintf("The height once it is drained completely is: %f12 ~ zero  \n", height);
%% Question 3
clear all; clc; close all; 

k =10;
f = @(y,t) -k*y;
h      = 0.25;
tinit  = 0;
tfinal = 5;
yinit  = 55;
y1  = euler_exp(f,yinit, tinit, tfinal, h);
y2  = euler_imp(f,yinit, tinit, tfinal, h);
t    = [tinit:h:tfinal];
subplot(3,1,1)
plot(t,y1)
hold on
plot(t,y2)
title("h = 0.25")
xlabel('t')
ylabel('y(t)')
legend('explicit',"implicit", 'Location', 'Northwest')

h = 0.15;
tinit  = 0;
tfinal = 5;
yinit  = 55;
y1  = euler_exp(f,yinit, tinit, tfinal, h);
y2  = euler_imp(f,yinit, tinit, tfinal, h);
t    = [tinit:h:tfinal];
subplot(3,1,2)
plot(t,y1)
hold on
plot(t,y2)
title("h = 0.15")
xlabel('t')
ylabel('y(t)')
legend('explicit',"implicit", 'Location', 'Northwest')

h = 0.05;
tini1  = 0;
tfinal = 5;
yinit  = 55;
y1  = euler_exp(f,yinit, tini1, tfinal, h);
y2  = euler_imp(f,yinit, tinit, tfinal, h);
t    = [tinit:h:tfinal];
subplot(3,1,3)
plot(t,y1)
hold on
plot(t,y2)
title("h = 0.05")
xlabel('t')
ylabel('y(t)')
legend('explicit',"implicit", 'Location', 'Northwest')
%% Sup Functions Below

function [y] = euler_exp(f, yinit, tinit, tfinal, h)
%--------------------------------------------------
% ODE IVP solver with Euler explicit (fwd) method
% inputs:
%  f      = ODE function = dy/dt
%  yinit  = initial value, y(tinit)
%  tinit  = initial time
%  tfinal = final time
%  h      = time step, t(i+1) - t(i)
% output:
%  y      = ODE solution y(t)
%--------------------------------------------------
% initialize values
y(1) = yinit;
t    = [tinit:h:tfinal];
imax = length(t);
% solve
for i = 1:imax-1
            
	y(i+1) = y(i) + h * f(y(i),t(i));  
end
end

function [y] = twopoint(f, yinit, tinit, tfinal, h)
%--------------------------------------------------
% ODE IVP solver with Euler 2 point (fwd) method
% inputs:
%  f      = ODE function = dy/dt
%  yinit  = initial value, y(tinit)
%  tinit  = initial time
%  tfinal = final time
%  h      = time step, t(i+1) - t(i)
% output:
%  y      = ODE solution y(t)
%--------------------------------------------------
% initialize values
y(1) = yinit;
t    = [tinit:h:tfinal];
imax = length(t);
% solve 
y(2) = y(1) + h * f(y(1), t(1));
for i = 2:imax-1 
    y(i+1) = y(i-1) + 2*h * f(y(i), t(i));
end
end

function [y] = euler_mid(f, yinit, tinit, tfinal, h)
%--------------------------------------------------
% ODE IVP solver with Euler midpoint (fwd) method
% inputs:
%  f      = ODE function = dy/dt
%  yinit  = initial value, y(tinit)
%  tinit  = initial time
%  tfinal = final time
%  h      = time step, t(i+1) - t(i)
% output:
%  y      = ODE solution y(t)
%--------------------------------------------------
% initialize values
y(1) = yinit;
t    = [tinit:h:tfinal];
imax = length(t);
% solve 
for i = 1:imax-1 
    %estimate y at mid point
	ymid = y(i) + h/2 * f(y(i),t(i));
    y(i+1) = y(i) + h * f(ymid, t(i) +h/2);
end
end

function [m, h1] = euler_expa(f, yinit, h)
%--------------------------------------------------
% ODE IVP solver with Euler explicit (fwd) method
% inputs:
%  f      = ODE function = dy/dt
%  yinit  = initial value, y(tinit)
%  tinit  = initial time
%  tfinal = final time
%  h      = time step, t(i+1) - t(i)
% output:
%  y      = ODE solution y(t)
%--------------------------------------------------
% initialize values
t = [0];
y = [yinit];
% solve
while(y(end) > 0)

   y = [y,y(end)+h*f(y(end))];
   t = [t, t(end)+h]; 
end
m = t(end);
h1 = y(end);
end


function [y] = euler_imp(f, yinit, tinit, tfinal, h)
%--------------------------------------------------
% ODE IVP solver with Euler impilicit (bwd) method
% inputs:
%  f      = ODE function = dy/dt
%  yinit  = initial value, y(tinit)
%  tinit  = initial time
%  tfinal = final time
%  h      = time step, t(i+1) - t(i)
% output:
%  y      = ODE solution y(t)
%--------------------------------------------------
% initialize values
y(1) = yinit;
t    = [tinit:h:tfinal];
imax = length(t);
for i = 1:imax-1   
	y(i+1) = (y(i)/(1+10*h)); 
end
end


















