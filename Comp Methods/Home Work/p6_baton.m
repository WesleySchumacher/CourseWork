function[y_return]=p5_baton(t_in)

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

end  % 
