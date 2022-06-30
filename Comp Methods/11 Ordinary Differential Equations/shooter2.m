clear all; close all

%we like to find the root of what function g(x)?
g = @(x)  get_TL(x) -400

%(a)  get_TL(x)
%(b)  get_TL(x)-40
%(c)  get_TL(x)-400   CORRECT ANSWER
%(d)  abs(get_TL(x)-400)
%(e) other
%use any root finding method

x = fzero(g,11.42)



function[Tret] = get_TL(v2_init)
global h Ta

% define parameters
Ta = 20;
h  = 5e-8;
L  = 10;

x_init  = 0;
x_final = L;
v1_init  = 40;  
%guess = 12+(12-11)/(515.1-316.2)*(400-515.1)
%v2_init  = 11.4213;  % just a guess! 

x_span = [x_init x_final];
v_span = [v1_init v2_init];

[x, v] = ode45(@diffeq, x_span, v_span);

T = v(:,1);

fprintf('T(L) estimated with dT(0)/dx = %.1f is %.1f \n ', v2_init, T(end))

plot(x,T,'-m')
xlabel('x')
ylabel('T')

Tret = T(end);
end

function[dvdx] = diffeq(x,v)

global h Ta

% v(1) = T
% v(2) = y = dT/dx

dvdx(1) = v(2);
dvdx(2) = h * ( v(1) - Ta )^4;

dvdx = dvdx';

end

