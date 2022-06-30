%--------------------
% MCEN 3030
% Spring 2020
% Heat exchange example
%--------------------
close all; clc; clear all


% first make a plot
% setup grid
[T1,T2]=meshgrid(0:400,0:400);

% evaluate function for each coordinate
for i = 1:length(T1)
    for j = 1:length(T2)
        x = [T1(i,j); T2(i,j)];
        f1 = f(x);
        Z(i,j) = abs(norm(f1));
    end
end
meshc(T1,T2,Z)
xlabel('T1')
ylabel('T2')
zlabel('||f(x)||')
% make 3D plot


% Good initial guess
%(a) x_init = [25;  45]
 x_init = [140; 75]
%(c) x_init = [80;  150]
%(d) x_init = [0;   400]
%(e) other

 options = optimoptions('fsolve','Display','iter','StepTolerance',1e-06);
 [x,fval1] = fsolve(@f, x_init,options)
 fprintf('T1 = %f, T2 = %f  \n', x(1),x(2));

function [fret] = f(x)
%  
   
% fixed interior and exterior temps
T0 = 450;
T3 = 25;
T1 = x(1);
T2 = x(2);
% fluxes
q1 = 1E-9* ( (T0 + 273)^4 - (T1 + 273)^4);
q2 = 4 * ( T1 - T2 );
q3 = 1.3 * ( T2 - T3 )^(4/3);
% fret = [ 10e-9*(450+273)^4-(x(1)+273)^4 -4*(x(1)-x(2));
%                 4(x(1)-x(2)-1.3(x(2) -25)^(4/3)];
% define function
fret(1) = (q1 -q2);
fret(2) = (q2-q3);

end

% options = optimoptions('fsolve','Display','iter','Jacobian','on','StepTolerance',1e-06);
% [x,fval1] = fsolve(@f_And_J, x0,options)
