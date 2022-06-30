%% Wesley Schumacher
% ME ID:627-566
% MCEN 3030 Computational Methods
% Spring 2020
%Computational Final Project 7

%% House-keeping Runner function
clear all; clc; close all;
 format long

fprintf('Problem #1 \n')
fprintf(' part (a) \n')
Tb = 50; 
Tc = 100; 
Td = 150; 
q = 200; 
Lx = 1; 
Ly = 1;
avetemp = tempdistribution(Tb, Tc, Td, q, Lx, Ly);
fprintf(' The estimated average temperature of the slab: %f degrees Celsius \n', avetemp)
fprintf(' see Figure 1 \n')


fprintf(' part (b) \n')
Tb2 = 5; 
Tc2 = 15; 
Td2 = 75; 
q2 = -100; 
Lx2 = 2; 
Ly2 = 5;
avetemp2 = tempdistribution(Tb2, Tc2, Td2, q2, Lx2, Ly2);
fprintf(' The estimated average temperature of the slab: %f degrees Celsius \n', avetemp2)
fprintf(' see Figure 2 \n')
fprintf(' \n')


fprintf('Problem #2 \n')

dr = 0.01;   % desired spatial resolution
fprintf(' part (a) \n')
explicitFiniteDifference(dr);
fprintf(' The Largest stable time step with spatial descretization dr = 0.01 is dt = 0.005 \n');
fprintf(' see Figure 3 \n')

dr2 = 0.05;   % desired spatial resolution
explicitFiniteDifference(dr2);
fprintf(' The Largest stable time step with spatial descretization dr = 0.05 is dt = 0.120 \n');
fprintf(' see Figure 4 \n')


fprintf(' part (b) \n')
time2 = implicitFiniteDifference(dr);
fprintf(' see Figure 5 \n')

time22 = implicitFiniteDifference(dr2);
fprintf(' see Figure 6 \n')
 

fprintf(' \n')

fprintf('Problem #3 \n')

global a3 s3 Tb3 q3 L3 dx3 nx3
%initializing constand varaiables 
a3 =1;         %[m^2/s] 
Tb3 = 0;       %[K]
L3 = 1 ;       %[m]  length
s3 = 0.0001;   %[1/(K^3 *s]
q3 = 1 * 10^3; %[K/(m s)]
       
dx3 = 0.01;
nx3 = L3/dx3+1;


tf3 = 1;
dt3 = 0.01;
nt3 = tf3/dt3+1;

x3  = 0:dx3:L3;


t_init3 = 0;
t_final3 = tf3;
tspan3 = [t_init3 t_final3];

%[T1 T2 T3 T4 T5
v_init3 = zeros(1,nx3-1);

[t3,v3] = ode23s(@satelliteHeatODE,tspan3,v_init3);

T = v3;

figure(7);

%plot final equilibrium temperature distribution
plot(x3,[T(230,:) Tb3])

xlabel('t [seconds] ')
ylabel('T [Kelvin]')
title('final equilibrium temperature distribution')

maxtemp3 = max(max(T));
fprintf(' The highest temperture achieved is %f degrees Kelvin \n', maxtemp3);

fprintf(' see Figure 7 \n')


%% Sup-Fumctions BELOW


%% Function for question 1
function [avetemp] = tempdistribution(Tb, Tc, Td, q, Lx, Ly)
       %--------------------------------------------------
    % user friendly program that calculates the steady state temperature distribution for
    % a 2D rectangular slab with a heat source on the left edge and constant
    % temperatures on the other edges
    % inputs:
    %  Tb     = edge temperatures T(x, 0) = Tb
    %  Tc     = edge temperatures T(Lx, y) = Tc
    %  Td     = edge temperatures T(x, Ly) = Td
    %  q      = heat source (?T(x, y)/?x )x=0= q
    %  Lx     = length of slab in the x direction
    %  Ly     = length of slab in the y direction
    % output:
    %  out      = estimated average tempature of slab
    %              and plot the solution 3D
    
    
    % domain 
    d = 0.05;
    x = [0:d:Lx];
    y = [0:d:Ly];
    
    %initializing Error tolerance and my iteration keeper
    Tol = 1e-04;
    iteration = 0;

    
    nx = length(x);
    ny = length(y);

    %allocate a solution array
    kmax = 20000;
    T = zeros(nx,ny,kmax);
    

    T(:,1,:) = Tb; % bottom hand edge
    T(end,:,:)  = Tc; % left hand side 
    T(:,end,:) = Td; % top side

    %initial guess
    T(nx,ny,:) = (Tc + Td) / 2; % corner node
    T(nx,1,:) = (Tc + Tb) / 2; % corner node
    T(2:nx-1,2:ny-1,:) = (Tb + Tc + Td) / 3; % All the nodes

    %iterate using liebmann method
    for k = 1:kmax-1

        %loop over nodes where Tij is unknown
        for i = 1:nx-1
            for j = 2:ny-1
                
                %handle derivative DC
                if (i-1) == 0  % or i = 1 so the first row. this is the ghost node
                    % flux FD = q = (T(i+2,j) - T(i,j)) /2*delta x
                    % @ x,i = 0  q = (T(2,j)- T(0,j))/ /2*delta x
                    % solving for T(0,j)
                    % ghost node = T(0,j) = (T(2,j)-2*delta x * q
                    % @ i-1 = 0 T(i-1,j) = (T(2,j)-2*delta x * q
                    T(i,j,k+1) = 1/4*( T(i+1,j,k) + T(2,j,k) - 2*d*q + T(i,j-1,k) + T(i,j+1,k));

                else
                    % Using 3 point Centered FD for second derivative -
                    % 2nd order accurate 
                    % (T(i-1,j) - 2*T(i,j)  T(i+1,j)) /2 * delta x   + (T(i,j-1) -2* T(i,j) + T(i,j+1))/ 2 * delta y = 0
                    % delta x = delta y = delta
                    % (T(i-1,j) - 2*T(i,j)  T(i+1,j))   +(T(i,j-1) -2* T(i,j) + T(i,j+1)) = 0 *2* delta x *2 * delta 
                    % (T(i-1,j) - 2*T(i,j)  T(i+1,j))   +(T(i,j-1) -2* T(i,j) + T(i,j+1)) = 0
                    % Explicit because we can solve for T(i,j) K+1 
                    % solving for T(i,j)
                    % 4* T(i,j) = T(i-1,j) + T(i+1,j) + T(i,j-1) + T(i,j+1)
                    %T(i,j) = (T(i-1,j) + T(i+1,j) + T(i,j-1) + T(i,j+1)) /4

                    T(i,j,k+1) = 1/4*( T(i-1,j,k) + T(i+1,j,k) + T(i,j-1,k) + T(i,j+1,k));
                end
            end
        end

        err = norm( T(:,:,k) - T(:,:,k+1));

        if err < Tol
            fprintf(' converged! \n' );
            iteration = k;
            fprintf(' solution was found in %i iterations \n', iteration );
            break
        end
    end

    %To make another graph, figure 
    if (Ly > 1)
        figure(2);
    end
    
    %make 3D plot - take transpose so oriented correctly
    [X,Y] = meshgrid(x,y);
    
    
    surf(X,Y,T(:,:,k+1)')
    xlabel('x')
    ylabel('y')
    zlabel('T')
    
    avetemp = mean(mean(T(:,:,k+1)));
end

%% Function for question 2

function [time] = explicitFiniteDifference(dr)
    %--------------------------------------------------
    % Use an explicit finite difference scheme to solve this problem that is first order
    % accurate in time and second order accurate in space. Your code should make
    % a plot of your solution with initial conditions in blue, intermediate values in
    % black, and the final solution in red.
    % inputs:
    % dr =  desired spatial resolution
    % output:
    %  time      = how long it takes for the anode is depleted such that the
    %              maximum cation concentration within the anode has been reduced by 80%
    
    % setup discrete system and constants
    a2 = 0.01; % diffusivity
    R = 1;    % radius
    
    Co = 0.8; % concentration reduced by
    nr = R/dr +1;


    tf = 100;
    dt = 0.001;
    nt = tf/dt+1;

    r  = 0:dr:R;
    

    % boundary values
    CA = 0;
    CB = Co;

    kmax = nt;

    % initial condition
    C = zeros(nr,kmax);
    
    for i = 1:length(r)
        if (r(i) <= 0.1)
            C(i,1) = 1;
        else
            C(i,1) = 0;
        end
    end
    
    
%     % BC's
%     C(1,:)=CA;
%     C(nr,:)=CB;
    
    %new figure
    if dr == 0.05 
        figure(4);
    else
        figure(3);
    end

    % plot initial conditions
    p1 = plot(r,C(:,1),'-b','LineWidth',2);
    xlabel('radius')
    ylabel('Concentration')
    titlestr = strcat("Problem 2a Explicit dr =", num2str(dr));
    title(titlestr)
    hold on
    
    s = dt * a2 / dr^2;

    for k = 1:kmax-1

        for i = 1:nr-1
            
            if ( (i-1) == 0)  % or i = 1 so the first row. this is the ghost node
                C(i,k+1) = C(i,k) + s * ( 2* C(i+1,k) - 2*C(i,k) );

                
            elseif ( i == nr-1)
                
                C(i,k+1) = C(i,k) + s * ( C(i-1,k) - 2*C(i,k) ) + s/(2*(i-1)) * ( -C(i-1,k) );


            
            else
                C(i,k+1) = C(i,k) + s * ( C(i-1,k) - 2*C(i,k) + C(i+1,k) )+ s/(2*(i-1)) * ( C(i+1,k) - C(i-1,k) );

            
            end

        end
        
        if (C(1,k+1) <= 0.2)
            fprintf(' The battery took = %f seconds to become 80 percent depletted  \n', dt*k)
            fprintf(' The battery anode took %i steps to become 80 percent depletted \n', k)
            break;

        end
        
        % plot intermediate solutions
        %plot(r,C(:,k+1),'-k')
        p2 = plot(r,C(:,k),'-k');
        %drawnow

    end

    % plot final equilibrium solution
    %plot(r,C(:,k+1),'-r')
    p3 = plot(r,C(:,k),'-r','LineWidth',2);
    legend([p1 p2 p3],{'Initial','Intermediate','Final'})

    time = 0;

end

function [time] = implicitFiniteDifference(dr)
    %--------------------------------------------------
    % Use an implicit finite difference scheme to solve this problem that is first order
    % accurate in time and second order accurate in space. Your code should make
    % a plot of your solution with initial conditions in blue, intermediate values in
    % black, and the final solution in red.
    % inputs:
    % dr =  desired spatial resolution
    %  time      = how long it takes for the anode is depleted such that the
    %              maximum cation concentration within the anode has been reduced by 80%
    % setup discrete system and constants
    
    a2 = 0.01; % diffusivity
    R = 1;    % radius
    
    Co = 0.8; % concentration reduced by
    nr = R/dr +1;


    tf = 100;
    dt = 0.01;
   
    nt = tf/dt+1;

    r  = 0:dr:R;
    
    
    kmax = nt;

    
    
    % initial condition
    C = zeros(nr,kmax);
    for i = 1:length(r)
        if (r(i) <= 0.1)
            C(i,1) = 1;
        else
            C(i,1) = 0;
        end
    end
    
    if dr == 0.05 
        figure(6);
    else
        figure(5);
    end
  
    s = dt*a2/dr^2;
    
    %r = 2(i-1) * delta r
    
    Va = -s + (s./2*( [2:nr-1]-1 ) );
    
    Vb = (1+2*s) * ones(1,nr-1);
    
    Vc = -s + (s./2*( [1:nr-2]+1 ) );
    
    Vc(1) = -2*s;
    
    %DGE  Ci,k =  Ci,k+1 * (- s + s /r + Ci,k+1 * (1+2*s) + Ci,k+1 * (-s - s /r)
    % r = (i-1)* delta r
    %     Ci,k =  Ci,k+1 * (- s + s /2(i-1) + Ci,k+1 * (1+2*s) + Ci,k+1 * (-s - s /2(i-1))
    %    Va = (- s + s /2(i-1)     Vb = (1+2*s)       Vc = (-s - s /2(i-1))
    %
    %  A=
    %   Vb Vc 0  0  0  0  ...
    %   Va Vb Vc 0  0  0  ...
    %   0  Va Vb Vc 0  0  ...
    %   0  0  Va Vb Vc 0  ...
    %   0  0  0  Va Vb Vc ...
    %   0  0  0  0  Va Vb ...
    %   .  .  .  .  .  .
    %   .  .  .  .  .  .
    %   .  .  .  .  .  .
    
    % Make A 
    %A = (Va) .*diag(ones(nr-3,1),-1) + (Vb).*diag(ones(nr-2,1),0) + (Vc).*diag(ones(nr-3,1),+1);
    
    %A = diag(Va,-1) + diag(Vb,0) + diag(Vc,+1);
    
    for i = 1:nr-1
            A(i,i) = (1+2*s);
        if i >1
            A(i,i-1) = -s +(s/(2*(i-1)));
        end
        if i < nr-1
            A(i,i+1) = -s +(-s/(2*(i-1)));
        end
    end

    %boundary condition
    A(1,2) = -2*s;
    
    p1 = plot(r,C(:,1),'-b','LineWidth',2);
    xlabel('radius')
    ylabel('Concentration')
    titlestr = strcat("Problem 2b Implicit dr =", num2str(dr));
    title(titlestr);
    hold on

    for k = 1:kmax-1

        %make B
        for i = 1:nr-1
            b(i,1) = C(i,k); 
        end

        %solve
        C(1:nr-1,k+1) = A\b;
        
        if C(1,k+1) <= 0.2
            fprintf(' The battery took = %f seconds to become 80 percent depletted  \n', dt*k)
            fprintf(' The battery anode took %i steps to become 80 percent depletted \n', k)
            break;
        end

        % plot intermediate solutions
          p2 = plot(r,C(:,k),'-k');
          %drawnow

    end
    % plot final equilibrium solution
    p3 = plot(r,C(:,k),'-r','LineWidth',1);
    
    legend([p1 p2 p3],{'Initial','Intermediate','Final'})

    
    time = 0;
    

end

%% Function for question 3
function[dTdt] = satelliteHeatODE(t,T)

global a3 dx3 nx3 s3 Tb3 q3

% Dirchlet BCs are handled by definition of v_init

%if I had Neumann BCs, they would be if statments inside loop over i


for i = 1:nx3-1
    if i == 1
        dTdt(i) = a3 / dx3^2 *(-2*T(i) + 2 * q3 *dx3  +2*T(i+1)) - s3 * (T(i)^4-Tb3^4);
        

    elseif i == nx3-1
        dTdt(i) = a3 / dx3^2 *(T(i-1) -2 * T(i) + Tb3) - s3 * (T(i)^4-Tb3^4); 
      

    else
        %main equation
        dTdt(i) = a3 / dx3^2 *(T(i+1) -2 * T(i) + T(i-1)) - s3 * (T(i)^4-Tb3^4); 
      

    end
    
end

       dTdt = dTdt';
end