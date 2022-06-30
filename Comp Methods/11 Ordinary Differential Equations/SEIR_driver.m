%---------------------------------------------------------
% SEIR COVID-19 model based on Kissler and Tedijanto et al. (2020)
% https://doi.org/10.1101/2020.03.22.20041079)
% 
% (Daven Henze, daven.henze@colorado.edu, 03/30/2020)
%---------------------------------------------------------
close all; clc; clear all


global R0 SD_start SD_days SD_eff

% set onstant R0
R0 = 2.0; 

% Social distancing (SD) parameter definitions
% SD_start is the days after the outbreak at which SD measures commence
% SD_days is the days for which SD measures persist
% SD_eff is the fractional efficieny of SD mesaures (0 = no intervention, 1 = complete)

% Baseline (no-intervention)
SD_start = 0;   
SD_days  = 0;   
SD_eff   = 0;   
[baseline] = calc_SEIR();

% 2 week delay, 8 week duration, 20% effective (Fig 1B, red)
SD_start = 7*2;   
SD_days  = 7*8;   
SD_eff   = 0.2;    
[r_8w_20] = calc_SEIR();

% 2 week delay, 8 week duration, 40% effective (Fig 1B, blue)
SD_start = 7*2;   
SD_days  = 7*8;   
SD_eff   = 0.4;    
[r_8w_40] = calc_SEIR();


% 2 week delay, 8 week duration, 60% effective (Fig 1B, green)
SD_start = 7*2;   
SD_days  = 7*8;   
SD_eff   = 0.6;    
[r_8w_60] = calc_SEIR();


% plot infections
subplot(2,2,1)
plot(baseline.t,[baseline.I_tot],'-k')
hold on
plot(r_8w_20.t,[r_8w_20.I_tot],'-r')
plot(r_8w_40.t,[r_8w_40.I_tot],'-b')
plot(r_8w_60.t,[r_8w_60.I_tot],'-g')
xlabel('Days since March 11')
ylabel('Infections per 10k')
title('8 week, aseasonal, R0=2.0')
legend('Baseline','20%','40%','60%')

% plot critical cases
subplot(2,2,2)
plot(baseline.t,[baseline.CC],'-k')
hold on
plot(r_8w_20.t,[r_8w_20.CC],'-r')
plot(r_8w_40.t,[r_8w_40.CC],'-b')
plot(r_8w_60.t,[r_8w_60.CC],'-g')
xlabel('Days since March 11')
ylabel('Critical Cases per 10k')
title('8 week, aseasonal, R0=2.0')

% plot R0 as a function of time 
subplot(2,2,3)
plot(baseline.t,[baseline.R0_t],'-k')
hold on
plot(r_8w_20.t,[r_8w_20.R0_t],'-r')
plot(r_8w_40.t,[r_8w_40.R0_t],'-b')
plot(r_8w_60.t,[r_8w_60.R0_t],'-g')
ylim([0 3])
xlabel('Days since March 11')
ylabel('R_0(t)')
title('8 week, aseasonal, R0=2.0')

% plot total infections as a function of time 
subplot(2,2,4)
plot(baseline.t,baseline.S(1)-baseline.S,'-k')
hold on
plot(r_8w_20.t,r_8w_20.S(1)-r_8w_20.S,'-r')
plot(r_8w_40.t,r_8w_40.S(1)-r_8w_40.S,'-b')
plot(r_8w_60.t,r_8w_60.S(1)-r_8w_60.S,'-g')
title('8 week, aseasonal, R0=2.0')
xlabel('days')
ylabel('cummulative infections')



function [results] = calc_SEIR()

global R0 SD_start SD_eff SD_days 
global pR pH pC nu gamma deltaH deltaC xiC z0

% set parameter values
pR     = 0.956;
pH     = 0.0308;
pC     = 0.0132;
nu     = 1/4.6; % 1/incubation period (sometimes called latency)
gamma  = 1/5;   % 1/infectious period (note: text says 1/4 but it should be 1/5, see email from Kissler 03/30/2020)
deltaH = 1/8;
deltaC = 1/6;
xiC    = 1/10; 
         
% initial susceptible population
S0 = 1e4;

% all other initial conditions set to zero
v0 = [S0 zeros(1,10)];
    
% integration time
tspan = [0 300];

% infectious force pulse magnitude; 
% Paper didn't specify magnitude here, but to get a peak 
% at ~60 days after March 11 for the base case, R0=2,
% z needs to be about 0.1% of S0 to match Fig 1 
% although Kissler said via email they used 1%
z0 = 0.001*S0;

% ODE solve
[t, v] = ode23s(@SEIRode,tspan,v0);

% re-lable solution variables
S  = v(:,1);
E  = v(:,2);
IR = v(:,3);
IH = v(:,4);
IC = v(:,5);
RR = v(:,6);
HH = v(:,7);
HC = v(:,8);
RH = v(:,9);
CC = v(:,10);
RC = v(:,11);

% plot groups
I_tot = IR+IH+IC;
R_tot = RR+RH+RC;
H_tot = HH+HC;
N     = S+E+I_tot+R_tot+H_tot+CC;

% recompute R0(t) = beta/gamma for plotting later
for i = 1:length(t)
    if t(i) >= SD_start
        R0_t(i) = R0*(1-SD_eff*heaviside(SD_days - (t(i)-SD_start)));
    else
        R0_t(i) = R0;
    end
end

% store in a results object
results.t     = t;
results.S     = S;
results.E     = E;
results.IR    = IR;
results.IH    = IH;
results.IC    = IC;
results.RR    = RR;
results.HH    = HH;
results.HC    = HC;
results.RC    = RH;
results.CC    = CC;
results.RC    = RC;
results.I_tot = I_tot;
results.R_tot = R_tot;
results.H_tot = H_tot;
results.N     = N;
results.R0_t  = R0_t;


end


function[dvdt]=SEIRode(t,v)

global pR pH pC nu gamma deltaH deltaC xiC z0 SD_start SD_days SD_eff 

% seasonal - not implemented yet
%a   = 
%phi = 
%b   = 
%
%R0    = @(t) a/2 * cos(2*pi/52*(t-phi)) + (a/2+b)
%beta  = @(t) gamma1*R0(t)

% constant
global R0

% include social distancing for time period SD_days 
% that starts SD_start days after the pandemic, and
% assume that SD has a fractional redution of R0
% of SD_eff (e.g., SD = 0.6 implies 60% reduction)
if t >= SD_start
    beta = R0*gamma*(1-SD_eff*heaviside(SD_days - (t-SD_start)));
else
    beta = R0*gamma;
end


S  = v(1);
E  = v(2);
IR = v(3);
IH = v(4);
IC = v(5);
RR = v(6);
HH = v(7);
HC = v(8);
RH = v(9);
CC = v(10);
RC = v(11);
N  = sum(v(:));

% initial force of infection z, pulse for 1/2 week
if t < 3.5
    z = z0;  
else  
    z = 0;
end


dS_dt  = - beta*(IR+IH+IC)*S/N - S*z/N;

dE_dt  =   beta*(IR+IH+IC)*S/N + S*z/N - nu*E*(pR+pH+pC);

dIR_dt = pR*nu*E - gamma*IR;
dIH_dt = pH*nu*E - gamma*IH;
dIC_dt = pC*nu*E - gamma*IC;

dRR_dt = gamma*IR;
dHH_dt = gamma*IH - deltaH*HH;
dHC_dt = gamma*IC - deltaC*HC;
dRH_dt = deltaH*HH;

dCC_dt = deltaC*HC - xiC*CC;
dRC_dt = xiC*CC;

dvdt = [dS_dt;  dE_dt;  dIR_dt; dIH_dt; dIC_dt; dRR_dt; dHH_dt; dHC_dt; ...
    dRH_dt; dCC_dt; dRC_dt];

end


