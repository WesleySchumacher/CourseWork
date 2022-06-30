% Lane Levine, Derrick Rasser, Wesley Schumacher
% Group 41
% Lab 6 MATLAB

clear all; close all; clc;
format long 
warning('off')

%% Calculating variables 
%dimenstions of shaft
diametershaft = 0.0032512; %[m] or 0.128 [inches]
Lengthshaft = 0.30482; %[m] or 12 [inches]

%Constants
%Polar Mmoment of Inertia Equation
J = pi/2*(diametershaft/2)^4; %[m^4] 
%shear modulus stainless steel
G = 77.2 * 10^9; %[Pa] or 77.2 [GPa]

%Torisional stiffness K
k = G*J/Lengthshaft; % [N*m/rad]
fprintf('Torisional stiffness K: %0.5fN*m/rad \n', k)

%calculation of I
massDisk = (2*185)/1000; %[kg] 
radiusdisk = 0.1; %[m]
Idiskcalc = 1/2*massDisk*radiusdisk^2; %[kg-m^2] moment of inertia of disk
Idisk = 0.0019; %[kg-m^2]

massWeight = 500/1000; %[kg]
radiusWeight = 0.050038; %[m] 
radiusfromaxis = 0.09; %[m] or 9[cm] position relative to center of didk

%Calculating total moment of inertia
Itop = Idisk + 2 * massWeight * radiusfromaxis^2; % [kg*m^2]
fprintf('Total Moment of Inertia Top : %0.5fkg*m^2 \n', Itop)

Ibottom = Idisk + 4 * massWeight * radiusfromaxis^2; %[kg*m^2]
fprintf('Total Moment of Inertia Bottom : %0.5fkg*m^2 \n', Ibottom)
fprintf('\n');

%% importing data
FreeRespBottom = importdata('FreeRespBottom.txt');
FreeRespTop = importdata('FreeRespTop.txt');


T = FreeRespBottom(:,1);
T_bottom = T(50:250);
T_bottom = T_bottom - T_bottom(1);
C = FreeRespBottom(:,2);
C_bottom = C(50:250);
Amplitudebottom = 189;
ratio = 2*pi/16000; %radians to counts

T2 = FreeRespTop(:,1);
T_top = T2(170:1000);
T_top = T_top - T_top(1);
C2 = FreeRespTop(:,2);
C_top = C2(170:1000);
AmplitudeTop = 150;

%% finding k and b 

%nlinfit initial guesses for a and b 
%x = [a, b]   
%a = sigma     
%b = omegaD
xintBottom = [1, 10];
xintTop = [1, 10];

xBottom = nlinfit(T_bottom,C_bottom, @Bottomfunction, xintBottom);
xTop = nlinfit(T_top,C_top, @Topfunction, xintTop);

ab = xBottom(1);
bb = xBottom(2);

sigmabottom = ab;
omegaDbottom = bb;

at = xTop(1);
bt = xTop(2);

sigmatop = at;
omegaDtop = bt;

%finding omegaN and zeta for the top and bottom
zetabottom = fzero(@(B) sigmabottom/B*sqrt(1-B^2)-omegaDbottom, 0.1);
omegaNbottom = sigmabottom/zetabottom;

zetatop = fzero(@(B) sigmatop/B*sqrt(1-B^2)-omegaDtop, 0.05);
omegaNtop = sigmatop/zetatop;

%function models Approximations
bottomApprox = @(t) (2*pi/16000)* Amplitudebottom * exp(-ab * t ) * cos(bb * t);
topApprox = @(t) (2*pi/16000)* AmplitudeTop * exp(-at * t ) * cos(bt * t);

plot(T_bottom,C_bottom*ratio)
hold on 
fplot(bottomApprox, [0, 2], 'r--')
xlabel('time(seconds)');
ylabel('deflection (radians)')
title('Bottom Disk')
legend('Experimental data', 'Fit')

figure()
plot(T_top,C_top*ratio)
hold on 
fplot(topApprox, [0, 10], 'r--')
xlabel('time(seconds)');
ylabel('deflection (radians)')
title('Top Disk')
legend('Experimental data', 'Fit')

fprintf('Approximated values for the Top disk \n')
fprintf('Fit sigma: %0.5fHz \n', sigmatop)
fprintf('Fit zeta: %0.5f \n', zetatop)
fprintf('Fit Wn: %0.5fHz \n', omegaNtop)
fprintf('Fit Wd: %0.5fHz \n', omegaDtop)
fprintf('Resulting Theoretical values for the Top disk \n')
kcalc = omegaNtop^2 * Itop;
fprintf('k cacluated assuming the correct value is I top: %0.5fN*m/rad \n', kcalc)
b = zetatop * 2 * Itop * omegaNtop;
fprintf('b cacluated assuming the correct value is I top: %0.5fNs*m/rad \n', b)
ITop = k/ (omegaNtop^2);
b = zetatop * 2 * ITop * omegaNtop;
fprintf('b cacluated using assuming the correct value is k : %0.5fNs*m/rad \n', b)
fprintf('I cacluated using assuming the correct value is k : %0.5fkg*m^2 \n', ITop)

fprintf(' \n')
fprintf('Approximated values for the Bottom disk \n')
fprintf('Fit sigma: %0.5fHz \n', sigmabottom)
fprintf('Fit zeta: %0.5f \n', zetabottom)
fprintf('Fit Wn: %0.5fHz \n', omegaNbottom)
fprintf('Fit Wd: %0.5fHz \n', omegaDbottom)
fprintf('Resulting Theoretical values for the Bottom disk \n')
kcalc = omegaNbottom^2 * Ibottom;
fprintf('k cacluated assuming the correct value is I bottom: %0.5fN*m/rad \n', kcalc)
b = zetabottom * 2 * Ibottom * omegaNbottom;
fprintf('b cacluated assuming the correct value is I bottom: %0.5fNs*m/rad \n', b)
IBottom = k/ (omegaNbottom^2);
b = zetabottom * 2 * IBottom * omegaNbottom;
fprintf('b cacluated using assuming the correct value is k : %0.5fNs*m/rad \n', b)
fprintf('I cacluated using assuming the correct value is k : %0.5fkg*m^2 \n', IBottom)

%% nlinfit functions
function x = Bottomfunction(x1,t)
    Amplitudebottom = 189;
    a = x1(1);
    b = x1(2);

    
    x = Amplitudebottom * exp( -a .* t ) .* cos(b.*t);

end

function x = Topfunction(x1,t)
    AmplitudeTop = 148;
    a = x1(1);
    b = x1(2);

    
    x = AmplitudeTop * exp( -a .* t ) .* cos(b.*t);

end