% Lane Levine, Derrick Rasser, Wesley Schumacher
% Group 41
% Lab 8 MATLAB

clc; close all; clear all;

% Read in the data that was collected using WaveForms
figure(1)
%ploting the RC circuit with 33uF capacitor 
datalimit = 501;
[VoltageRC33] = xlsread('RC33.csv');
frequencyRC33 = VoltageRC33(1:datalimit,1); 
inputRC33 = VoltageRC33(1:datalimit,2);
outputRC33 = VoltageRC33(1:datalimit,3);
phaseRC33 = VoltageRC33(1:datalimit,4);

%ploting the RC circuit with 0.1uF 
[VoltageRC01] = xlsread('RC01.csv');
frequencyRC01 = VoltageRC01(1:datalimit,1);
inputRC01 = VoltageRC01(1:datalimit,2);
outputRC01 = VoltageRC01(1:datalimit,3);
phaseRC01 = VoltageRC01(1:datalimit,4);




% RC cicuit Magnitude plot
subplot(2,1,1)
loglog(frequencyRC33,10.^(outputRC33./20),'b','Linewidth',2)
hold on;
loglog(frequencyRC01,10.^(outputRC01./20),'g','Linewidth',1);

%Resister and Capasitor values
R = 5.1*10^3;
C = 3.3*10^-6;
% %time constant
% tau = 1/ (2*pi*R*C);
% Khat = 1;
% a = tau;
% DW = 1;
% w1 = 0:DW:1000000;
% w = w1/(2*pi);
% %1st order system magnitude equation
% Mag = Khat *a./(sqrt(a.^2 + w.^2));
% %ploting magnitude ona log plot

w = [0.1:0.1:1000000];
w_hz = w./(2*pi);
for i = 1:10000000
   MagRC33(i) = (1/(R*C))/(sqrt(w(i)^2 + (1/(R*C))^2));
end
loglog(w_hz,MagRC33,'r','Linewidth',1)
%loglog((w),(Mag),'r','Linewidth',1)


%Resister and Capasitor values
C = 0.1*10^-6;
for i = 1:10000000
   MagRC01(i) = (1/(R*C))/(sqrt(w(i)^2+(1/(R*C))^2));
end
loglog(w_hz,MagRC01,'r--','Linewidth',1)

xlim([10^0 10^6])
ylim([0 1.1*10^0])
xlabel('Freq (Hz)')
ylabel('Mag')
title('Magnitude vs. Frequency of RC Circuit')
legend('33uF Experiment  ','0.1uF Experiment','33uF Theory','0.1uF  Theory','Location','southwest')


% RC cicuit Phase plot
subplot(2,1,2)
semilogx(frequencyRC33,phaseRC33,'b','Linewidth',2)
hold on;
semilogx(frequencyRC01,phaseRC01,'g','Linewidth',2);

%Resister and Capasitor values
R = 5.1*10^3;
C = 3.3*10^-6;
freq = [1:5000000];
freq_hz = freq./2./pi;
for i = 1:5000000
   Phasetheory(i) = -atand(freq(i)*R*C);
end

%ploting the phase at each frequency 
semilogx(freq_hz,Phasetheory,'r','Linewidth',1)

C = 0.1*10^-6;
for i = 1:5000000
   Phasetheory(i) = -atand(freq(i)*R*C);
end
semilogx(freq_hz,Phasetheory,'r--','Linewidth',1)

xlim([10^0 1.2 *10^6])
xlabel('Freq (Hz)')
ylabel('Phase (deg)')
title('Phase vs. Frequency of RC Circuit')
%legend('33uF Experiment  ','0.1uF Experiment','33uF Theory','0.1uF  Theory','Location','northeast')

figure(2)
%ploting the CR circuit with 33uF capacitor 
datalimit = 501;
[VoltageCR33] = xlsread('CR33.csv');
frequencyCR33 = VoltageCR33(1:datalimit,1); 
inputCR33 = VoltageCR33(1:datalimit,2);
outputCR33 = VoltageCR33(1:datalimit,3);
phaseCR33 = VoltageCR33(1:datalimit,4);

%ploting the CR circuit with 0.1uF 
[VoltageCR01] = xlsread('CR01.csv');
frequencyCR01 = VoltageCR01(1:datalimit,1); 
inputCR01 = VoltageCR01(1:datalimit,2);
outputCR01 = VoltageCR01(1:datalimit,3);
phaseCR01 = VoltageCR01(1:datalimit,4);

%% CR cicuit Magnitude plot
subplot(2,1,1)
loglog(frequencyCR33,10.^(outputCR33./20),'b','Linewidth',2)
hold on;
loglog(frequencyCR01,10.^(outputCR01./20),'g','Linewidth',2);

%Resister and Capasitor values
R = 5.1*10^3;
C = 3.3*10^-6;
% %time constant
% tau = 1/ (2*pi*R*C);
% Khat = 1;
% a = tau;
% DW = 1;
% w1 = 0:DW:1000000;
% w = w1/(2*pi);
% %1st order system magnitude equation
% Mag = Khat *a./(sqrt(a.^2 + w.^2));
% %ploting magnitude ona log plot

w = [0.1:0.1:1000000];
w_hz = w./(2*pi);
for i = 1:10000000
   MagCR33(i) = ((R*C) * w(i))/(sqrt(1^2 + ((R*C* w(i)))^2));
end
loglog(w_hz,MagCR33,'r','Linewidth',1)
%loglog((w),(Mag),'r','Linewidth',1)


%Resister and Capasitor values
C = 0.1*10^-6;
for i = 1:10000000
   MagCR01(i) = ((R*C) * w(i))/(sqrt(1^2 + ((R*C* w(i)))^2));
end
loglog(w_hz,MagCR01,'r--','Linewidth',1)

xlim([10^-1 10^6])
ylim([-0.2 1.2])
xlabel('Freq (Hz)')
ylabel('Mag')
title('Magnitude vs. Frequency of CR Circuit')
legend('33uF Experiment  ','0.1uF Experiment','33uF Theory','0.1uF  Theory','Location','southeast')


%% CR cicuit phase plot
subplot(2,1,2)
semilogx(frequencyCR33,phaseCR33,'b','Linewidth',2)
hold on;
semilogx(frequencyCR01,phaseCR01,'g','Linewidth',2);

%Resister and Capasitor values
R = 5.1*10^3;
C = 3.3*10^-6;
freq = [1:5000000];
freq_hz = freq./2./pi;
for i = 1:5000000
   Phasetheory(i) = -atand(freq(i)*R*C)+90;
end

%ploting the phase at each frequency 
semilogx(freq_hz,Phasetheory,'r','Linewidth',1)

C = 0.1*10^-6;
for i = 1:5000000
   Phasetheory(i) = -atand(freq(i)*R*C)+90;
end
semilogx(freq_hz,Phasetheory,'r--','Linewidth',1)

xlim([10^-1 10^6])
ylim([0 100])
xlabel('Freq (Hz)')
ylabel('Phase (deg)')
title('Phase vs. Frequency of CR Circuit')
%legend('33uF Experiment  ','0.1uF Experiment','33uF Theory','0.1uF  Theory','Location','northeast')

%% The sum of 2 sin waves
%ploting the RC circuit with 33uF capacitor
figure(3)
datalimit = 5261;
datastart = 1261;
[VoltagesinRC33] = xlsread('sumof2sinRC33.csv');
timesinRC33 = VoltagesinRC33(datastart:datalimit,1); 
inputsinRC33 = VoltagesinRC33(datastart:datalimit,2);
outputsinRC33 = VoltagesinRC33(datastart:datalimit,3);
timesinRC33 = timesinRC33 - timesinRC33(1);


plot(timesinRC33, inputsinRC33,'b','Linewidth',1)
hold on;
plot(timesinRC33, outputsinRC33,'g','Linewidth',2)

t = 0:0.001:1;
outRC33 = -0.10457* cos((2*pi).*t)+ 0.98894*sin((2*pi).*t) - 0.09372 * cos((200*pi).*t) +0.00886*sin((200*pi).*t);
outRC33 = outRC33 / 1.9543535;
plot(t, outRC33,'r','Linewidth',1)


xlim([0 1])
xlabel('time (s)')
ylabel('Voltage (V)')
title('Sum of 2 sine waves RC Circuit')
legend('Experimental Input','Experimental Output','theoretical Output')



%ploting the CR circuit with 33uF capacitor
figure(4)
datastart = 600;
datalimit = 8000;
[VoltagesinCR33] = xlsread('sumof2sinCR33.csv');
timesinCR33 = VoltagesinCR33(1:datalimit,1); 
inputsinCR33 = VoltagesinCR33(1:datalimit,2);
outputsinCR33 = VoltagesinCR33(1:datalimit,3);
timesinCR33 = timesinCR33 - timesinCR33(1);

plot(timesinCR33, inputsinCR33,'b','Linewidth',1)
hold on;
plot(timesinCR33, outputsinCR33,'g','Linewidth',2)

t = 0:0.001:1;
outCR33 = 0.10457* cos((2*pi).*t)+ 0.01105*sin((2*pi).*t) - 0.09372 * cos((200*pi).*t) +0.99113*sin((200*pi).*t);
outCR33 = outCR33 / 1.9843535;
plot(t, outCR33,'r','Linewidth',1)

xlim([0 1])
ylim([-1.1 1.1])
xlabel('time (s)')
ylabel('Voltage (V)')
title('Sum of 2 sine waves CR Circuit')
legend('Experimental Input','Experimental Output','theoretical Output')
