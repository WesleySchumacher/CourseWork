%% Wesley Schumacher & Adam Bradshaw & Thomas Hart
% MCEN 4026 Manufacturing
% FALL 2020
% Casting Lab
% material AL 356

clc; clear all;
%Using MATLAB and the dimensions measured directly from your casting system, calculate the following

r = 25.87 * 0.001; %[m] radius of sprue
A = pi* r^2; % Area
Q = 0.00385 /60; %Volumetric flow Found on paper [m^3 / sec] 
Vel = Q/A;  % Once way to calculate velocity
h = 0.2794; % height we poured molten metal from
l = 138.51 * 0.001; %[m] %length of sprue
p = 2670; %Density [kg/m^3]
u = 4 *10^-3; % viscosity[Pa*s]
V = pi* r^2 *l; %Volume 
n = 2;
s = V/Q;% Calculating time
v = l/s; % calculating velocity
C = 50; % Mold constant sec/cm^2
g = -9.81; %[m/s^2] gravitation constant


%Sprue
%Calculate geometry for the sprue (should be tapered)
%Velocity at end of sprue
%top radius = 25.87mm
velocitystart = 2 * g * (h-l);
velocityend = 2 * g * h;
A2 = (velocitystart * A) / velocityend;
radiusatend = sqrt(A2 / pi);
fprintf("Calculated values for sprue: \n")
fprintf("we want a sprue cone geometry of a upper radius of: %f [m] and a lower radius of:%f[m] and a sprue length of: %f [m] \n", r, radiusatend, l )
%Reynolds number at gate entry (beginning of runner) 
Re = (p *v *2*r)/u;
fprintf("Reynolds number at gate entry: %f  \n", Re)
fprintf("\n")

%runners
fprintf("Calculated values for runners: \n")
%Area of runner 13mm by 6mm
Arearunner = 7.8e-5; %m^2
%Velocity of molten metal into the runners (at the bottom of sprue) V = Q/A
Velocityrunners = Q / Arearunner;
radiusrunner = 0.003; %[m]
fprintf("Velocity of molten metal into the runners : %f [m/s]  \n", Velocityrunners)
%Reynolds number of the metal going into mold cavity
Re = (p *Velocityrunners *2*radiusrunner)/u;
fprintf("Reynolds number of the metal going into mold cavity: %f  \n", Re)

%Cast part
fprintf("\n")
fprintf("Calculated values for the Cast part: \n")
%Velocity of molten metal into the mold cavity
%volume & surface area calculated usng 3D Solid Works: 
Volume= 3.1762055e-5; %[m^3]
SurfaceArea = 0.03338092e-3; %[m^2]
CrosssectinalArea = 0.0017073; %[m^2]
Velocityintomold = Q/CrosssectinalArea;
fprintf("Velocity of molten metal into the mold cavity : %f [m/s]  \n", Velocityrunners)
%Reynolds number of the metal into the mold cavity
Re = (p *Velocityrunners *2*radiusrunner)/u;
fprintf("Reynolds number of the metal going into mold cavity: %f  \n", Re)
%Time to fill mold cavity
timetofill = Volume/Q; %[Seconds]
fprintf("Time to fill mold cavity: %f seconds  \n", timetofill)
%Solidification time of the part
Solidificationtime = C * (Volume/SurfaceArea)^n;
fprintf("Solidification time of the part: %f seconds  \n", Solidificationtime)
fprintf("\n")

%Riser
%Calculate geometry
lowerradius = 0.0073;%[m]
heightofriser = 0.1372;%[m]
fprintf("Our riser should be a cylinder with a lower and upper radius of: %f meters and a length of %f meters  \n", lowerradius, heightofriser)
%Solidification time (should be slower than cast part)
Volumeriser = 9.3e-3; %[m^3]
SurfaceAreariser = 6.63e-3; %[m^2]
Solidificationtimeriser = C * (Volumeriser/SurfaceAreariser)^n;
fprintf("Solidification time of the riser: %f seconds  \n", Solidificationtimeriser)
fprintf("\n")
fprintf("The above calculated values suggest that our initial mold design was not ideal to perfect a more ideal mold design we would build larger runners to slow down the fluid and we would design our sprue and risers to be smaller, there is no need to have a sprue and risers that are twice the height of our part.\n")






