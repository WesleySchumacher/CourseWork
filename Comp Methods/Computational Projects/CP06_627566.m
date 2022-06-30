%% Wesley Schumacher
% ME ID:627-566
% MCEN 3030 Computational Methods
% Spring 2020
%Computational Project 6

%% House-keeping Runner function
clear all; clc; close all;
 format long

fprintf('Problem #1 \n')

global c m g ;
c = 0.5;
m = 1.5;
g = 9.8;
targetx = 0.9;
targety = (1.25+1.50)/2;

%initial guesses of Vo = 8 and theta = 60
initialguess = [5 74];


fprintf(' part (a) \n')

options = optimset('TolFun',0.01);
z = fsolve(@functionhandle, initialguess,options);

Vi1 = z(1);
Theta1 = z(2);
fprintf('initial vertical velocity,V(0) = %f (m/s)\n', Vi1)

fprintf('initial angle = %f (degrees)\n', Theta1)

fprintf(' part (b) \n')
xint = 0;
    yint = 0;

 %initializing velocity at 0 and theta at 0
 V0 = z(1);
 theta = z(2);

 %calculating V0 in x coordiant and y coordinate
 dxdtint = V0*cos((theta*2*pi)/360);
 dydtint = V0* sin((theta*2*pi)/360);

 vint = [xint yint dxdtint dydtint];

 t_init  = 0;
 t_final = 5;
 tspan  = [t_init t_final];

 % error control:
 optionsc = odeset('AbsTol',0.001);

 %MATLAB’s internal ODE solvers
 [t,v] = ode45(@q1ode, tspan, vint, optionsc);
 
 h = [0.867053843837156,1.32447556529423;0.990963460238743,1.29341538614305]    ;
 
 A= [0.867053843837156,1.32447556529423];
 B= [0.990963460238743,1.29341538614305];
 ypeak = interp1(A,B,0.9);
 ypeak1 = interp1(v(:,1),v(:,2),0.9);
 timepeak = interp1(v(:,1),t,0.9);
 height = 0.9*((h(2)-h(4))/h(1)-h(3));
fprintf('Vertical height at the time at which the bird will bepassing through the wall: %f \n', abs(ypeak1) )
fprintf('the time at which the bird will bepassing through the wall: %f \n', abs(timepeak))

fprintf(' part (c) \n')
 %see code above
fprintf(' part (d) \n')
 %see code above

fprintf(' \n')


fprintf('Problem #2 \n')
fprintf(' part (a) \n')
global xend ;

tb = 0:0.01:2;
for i = 1:length(tb)
   f= distance_calulator(tb(i)); 
end
optionsc = optimset('TolFun', 0.01);
tb1 =0.9;
tbeta= fzero(@distance_calulator,tb1,optionsc);


fprintf(' part (b) \n')
fprintf(' value of x = %f \n', xend)
fprintf(' part (c) \n')
 %see code above
fprintf(' part (d) \n')
 %see code above

fprintf(' see Figure 2 \n')
fprintf(' \n')

fprintf('Problem #3 \n')
fprintf(' see Figure 3 \n')
 % setup discrete system and constants
dt  = 0.3;            % length
m1  = 0.5;            % kg
g1 = 9.8;
c1 = 0.75;
b = (dt*c1)/2 ;     % spacing
x  = 0:dt:3;
N  = 11;  

% boundary values
Y1 = 0;
Y11 = 0;

A = (-2*m1)*diag(ones(N-2,1),0) + (m1-b)*diag(ones(N-3,1),-1) + (m1+b)*diag(ones(N-3,1),+1);


C  = zeros(N-2,1);
C(:) = dt^2*(-m1*g1);
C(1) = C(1) - Y1;
C(end) = C(end) - Y11;

X = [Y1; A\C; Y11];

% plot
figure(3)
plot(x,X,'-bx')
title("plot of the bird’s trajectory (problem 3)")
xlabel('t (seconds)')
ylabel('Y(x) (meters)')
 
fprintf(' part (c) \n')
X1= [0;5.31472618130684]  ;
X2 = [0,0.300000000000000];
Viy = 5.31472618130684/0.300000000000000; 

fprintf('initial vertical velocity,Vy(0) = %f (m/s)\n', Viy)

Angle = 90- 1/tand(5.31472618130684/0.300000000000000);
fprintf('initial angle = %f (degrees)\n', Angle)
fprintf('The initial velocity and angle were both greater than the max Vy = 10 (m/s) and theta = 80 degrees \n')
Vy0 = 10*sind(80);
%V0 = 10*sind(80)
a = 9.8 ;%(m/s^2)
%Vx = V0 + a* t
%  0= 10*sind(80)* -9.8*t 
t3 = (Vy0/a) *2;
fprintf('Longest fuse time that would be feasible = %f (seconds)\n', t3)


%% Sup-Fumctions BELOW


%% Function for question 2
function [f] = functionhandle(z)
       %--------------------------------------------------
    % ODE IVP solver with Euler implicit (bwd) method
    % inputs:
    %  f      = ODE function = dy/dt
    %  yinit  = initial value, y(tinit)
    %  tinit  = initial time
    %  tfinal = final time
    %  h      = time step, t(i+1) - t(i)
    % output:
    %  y      = ODE solution y(t)



    targetx = 0.9;
    targety = (1.25+1.50)/2;
    xint = 0;
    yint = 0;

     %initializing velocity at 0 and theta at 0
     V0 = z(1);
     theta = z(2);

     %calculating V0 in x coordiant and y coordinate
     dxdtint = V0*cos((theta*2*pi)/360);
     dydtint = V0* sin((theta*2*pi)/360);

     vint = [xint yint dxdtint dydtint];

     t_init  = 0;
     t_final = 5;
     tspan  = [t_init t_final];

     % error control:
     optionsb = odeset('AbsTol',0.001);

     %MATLAB’s internal ODE solvers
     [t,v] = ode45(@q1ode, tspan, vint, optionsb);


     imax = length(t);
     for i = 1:imax
        if v(i,1) < targetx %targetx  % = 0.9
            x(i) = v(i,1);
            y(i) = v(i,2);
            dxdt(i) = v(i,3);
            dydt(i) = v(i,4);
            index = i;


        end
     end 
    %plotting the various x and y values  
    plot(x,y)

    hold on
    j = 0:0.05:1.25;
    plot(0.9,j,'*r')
    j = 1.5:0.05:3;
    plot(0.9,j,'*r')
    hold off
    ylim([0 3])
    xlim([0 5])
    title("plot of the bird’s trajectory")
    xlabel('x(t) (meters)')
    ylabel('y(t)  (meters)')
    legend('birds trajectory', 'wall')

    f(1) = targety - y(end);
    f(2) = dydt(end);


end

function [dvdt] = q1ode(t,v)
    %--------------------------------------------------
    %v(1) = x = x position
    %v(2) = y = y position
    %v(3) = dxdt = velocity x direction
    %v(4) = dydt = velocity y direction
    %--------------------------------------------------

    %parameters and constrants
    global c m g ;

    % x position
    dvdt(1) = v(3);

    % y position
    dvdt(2) = v(4);

    %dx/dt = velocity x direction
    dvdt(3) = -c * v(3)* abs(v(3))/m;

    %dy/dt = velocity y direction
    dvdt(4) = -g-c*v(4) * abs(v(4))/m;

    %transpose vector
    dvdt = dvdt';

end

function [d] = distance_calulator(tb1)
    global tb xend;
    tb = tb1;
    xend = 0;
    V0 = 6.785770028;
    theta = 72.06845850;

    targetxdir = 4;
    xint = 0;
    yint = 0;

    %calculating V0 in x coordiant and y coordinate
     dxdtint = V0*cos((theta*2*pi)/360);
     dydtint = V0* sin((theta*2*pi)/360);

     vint = [xint yint dxdtint dydtint];

     t_init  = 0;
     t_final = 5;
     tspan  = [t_init t_final];

     % error control:
     optionsc = odeset('AbsTol',0.001);

     %MATLAB’s internal ODE solvers
     [t,v] = ode45(@q2ode, tspan, vint, optionsc);


     imax = length(t);
     for i = 1:imax
        if v(i,2) > 0
            x(i) = v(i,1);
            y(i) = v(i,2);
            dxdt(i) = v(i,3);
            dydt(i) = v(i,4);
            index = i;
        end
     end
     indexmax = index;
     x(end+1) = x(end) + (v(indexmax+1,1)- x(end))/(abs(v(indexmax+1,2)-y(end)))*y(end);
                
     y(end+1) = 0;
     figure(2)
     plot(x,y)
     title("plot of the bird’s trajectory with boost(problem 2)")
     xlabel('x(t) (meters)')
     ylabel('y(t)  (meters)')
%      legend('birds trajectory', 'wall')
     hold on
     j = 0:0.05:1.25;
     plot(0.9,j,'*r')
     j = 1.5:0.05:3;
     plot(0.9,j,'*r')
     hold off
     d = targetxdir - x(end);
     xend = x(end);

end

function [dvdt] = q2ode(t,v)
    %--------------------------------------------------
    %v(1) = x = x position
    %v(2) = y = y position
    %v(3) = dxdt = velocity x direction
    %v(4) = dydt = velocity y direction
    %--------------------------------------------------

    %parameters and constrants
    global c m g tb;

    % x position
    dvdt(1) = v(3);

    % y position
    dvdt(2) = v(4);

    %dx/dt = velocity x direction
    dvdt(3) = -c * v(3)* abs(v(3))/m+ stepfun(t,tb)*380;

    %dy/dt = velocity y direction
    dvdt(4) = -g-c*v(4) * abs(v(4))/m;

    %transpose vector
    dvdt = dvdt';

end

function y = stepfun(t,to)
    %STEPFUN  Unit step function.
    %
    %   STEPFUN(T,T0), where T is a monotonically increasing vector,
    %   returns a vector the same length as T with zeros where T < T0
    %   and ones where T >= T0.

    %   J.N. Little 6-3-87
    %   Copyright 1986-2002 The MathWorks, Inc. 

    [m,n] = size(t);
    y = zeros(m,n);
    i = find(t>=to);
    if isempty(i)
        return
    end
    i = i(1);
    if m == 1
        y(i:n) = ones(1,n-i+1);
    else
        y(i:m) = ones(m-i+1,1);
    end
end