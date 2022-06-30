% Lane Levine, Derrick Rasser, Wesley Schumacher
% Group 41
% Lab 7 MATLAB

clc;close all;

% Read in the data that was collected using WaveForms
figure(1)
%ploting the 1 rad/s signal
[Voltage1] = xlsread('Experiment1.csv');
time1 = Voltage1(1:6021,1);
output1 = Voltage1(1:6021,2);
input1 = Voltage1(1:6021,3);
plot(time1,input1,'b','Linewidth',2)
xlim([0 15])
hold on;
plot(time1,output1,'g','Linewidth',1);
xlabel('Time (s)')
ylabel('Signal (V)')
title('1 rad/s input signal')
legend('Input','Output')

figure(2)
%ploting the 500 rad/s signal
[Voltage500] = xlsread('Experiment500.csv');
time500 = Voltage500(1:181,1);
output500 = Voltage500(1:181,2);
input500 = Voltage500(1:181,3);
plot(time500,input500,'b','Linewidth',1)
xlim([0 0.2])
hold on;
plot(time500,output500,'g','Linewidth',1);
xlabel('Time (s)')
ylabel('Signal (V)')
title('500 rad/s input signal')
legend('Input','Output')

figure(3)
% Read in the data that was collected using WaveForms
[Voltage1] = xlsread('Experiment1.csv');
[Voltage2] = xlsread('Experiment2.csv');
[Voltage3] = xlsread('Experiment3.csv');
[Voltage4] = xlsread('Experiment4.csv');
[Voltage5] = xlsread('Experiment5.csv');
[Voltage6] = xlsread('Experiment6.csv');
[Voltage7] = xlsread('Experiment7.csv');
[Voltage8] = xlsread('Experiment8.csv');
[Voltage9] = xlsread('Experiment9.csv');
[Voltage10] = xlsread('Experiment10.csv');
[Voltage20] = xlsread('Experiment20.csv');
[Voltage30] = xlsread('Experiment30.csv');
[Voltage40] = xlsread('Experiment40.csv');
[Voltage50] = xlsread('Experiment50.csv');
[Voltage60] = xlsread('Experiment60.csv');
[Voltage70] = xlsread('Experiment70.csv');
[Voltage80] = xlsread('Experiment80.csv');
[Voltage90] = xlsread('Experiment90.csv');
[Voltage100] = xlsread('Experiment100.csv');
[Voltage200] = xlsread('Experiment200.csv');
[Voltage300] = xlsread('Experiment300.csv');
[Voltage400] = xlsread('Experiment400.csv');
[Voltage500] = xlsread('Experiment500.csv');

%calculating the amplitude ratio for each set of data
ampratio1 = Amplitude(Voltage1);
ampratio2 = Amplitude(Voltage2);
ampratio3 = Amplitude(Voltage3);
ampratio4 = Amplitude(Voltage4);
ampratio5 = Amplitude(Voltage5);
ampratio6 = Amplitude(Voltage6);
ampratio7 = Amplitude(Voltage7);
ampratio8 = Amplitude(Voltage8);
ampratio9 = Amplitude(Voltage9);
ampratio10 = Amplitude(Voltage10);
ampratio20 = Amplitude(Voltage20);
ampratio30 = Amplitude(Voltage30);
ampratio40 = Amplitude(Voltage40);
ampratio50 = Amplitude(Voltage50);
ampratio60 = Amplitude(Voltage60);
ampratio70 = Amplitude(Voltage70);
ampratio80 = Amplitude(Voltage80);
ampratio90 = Amplitude(Voltage90);
ampratio100 = Amplitude(Voltage100);
ampratio200 = Amplitude(Voltage200);
ampratio300 = Amplitude(Voltage300);
ampratio400 = Amplitude(Voltage400);
ampratio500 = Amplitude(Voltage500);

%given freqencies to use when collecting data
freq = [1 2 3 4 5 6 7 8 9 10 20 30 40 50 60 70 80 90 100 200 300 400 500];
%Resister and Capasitor values
R = 5.1*10^3;
C = 3.3*10^-6;
%time constant
tau = 1/ (2* pi*R*C);
Khat = 1;
a = tau;
DW = 0.001;
w1 = 0:DW:500;
w = w1/(2*pi);
%1st order system magnitude equation
Mag = Khat *a./(sqrt(a.^2 + w.^2));
%ploting magnitude ona log plot
loglog((w),(Mag),'g')
xlim([10^-1 10^2])
ylim([10^-1 1.15])
hold on
% plotting the various amplitude rations on the same figure at each freqency
loglog(1/(2*pi),ampratio1,'b*')
hold on
loglog(2/(2*pi),ampratio2,'b*')
loglog(3/(2*pi),ampratio3,'b*')
loglog(4/(2*pi),ampratio4,'b*')
loglog(5/(2*pi),ampratio5,'b*')
loglog(6/(2*pi),ampratio6,'b*')
loglog(7/(2*pi),ampratio7,'b*')
loglog(8/(2*pi),ampratio8,'b*')
loglog(9/(2*pi),ampratio9,'b*')
loglog(10/(2*pi),ampratio10,'b*')
loglog(20/(2*pi),ampratio20,'b*')
loglog(30/(2*pi),ampratio30,'b*')
loglog(40/(2*pi),ampratio40,'b*')
loglog(50/(2*pi),ampratio50,'b*')
loglog(60/(2*pi),ampratio60,'b*')
loglog(70/(2*pi),ampratio70,'b*')
loglog(80/(2*pi),ampratio80,'b*')
loglog(90/(2*pi),ampratio90,'b*')
loglog(100/(2*pi),ampratio100,'b*')
loglog(200/(2*pi),ampratio200,'b*')
loglog(300/(2*pi),ampratio300,'b*')
loglog(400/(2*pi),ampratio400,'b*')
loglog(500/(2*pi),ampratio500,'b*')
xlabel('Freq (Hz)')
ylabel('Mag')
title('Magnitude vs. Frequency')
legend('Theory','Experiment')

freq = [1;2;3;4;5;6;7;8;9;10;20;30;40;50;60;70;80;90;100;200;300;400;500];
freq_hz = freq./2./pi;

%calculating the phase ratio for each set of data
phase1 = 360.*(1/(2*pi)).*phase(Voltage1,2537,2539);
phase2 = 360.*(2/(2*pi)).*phase(Voltage2,1650,1637);
phase3 = 360.*(3/(2*pi)).*phase(Voltage3,1886,1869);
phase4 = 360.*(4/(2*pi)).*phase(Voltage4,1438,1427);
phase5 = 360.*(5/(2*pi)).*phase(Voltage5,941,924);
phase6 = 360.*(6/(2*pi)).*phase(Voltage6,517,504);
phase7 = 360.*(7/(2*pi)).*phase(Voltage7,325,311);
phase8 = 360.*(8/(2*pi)).*phase(Voltage8,415,400);
phase9 = 360.*(9/(2*pi)).*phase(Voltage9,506,492);
phase10 = 360.*(10/(2*pi)).*phase(Voltage10,315,299);
phase20 = 360.*(20/(2*pi)).*phase(Voltage20,317,303);
phase30 = 360.*(30/(2*pi)).*phase(Voltage30,158,148);
phase40 = 360.*(40/(2*pi)).*phase(Voltage40,117,104);
phase50 = 360.*(50/(2*pi)).*phase(Voltage50,161,150);
phase60 = 360.*(60/(2*pi)).*phase(Voltage60,183,171);
phase70 = 360.*(70/(2*pi)).*phase(Voltage70,182,172);
phase80 = 360.*(80/(2*pi)).*phase(Voltage80,124,114);
phase90 = 360.*(90/(2*pi)).*phase(Voltage90,188,178);
phase100 = 360.*(100/(2*pi)).*phase(Voltage100,66,58);
phase200 = 360.*(200/(2*pi)).*phase(Voltage200,40,37);
phase300 = 360.*(300/(2*pi)).*phase(Voltage300,19,17);
phase400 = 360.*(400/(2*pi)).*phase(Voltage400,15,12);
phase500 = 360.*(500/(2*pi)).*phasefun(Voltage500,15,13);

%ploting 1st order phase theory line 
figure(4)
for i = 1:23
   Phasetheory(i) = -atand(freq(i)*R*C);
end


DW = 0.001;
w1 = 0.001:DW:500;
w = w1*2*pi;
phaset =  -atan2(w,a);
%plot(log10((w)),(phaset*180/pi),'g')
%ploting the phase at each frequency 
semilogx(freq_hz,Phasetheory,'g')
hold on
semilogx(((1/(2*pi))),phase1,'b*')
semilogx((2/(2*pi)),phase2,'b*')
semilogx((3/(2*pi)),phase3,'b*')
semilogx((4/(2*pi)),phase4,'b*')
semilogx((5/(2*pi)),phase5,'b*')
semilogx((6/(2*pi)),phase6,'b*')
semilogx((7/(2*pi)),phase7,'b*')
semilogx((8/(2*pi)),phase8,'b*')
semilogx((9/(2*pi)),phase9,'b*')
semilogx((10/(2*pi)),phase10,'b*')
semilogx((20/(2*pi)),phase20,'b*')
semilogx((30/(2*pi)),phase30,'b*')
semilogx((40/(2*pi)),phase40,'b*')
semilogx((50/(2*pi)),phase50,'b*')
semilogx((60/(2*pi)),phase60,'b*')
semilogx((70/(2*pi)),phase70,'b*')
semilogx((80/(2*pi)),phase80,'b*')
semilogx((90/(2*pi)),phase90,'b*')
semilogx((100/(2*pi)),phase100,'b*')
semilogx((200/(2*pi)),phase200,'b*')
semilogx((300/(2*pi)),phase300,'b*')
semilogx((400/(2*pi)),phase400,'b*')
semilogx((500/(2*pi)),phase500,'b*')


xlabel('Freq (Hz)')
ylabel('Phase (deg)')
title('Phase vs. Frequency')
legend('Theory','Experiment')

%using Bode fucnction to compare our data to
%figure(5)
sys = tf([1],[tau 1]);
%bode(sys)

%Amplitude caluated function
function [x] = Amplitude(data)
        output = data(:,2);
        input = data(:,3);
        
        ampout = max(output);
        ampinput = max(input);
        
        x = ampout/ampinput;
end

%phase caluated function
function [x] = phase(data,lowermax,uppermax)
        time =  data(:,1);
        %output = data(:,2);
        %input = data(:,3);
        outputtime = time(lowermax);
        inputtime = time(uppermax);
    x = inputtime-outputtime;
end
%phase caluated function
function [x] = phasefun(data,lowermax,uppermax)
        time =  data(:,1);
        %output = data(:,2);
        %input = data(:,3);
        outputtime = time(lowermax);
        inputtime = time(uppermax);
    x = inputtime-outputtime - 5.03e-4;
end
%phase caluated function        
function [x] = phasefunc(data,lowermax,uppermax)
        time =  data(:,1);
        output = data(:,2);
        input = data(:,3);
        
        ampoutmax = max(output(lowermax:uppermax));
        for i = (lowermax:uppermax)
            if (output(i) == ampoutmax)
                indexo = i;
                outputtime = time(indexo);
                break
            end
        end
        ampinputmax = max(input(lowermax:uppermax));
        for i = (lowermax:uppermax)
            if (input(i) == ampinputmax)
                indexi = i;
                inputtime = time(indexi);
                break
            end
        end
    x = outputtime-inputtime;
end

