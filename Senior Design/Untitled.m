%% Wesley Schumacher
% ME ID:627-566
% MCEN 4085 Senior Design
% Fall 2021
% Force Analysis

%% House-keeping Runner function
clc; close all;

%% Actuator Forces

%Constants
Weight = 600 + 50;                  % [lb] Weight of Bin plus Weight of Forks and Lifting Arm
DistanceFromPivotToCylinder = 24;%5.38;  % [inches]
%DistanceFromPivotToWeight = 32.61;     % [inches]




%DistanceFromPivotToCylinder = 10;  % [inches]
%DistanceFromPivotToWeight = 32.61-5;     % [inches]

DistanceFromPivotToWeight = linspace(45,39,116);
%Vaiables

theta = 20:135;                     % [degrees] The angle the Lifting Arm is from the frame
CylinderAgngle = 150:-1:35;         % [degrees] The Angle the Cylinder is from the Lifitng Arm
BinWeightangle = theta;             % [degrees] The Angle the weight is compared to the lifting Arm(Same direction as Gravity)

%650lb*sin(70)*(34in + 6.5in) = CF*sin(90)*(6.5in)  Cylinder Force = 3196 lbs

ClyinderForce = (Weight .* sind(BinWeightangle) .* (DistanceFromPivotToCylinder + DistanceFromPivotToWeight)) ./ (sind(CylinderAgngle) .* DistanceFromPivotToCylinder);

figure(1)
plot(theta,ClyinderForce, 'r','linewidth',2)

hold on
plot(theta,ClyinderForce*1.5, 'g','linewidth',4)
plot(theta,ClyinderForce*2, 'b','linewidth',2)
plot(theta,(ClyinderForce*1.5)/2, 'c','linewidth',2)

legend('Factor of Safety:1','Factor of Safety:1.5','Factor of Safety:2','Per an Actuator FOB:1.5','Location','northeast')
xlabel("\theta [degrees]")
ylabel("Clyinder Force[lb]")
xlim([30 145])
ylim([0000 7200])


%% Actuator Forces

%Square beam dimentions
side1 = 2;    %Inches 2x2 for example
thickness = 0.125; %Inches

innerside = side1-2*thickness; %Inner dimension

r = side1/2;    %furthest point from the center

I_beam = side1^4/12 - innerside^2/12;   %Inertia

Area_beam = side1^2 - innerside^2;

Weight = 600 + 50;                          % [lb] Weight of Bin plus Weight of Forks and Lifting Arm
DistanceFromPivotToCylinder = 5.38;         % [inches]
DistanceFromPivotToWeight = linspace(20,0,116);     % As center of mass moves across beam

theta = 20:135;                     % [degrees] The angle the Lifting Arm is from the frame
BinWeightangle = theta;             % [degrees] The Angle the weight is compared to the lifting Arm(Same direction as Gravity)

Moment = Weight .*sind(theta) .* DistanceFromPivotToWeight;

stress_mom = Moment * r / I_beam;

stress_norm = Weight .* cosd(theta) / Area_beam;

stress = stress_mom + stress_norm;

figure(2)

plot(theta,stress,'Linewidth',1.5);
ylabel('Stress [psi]');
xlabel('\theta [degrees]');

Sy = 100000;
N = Sy/max(stress)
