%% Wesley Schumacher
% ME ID:627-566
% MCEN 3030 Computational Methods
% Spring 2020
% Home work 6

%% Question 1
clear all; clc; close all; 
format long;

%part (a)
% parameters
global s r b 
s = 10;
r = 28;
b = 8/3;


% initial conditions
x_init = 5;
y_init = 5;
z_init = 5;

% integration range
t_init  = 0;
t_final = 35;

v_init = [x_init y_init z_init];
tspan  = [t_init t_final];


% error control:
options = odeset("RelTol",0.00001);

% solve
[t,v] = ode45(@LorenzODE, tspan, v_init, options);

% analyze solution
x = v(:,1);
y = v(:,2);
z = v(:,3);

fprintf("Problem 1 part (a)  \n");
fprintf("fluid velocity = x(t = 10) = %f  \n", x(10));
fprintf("temperature gradient = y(t = 10) = %f  \n", y(10));
fprintf("heat flow = z(t = 10) = %f  \n", z(10));


%part (b)

% initial conditions
x_init = x(10);
y_init = y(10);
z_init = z(10);

% integration range
t_init  = 10;
t_final = 35;

v_init = [x_init y_init z_init];
tspan  = [t_init t_final];

% error control:
options = odeset("RelTol",0.00001);

% solve
[t2,v] = ode45(@LorenzODE, tspan, v_init, options);

% analyze solution
x2 = v(:,1);
y2 = v(:,2);
z2 = v(:,3);

fprintf("Problem 1 part (b)  \n");
fprintf("fluid velocity = x(t = 10) = %f  \n", x2(10));
fprintf("temperature gradient = y(t = 10) = %f  \n", y2(10));
fprintf("heat flow = z(t = 10) = %f  \n", z2(10));

%part (c)
fprintf("Problem 1 part (c)  \n");
fprintf("see figure(1)  \n");

figure(1);
plot(t,x,'-r')
hold on
plot(t2,x2,'-b')
xlabel("t")
ylabel("fluid velocity (m/s)")
title("Problem 1 part (c)")
legend("initial conditions = 5, t = 0-35","initial conditions = from part(a), t = 10-35")
fprintf(" \n");


%% Question 2
clear all; clc; close all; 

%part (a)
% parameters
global r 
r = 1;

% initial conditions
x1_init = 2;
x2_init = 2;
x3_init = 2;

% integration range
t_init  = 0;
t_final = 20; % 1 = 1 month

v_init = [x1_init x2_init x3_init];
tspan  = [t_init t_final];

% error control:
options = odeset('RelTol',0.00001);
rvals = 1:2:5;
for i = 1:3
    
    r = rvals(i);
    % solve
    [t,v] = ode45(@predpreyODE, tspan, v_init, options);
    
    % analyze solution
    x1 = v(:,1);
    x2 = v(:,2);
    x3 = v(:,3);
    
    figure(2)
    subplot(3,1,i)
    plot(t,x1)
    hold on
    plot(t,x2)
    hold on
    plot(t,x3)
    xlabel("time(months)")
    ylabel("population ")
    titlestr = strcat("r = ", num2str(r));
    title(titlestr)
    legend("carrors","rabbits", "fox")
end
fprintf("Problem 2 part (a)  \n");
fprintf("see figure(2)  \n");

%part (b)
fprintf("Problem 2 part (b)  \n");
fprintf("The magnitudes of the final populations do not depened on the magnitudes of the initial populations. \n I changed x1_init from 2 to 4,  x2_init from 2 to 4, and  x3_init from 2 to 4 and there was no change \n in the final population magnitudes  \n");

%part (c)
fprintf("Problem 2 part (c)  \n");
for i = 1:3
    
    r = rvals(i);
    % solve
    [t,v] = ode45(@predpreyODE1, tspan, v_init, options);
    
    % analyze solution
    x1 = v(:,1);
    x2 = v(:,2);
    x3 = v(:,3);
    
    figure(3)
    subplot(3,1,i)
    plot(t,x1)
    hold on
    plot(t,x2)
    hold on
    plot(t,x3)
    xlabel("time(months)")
    ylabel("population ")
    titlestr = strcat("r = ", num2str(r));
    title(titlestr)
    legend("carrors","rabbits", "fox")
end

fprintf("see figure(3)  \n");
fprintf("The season that the rabbit population is the highest is around middle of spring or the around the 5th month(may)  \n");
fprintf(" \n");

%% Question 4
clear all; clc; close all; 

%% Question 5
clear all; clc; close all; 

%part (a)
fprintf("Problem 5 part (a)  \n");

%part (b)
fprintf("Problem 5 part (b)  \n");
fprintf("see figure(5)  \n");
% parameters
global g L m
g = 9.8; %(m/s^2)
L = 1;
m = 0.1; %(kg)

% initial conditions
O1 = (pi*1)/6;
O2 = -(pi*2)/6;
A1 = 0;
A2 = 0;

% integration range
t_init  = 0;
t_final = 10;

v_init = [O1 O2 A1 A2];
tspan  = [t_init t_final];

% error control:
options = odeset("RelTol",0.00001);

% solve
[t,v] = ode45(@doublePendulumODE, tspan, v_init, options);

p5 = v(:,3) .^2 .* sin(v(:,2) - v(:,1))./2- g./L .* sin(v(:,2));

% analyze solution
P1 = v(:,1);
P2 = v(:,2);
P3 = v(:,3);
P4 = v(:,4);

%ploting values
figure(5)

plot(t,P1)
hold on
plot(t,P2)
xlabel("t")
ylabel("Theta ")
title("Problem 5 part (b) ")

plot(t,p5)
xlabel("t")
ylabel("Theta ")
%title("Angular acceleration")
legend("Theta 1(upper mass)","Theta 2(lower mass)","d^2 O2/dt^2(lower mass)")


%% Sup Functions Below
function [dvdt] = LorenzODE(t,v)
%v(1) = x = fluid velocityu
%v(2) = y = temperature gradient
%v(3) = z = heat flow

%parameters and constrants
global s r b 

% dx/dt = ?sx + sy
dvdt(1) = -s * v(1) + s * v(2);

%dy/dt = rx ? y ? xz
dvdt(2) = r * v(1) -  v(2) - v(1) * v(3);

%dy/dt = ?bz + xy
dvdt(3) = -b * v(3) +  v(1) * v(2);

%transpose vector
dvdt = dvdt';

end


function [dvdt] = predpreyODE(t,v)
%v(1) = carrots
%v(2) = rabbits
%v(3) = fox

%parameters and constrants
global r 

% dx/dt = 
dvdt(1) = v(1) *(r -v(1)-v(2));

%dy/dt = 
dvdt(2) = v(2) *(-1 + v(1)-v(3));

%dy/dt = 
dvdt(3) = v(3) *(-1 + v(2));

%transpose vector
dvdt = dvdt';

end

function [dvdt] = predpreyODE1(t,v)
%v(1) = carrots
%v(2) = rabbits
%v(3) = fox

%parameters and constrants
global r 

% dx/dt = 
dvdt(1) = v(1) *((3*(1+sin((2*pi*(t-3))/12))) -v(1)-v(2));

%dy/dt = 
dvdt(2) = v(2) *(-1 + v(1)-v(3));

%dy/dt = 
dvdt(3) = v(3) *(-1 + v(2));

%transpose vector
dvdt = dvdt';

end

function [dvdt] = doublePendulumODE(t,v)
%v(1) = O1 = theta(1)
%v(2) = O2 = theta(2)
%v(3) = A1 = dT1/dt
%v(4) = A2 = dT2/dt

%parameters and constrants
global g L

% dT2/dt = A1
dvdt(1) = v(3);

%dT2/dt = A2
dvdt(2) =  v(4);

%dO1/dt 
dvdt(3) = v(4) ^2 * sin(v(2) - v(1))/2- g/L * sin(v(1)); % 

%dO2/dt 
dvdt(4) = v(3) ^2 * sin(v(2) - v(1))/2- g/L * sin(v(2));

%transpose vector
dvdt = dvdt';

end












