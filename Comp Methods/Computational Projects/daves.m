clear all; close all; clc;
% CP06 205-474

%% p1
global g m c;
g = 9.8;
m = 1.5;
c = 0.5;

init = [5 74]; %v0, theta deg
options = optimset('TolFun',0.01);
z = fsolve(@func_hand, init, options);

axis([0 5 0 3])


%% p2

%% p3

%% functions
function b = func_hand(z)
    
    v0 = z(1);
    t = z(2);

    targ_x = 0.9;
    targ_y = (1.25+1.5)/2;
    
    x_init = 0;
    y_init = 0;
    
    dxdt_init = v0*cos(2*pi*t/360);
    dydt_init = v0*sin(2*pi*t/360);
    
    v_init = [x_init y_init dxdt_init dydt_init];
    t_span = [0 5];
    options2 = odeset('AbsTol',0.001);
    [t,v] = ode45(@positionODE, t_span, v_init, options2);

    imax = length(t);
    for i = 1:imax
        if v(i,1) < targ_x
            x(i) = v(i,1);
            y(i) = v(i,2);
            dydt(i) = v(i,4);
            n = i;
        end
    end
    plot(x,y)
    xlabel('x')
    ylabel('y')
    hold on
    plot(.9, 0:.1:1.25,'*r')
    plot(.9, 10.5:0.1:.1:5,'*r')
    hold off
    
    b(1) = targ_y - y(end); % need to be = 0
    b(2) = dydt(end);       % need to be = 0
end

function dvdt = positionODE(t, v)
    global g m c
    dvdt(1) = v(3);
    dvdt(2) = v(4);
    dvdt(4) = -g - c*v(4)*abs(v(4))/m;
    dvdt(3) = -c*v(3)*abs(v(3))/m;
    dvdt = dvdt';
end

