function[] = ode_ivp_class()
% MCEN 3030
% Spring 2019
% ODE IVP class example
clear all; close all; clc
format long;

% define test case
h      = 0.5;
tinit  = 0;
tfinal = 5;
yinit  = 2;

f = @(y,t) 4 .* exp(0.8.*t) - 0.5 .* y;

%-------------------------------------------
% solve ODE
%-------------------------------------------
y_exp  = euler_exp(f,yinit, tinit, tfinal, h);
y_imp  = euler_imp(f,yinit, tinit, tfinal, h);
y_mid  = euler_mid(f,yinit, tinit, tfinal, h);
y_mod  = euler_mod(f,yinit, tinit, tfinal, h);
%-------------------------------------------
% plot numerical solutions vs true solution
%-------------------------------------------

% true solution from solving ODE analytically by hand
yt = @(t) ( (2 - 4/1.3).*exp(-0.5.*t) + 4/1.3 .* exp(0.8.*t) );

% plot true
tf = 0:0.01:tfinal;
plot(tf,yt(tf),'-k')
xlabel('t')
ylabel('y(t)')
set(gca,'FontSize',8)

t = tinit:h:tfinal;
hold on
plot(t,y_exp,'-or')
plot(t,y_imp,'-ob')
plot(t,y_mid,'-oc')
plot(t,y_mod,'-om')
legend('true','Euler exp', 'Eul imp', 'mid pt', 'mod')




%calc error
err_exp = abs((y_exp(end) - yt(tfinal)) / yt(tfinal))

err_imp = abs((y_imp(end) - yt(tfinal)) / yt(tfinal))

err_mid = abs((y_mid(end) - yt(tfinal)) / yt(tfinal))

err_mod = abs((y_mod(end) - yt(tfinal)) / yt(tfinal))
end



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

% (a) 
for i = 1:imax-1
            
	y(i+1) = y(i) + h * f(y(i),t(i));
    
end

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

% solve

% (a) 
for i = 1:imax-1
    
    %y(i+1) = y(i) + h * f(y(i+1),t(i+1));
	y(i+1) = (y(i) +  4 *h * exp(0.8* t(i+1)))/(1+0.5*h);
    
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

% (a) 
for i = 1:imax-1
     
    %estimate y at mid point
	ymid = y(i) + h/2 * f(y(i),t(i));
    
    
    %
    y(i+1) = y(i) + h * f(ymid, t(i) +h/2);
end

end


function [y] = euler_mod(f, yinit, tinit, tfinal, h)
%--------------------------------------------------
% ODE IVP solver with Euler modified (fwd) method
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

% (a) 
for i = 1:imax-1
     
    %equation 25.36a in chapra
    K1 = f(y(i),t(i));
    yhat = y(i) + h* K1;
    
    %equation 25.36b
    K2 = f(yhat, t(i+1));
    phi = 1/2 * (K1 +K2);
    
    %equation 25.36
    y(i+1) = y(i) +h * phi;
    
    
    err = 999;
    while err > 1e-09
        
        yhat = y(i) + h* phi;
    
        %equation 25.36b
        K2 = f(yhat, t(i+1));
        phi = 1/2 * (K1 +K2);
    
        %equation 25.36
        y(i+1) = y(i) +h * phi;
    
        err = abs( y(i+1) - yhat);
    end
end

end
