clear, close all
clc
Ti = 20 + 273;        %initial temp of turkey
Tcook = 75 + 273;     %temp when turkey is finished cooking (165F)
Tinf = 170 + 273;     %air temp in the oven (340F)
Twall = 500 + 273;    %wall temperature of the oven (temp when metal glows)

Tsavg = (Ti + Tcook)/2;       %average surface temp while cooking
Tfilm = (Tsavg + Tinf)/2;     %film temp for Nu correlations

D = 0.24;               %turkey diameter (10 in, 16lb)
At = pi*(D^2);          %surface area of turkey
Vt = (1/6)*pi*(D^3);    %volume of turkey
k = 0.642;              %therm cond of water Tsavg
rho = 988;              %density of water at Tsavg
cp = 4181;              %heat capacity of water at Tsavg
ew = 0.5;               %emissivity of oven wall
et = 0.95;              %emissivity of turkey (emissivity of skin)
s = 0.75;               %oven wall side length (30 inches)
Aw = 6*s*s;             %surface area of oven walls
sigma = 5.67e-8;

turkey_weight_lbs = 988*Vt*2.204

%air properties at Tfilm 
nuair = 23.7e-6;
kair = 31.9e-3;
alphaair = 34.1e-6;
Prair = 0.695;
g = 9.81;
beta = 1/(Tfilm);

%determine h by natural convection
RaD = -g*beta*(Tsavg - Tinf)*(D^3)/(nuair*alphaair);
NuD = 2 + ((0.589*(RaD^(1/4)))/((1 + ((0.469/Prair)^(9/16)))^(4/9)));
hNC = NuD*kair/D;

%solve LC DE for turkey temp vs time
tspan = 0:15:18000;
dTtdt = @(t,Tt) (hNC*At/(Vt*cp*rho))*(Tinf - Tt) + ...
    (sigma*((Twall^4) - (Tt^4)))/((Vt*cp*rho)*(((1 - ew)/(ew*Aw)) +...
    (1/At) + ((1 - et)/(et*At))));
[t,Tt] = ode45(dTtdt,tspan,Ti);
time_LC = t(round(median(find(round(Tt) < Tcook+2 & round(Tt) > Tcook-2))+1))/3600;
figure
LC = plot(t/3600,Tt-273);
hold on
plot([time_LC time_LC],[0 Tcook+15-273],'k')
xlabel('time [hours]')
ylabel('temperature [C]')

%centerline temp from full solution
hrad = (sigma*(Twall + Tsavg)*((Twall^2) + (Tsavg^2)))/...
    ((At*(1 - ew)/(ew*Aw)) + 1 + ((1 - et)/et));
heff = hrad + hNC;
Bi_NC_only = hNC*D/(6*k)
Bi_NC_and_rad = heff*D/(6*k)
terms = 200;
param = [D,heff,k,rho,cp,Tinf,Ti,terms];
Tfull = full_soln(t,param);
time_full = t(round(median(find(round(Tfull) < Tcook+2 & round(Tfull) > Tcook-2))+1))/3600;
time_LC
time_full
full = plot(t/3600,Tfull-273);
plot([time_full time_full],[0 Tcook+15-273],'k')
legend([LC,full],{'LC','full'})

traditional_cook_time = (13/60)*turkey_weight_lbs     %13 minutes per pound

%% full soln function
function [T_full] = full_soln(time,param)
%get parameters
R = param(1)/2;
hfull = param(2);
k = param(3);
alpha = param(3)/(param(4)*param(5));
Tinf = param(6);
Ti = param(7);
terms = param(8);

%calculate full solution
biotfull = hfull*R/k;

%find roots of transcendental eqn
fun = @(zetan)1-(zetan*cot(zetan))-biotfull;
dum = 0.1:0.1:terms;
yy = zeros(1,length(dum));
for ii = 1:length(dum)
    yy(ii) = fzero(fun,dum(ii));
end
zz = unique(yy);
zz = sort(zz);
z = round(1e9*zz)*1e-9; %Get rid of spurious differences
z = unique(z);
z(z<0) = [];
z(z>dum(end)) = [];
zetan = z(1:2:end);

%solve full solution for temperature 
Fo = alpha*time/(R^2);
theta = zeros(length(zetan),length(time));
for n = 1:length(zetan)
    Cn = 4*(sin(zetan(n)) - zetan(n)*cos(zetan(n)))/...
        (2*zetan(n) - sin(2*zetan(n)));
    theta(n,:) = Cn*exp(-(zetan(n)^2)*Fo);
end
THETA = sum(theta,1);
T_full = THETA*(Ti - Tinf) + Tinf;
end


