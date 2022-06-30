%% Wesley Schumacher
% ME ID:627-566
% MCEN 4085 Senior Design
% Fall 2021
% Force Analysis

%% House-keeping Runner function
clc; close all;

%Constants 
Weight = 600 + 50;                  % [lb] Weight of Bin plus Weight of Forks and Lifting Arm
DistanceFromPivotToCylinder = 6.5;  % [inches]
DistanceFromPivotToWeight = 34;     % [inches]
DistanceFromPivotToWeight = linspace(34,4,116);
%Vaiables

theta = 20:135;                     % [degrees] The angle the Lifting Arm is from the frame
CylinderAgngle = 150:-1:35;         % [degrees] The Angle the Cylinder is from the Lifitng Arm
BinWeightangle = theta;             % [degrees] The Angle the weight is compared to the lifting Arm(Same direction as Gravity)

%650lb*sin(70)*(34in + 6.5in) = CF*sin(90)*(6.5in)  Cylinder Force = 3196 lbs

ClyinderForce = (Weight .* sind(BinWeightangle) .* (DistanceFromPivotToCylinder + DistanceFromPivotToWeight)) ./ (sind(CylinderAgngle) .* DistanceFromPivotToCylinder);

plot(theta,ClyinderForce, 'r','linewidth',4)


hold on
plot(theta,ClyinderForce*1.5, 'g','linewidth',4)
plot(theta,ClyinderForce*2, 'b','linewidth',4)

legend('Factor of Safety:1','Factor of Safety:1.5','Factor of Safety:2','Location','southeast')
xlabel("\theta [degrees]")
ylabel("Clyinder Force[lb]")
xlim([30 145])
ylim([0000 6500])
