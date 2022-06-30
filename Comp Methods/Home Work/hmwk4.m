%% Wesley Schumacher
% ME ID:627-566
% MCEN 3030 Computational Methods
% Spring 2020
% Home work 4

%% House-keeping Runner function
clear all; clc; close all; 

%% Question 1
clear all; clc; close all; 

%part a)  2-point centered FD 
f1 = @(x) 2*x^3 -x^2 + 5;
x1 = 1;
h1 = 0.01;
fd1 = ( f1(x1 + h1) - f1(x1 - h1)) / (2*h1);
fprintf('Question 1 part (a) \n');
fprintf('Using  2-point centered, FD = %f \n', fd1);

%part b) 3-point forward FD
f2 =  @(x) cos(x)/(log(2*x*1));
x2 = 3;
y2 = 1;
h2 = 0.1;
%fd2 = ( f2(x2,y2) - 2*(f2(x2 + h2, y2 + h2)) + (f2(x2 + 2*h2, y2 +2*h2))) / (h2^2);
fd2 = (-3*(f2(x2)) + 4*(f2(x2 + h2)) - (f2(x2 + (2*h2)))) / (2*h2);
fprintf('Question 1 part (b) \n');
fprintf('Using  3-point forward, FD = %f \n', fd2);

%part c)3-point central FD approximation 
f3 =  @(x) 2*x^2 /((1-x)^(-x));
x3 = 3;
h3 = 0.0005;
fd3 = (f3(x3- h3) -2*(f3(x3)) + f3(x3 + h3))/ (h3^2);
fprintf('Question 1 part (c) \n');
fprintf('Using  3-point central, FD = %f \n', fd3);

%part d) ?2f(x,y) /?x?y 
f4 =  @(x,y)  2*x^2 +4*x^2 * y -3*y^2;
x4 = 4;
y4 = 5;
h4x = 0.01;
h4y = 0.1;
fd4 = ( f4(x4+h4x,y4+h4y) - f4(x4+h4x,y4-h4y)- f4(x4-h4x,y4+h4y) +f4(x4-h4x,y4-h4y)) /(4*h4y*h4x);
fprintf('Question 1 part (d) \n');
fprintf('Using  ?2f(x,y) /?x?y, FD = %f \n', fd4);

%% Question 2
clear all; clc; close all; 
f =  @(x) 2*exp(x) + x*cos(x);
dfdx = @(x)  2*exp(x) - x*sin(x) + cos(x);
xi = 5;
h1 = [1 0.5 0.25 0.125 0.0625 0.03125];
h = 1;
fprintf('Question 2 part (a) Using three-point forward di?erence scheme \n');
%part a)  three-point forward di?erence scheme
fprintf(' h         Fd approximation  err_est   err_tru \n');
fprintf(' -----------------------------------------------\n');
for n = 1:7
    h_save(n) = h;
    
    fd_1st(n) = ( -3*(f(xi))+4*f(xi+h) - f(xi +2*h) ) / (2*h);
    
    %true relative error
    %part c) 
    err_tru(n) = abs((dfdx(xi)-fd_1st(n)) /dfdx(xi));
    
    %estimate relative error
    if n>1
        %part d) 
        err_est(n) = abs((fd_1st(n)-fd_1st(n-1)) /  fd_1st(n));
        fprintf(' %f   %f       %f   %f \n', h_save(n-1),fd_1st(n-1), err_est(n), err_tru(n-1));
    end
    
    h = h/2;
end


loglog(h_save(1:6), err_tru(1:6))
xlabel(' h ')
ylabel(' true error ')
title('logarithmic scale of true error as a function of stepsize h')
hold on;

fprintf(' \n');

%part b)  four-point central di?erence scheme
fprintf('Question 2 part (b) Using four-point central di?erence scheme  \n');
fprintf(' h         Fd approximation  err_est    err_tru \n');
fprintf(' ------------------------------------------------\n');
h = 1;

for n = 1:7
    h_save1(n) = h;
    
    fd_1st1(n) = ((f(xi - 2*h))-8*f(xi-h) + 8*f(xi+h) - f(xi +2*h) ) / (12*h);
    
    %true relative error
    %part c)
    
    err_tru1(n) = abs((dfdx(xi)-fd_1st1(n)) /dfdx(xi));
    
    %estimate relative error
    if n>1
        %part d) 
        err_est1(n) = abs((fd_1st1(n)-fd_1st1(n-1)) /  fd_1st1(n));
        fprintf(' %f   %f       %f   %f \n', h_save1(n-1),fd_1st1(n-1), err_est1(n), err_tru1(n-1));
    end
    
    h = h/2;
end
loglog(h_save1(1:6), err_tru1(1:6))
legend(' three-point forward di?erence',' four-point central di?erence','Location','NorthWest')
fprintf(' \n');
fprintf('  \n');
fprintf(' \n');
 

%% Question 3
clear all; clc; close all; 
format long
f =  @(x) 3*exp(2*x);
xi = 2;
h = 1;
fprintf('Question 3 Using  four-point central ?nite di?erence estimation  \n');
fprintf(' h                    Fd approximation           err_est   \n');
fprintf(' ---------------------------------------------------------------\n');
n = 1;
while h >= eps
    h_save(n) = h;
    
    fd_1st(n) = ((f(xi - 2*h))-8*f(xi-h) +8*f(xi+h) - f(xi +2*h) ) / (12*h);
    
    
    %estimate relative error
    if n>1
        %part d) 
        err_est(n) = abs((fd_1st(n)-fd_1st(n-1)) /  fd_1st(n));
        fprintf(' %.16f   %.16f      %.16f  \n', h_save(n-1),fd_1st(n), err_est(n-1));
    end
    
    h = h/10;
    n = n+1;
end
figure(2)
loglog(h_save,err_est)
xlabel(' h ')
ylabel(' true error ')
title('logarithmic scale of true error as a function of stepsize h')
legend('four-point central ?nite di?erence','Location','NorthWest')


%% Question 4
clear all; clc; close all; 
t = [0 0.25 0.50 0.75 1.00 1.25 1.50];
z = [287 278 264 213 167 103 12];

figure(3)
subplot(2,2,1);
plot(t,z)
xlabel(' time(seconds) ')
ylabel(' vertical distance(meters) ')
title('position of a glider vs time')
hold on

p =2;
%using polyfit with tempature, density and p as inputs
a1 = polyfit(t,z,p);
%using polyval to find the values in the polynomial
f = polyval(a1,t);
plot(t,f)
legend(' data', 'polynomial ?t','Location','NorthEast')

for i = 1:7
    h_save(i) = i;
    if t(i) == 0
        % three point forward differecne
        v(i) = (-3*z(i) +4*z(i+1)-z(i+2)) /0.5;
        
    elseif t(i) == 1.5
        % 3 point backward difference
        v(i) = (z(i-2)-4*z(i-1)+3*z(i))/0.5;
        
    %elseif t(i) ~= 1.5 || t(i) ~= 0.0
    else
        %three point central difference
        %v(i) = (z(i-1) -2*(z(i))+z(i+1))/ 0.25^2;
        %two point centeral
        v(i) = (z(i+1)-z(i-1))/0.5;
    end
end

subplot(2,2,2);
plot(t,v)
xlabel(' time(seconds) ')
ylabel(' Velocity (meters per second) ')
title('velocity of a glider vs time')

hold on

%pv =2;
%using polyfit with tempature, density and p as inputs
%a1v = polyfit(v,z,p);
%using polyval to find the values in the polynomial
a1v =[a1(1)*2 a1(2)];
fv = polyval(a1v,t);
plot(t,fv)
legend(' velocity data', 'polynomial ?t','Location','NorthEast')

for i = 1:7
    h_save(i) = i ;
    if i == 1
        % four point forward differecne
        a(i) = (2*z(i) - 5*z(i+1) +4*z(i+2) -z(i+3)) /(0.25*0.25);
        
    elseif i == 7 || i == 6
        % four point backward difference
        a(i) = (-z(i-3)+4*z(i-2)-5*z(i-1)+2*z(i))/(0.25*0.25);
        
    %elseif t(i) ~= 1.5 || t(i) ~= 0.0
    else
        %three point central difference
        a(i) = (z(i-1)-2*z(i)+z(i+1))/(0.25*0.25);
    end
    
end
subplot(2,2,3);
plot(t,a)
xlabel(' time(seconds) ')
ylabel(' Accleration (meters per second) ')
title('Accleration of a glider vs time')

hold on

%pa =2;
%using polyfit with tempature, density and p as inputs
%a1a = polyfit(a,z,p);
a1a =[a1(1)];
%using polyval to find the values in the polynomial
fa = polyval(a1a,t);
plot(t,fa)
legend(' acceration data', 'polynomial ?t','Location','NorthEast')
%% Question 5
clear all; clc; close all; 




%% Question 6
clear all; clc; close all; 
format long
%p5_baton(1.5)

h = 0.001;
h1 = 0.002;
x = 1.5;

% calulating 4 point central difference to later use for error calculation
v4c = (p5_baton(x-(2*h)) -8*p5_baton(x-h) +8*p5_baton(x+h) - p5_baton(x+(2*h)))/(12*h);

% usign 2 point central difference
v2c = (p5_baton(x+h)-p5_baton(x-h))/(2*h);
fprintf('using two point central difference: %.16f \n',v2c );
errv2c = abs(v4c-v2c);
fprintf('Error using two point central difference with step size: (%f) : %.16f \n',h,errv2c );
%calculating 2 point central difference using a different step size
v2c1 = (p5_baton(x+h1)-p5_baton(x-h1))/(2*h1);
% calculating error of different step size
errv2c1 = abs(v4c-v2c1);
fprintf('Error using two point central difference with step size: (%f) : %.16f \n',h1,errv2c1 );
%calculating error of the error between different step sizes of the same method
error = abs(errv2c1-errv2c);
fprintf('Pursing lower estimated error using the Richardson extrapolation approach  \n' );
fprintf('Error of the Error using two point central with 2 different step sizes: %.16f \n',error );



fprintf('\n' );
%using 4 point central difference 
v4c = (p5_baton(x-(2*h)) -8*p5_baton(x-h) +8*p5_baton(x+h) - p5_baton(x+(2*h)))/(12*h);
%v4c1 = (p5_baton(x-(2*h1)) -8*p5_baton(x-h1) +8*p5_baton(x+h1) - p5_baton(x+(2*h1)))/(12*h1);
fprintf('using 4 point central difference: %.16f \n',v4c );
errv4c = abs(v2c-v4c);
fprintf('Error using 4 point central difference: %.16f \n',errv4c );

fprintf('\n' );
% using three point backward
v3b = (p5_baton(x-2*h)-4*p5_baton(x-h) + 3*p5_baton(x))/(2*h);
fprintf('using three point backward difference: %.16f \n',v3b );
errv3b = abs(v2c-v3b);
fprintf('Error using three point backward difference: %.16f \n',errv3b );

fprintf('\n' );
% two point backwards 
v2b = (p5_baton(x)-p5_baton(x-h))/h;
fprintf('using two point backwards difference: %.16f \n',v2b );
errv2b = abs(v2c-v2b);
fprintf('Error using two point backwards difference: %.16f \n',errv2b );

fprintf('\n' );
% using three point forward difference
v3f = (-3*p5_baton(x) +4*p5_baton(x+h)-p5_baton(x+2*h))/(2*h);
fprintf('using three point forward difference: %.16f \n',v3f );
errv3f = abs(v2c-v3f);
fprintf('Error using three point forward difference: %.16f \n',errv3f );


fprintf('\n' );
% using 2 point forward differecne
v2f = (p5_baton(x +h) -p5_baton(x))/h;
fprintf('using two point forward differecne: %f \n',v2f );
errv2f = abs(v4c-v2f);
fprintf('Error using two point forward differecne: %f \n',errv2f );

fprintf('\n' );



function[y_return] = p5_baton(t_in)

% Problem parameters, shared with nested functions.
m1 = 0.5;
m2 = 0.1;
L = 2;
g = 9.81;

dt = 0.001;

if mod(t_in,dt) ~= 0 ||  t_in < 0 || t_in > 4
    display('Improper input: t_in must be between 0 and 4 and evenly divisible by 0.001')
    return
end

tspan = [0:dt:4];
y0 = [0; 4; L; 20; -pi/2; 2];
options = odeset('Mass',@mass,'MaxStep',dt);

[t, y] = ode45(@f,tspan,y0,options);

i=round(t_in/dt +1);
y_return = y(i,3);

% -----------------------------------------------------------------------
% Nested functions. Problem parameters provided by the outer function.
% 
% the solution is for x,y of upper point, now a square
   function dydt = f(t,y)
      % Derivative function
      dydt = [ y(2)
         m2*L*y(6)^2*cos(y(5))
         y(4)
         m2*L*y(6)^2*sin(y(5))-(m1+m2)*g
         y(6)
         -g*L*cos(y(5)) ];
   end
% -----------------------------------------------------------------------

function M = mass(t,y)
      % Mass matrix function
      M = zeros(6,6);
      M(1,1) = 1;
      M(2,2) = m1 + m2;
      M(2,6) = -m2*L*sin(y(5));
      M(3,3) = 1;
      M(4,4) = m1 + m2;
      M(4,6) = m2*L*cos(y(5));
      M(5,5) = 1;
      M(6,2) = -L*sin(y(5));
      M(6,4) = L*cos(y(5));
      M(6,6) = L^2;
   end
% -----------------------------------------------------------------------

end  