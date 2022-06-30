close all
clc
 
%Voltage loading--------------------------------------------------------------
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

%1 Radian/sec
T_1 = Voltage1(1:3783,1);
Vin_1 = Voltage1(1:3783,3);
Vout_1 = Voltage1(1:3783,2);
 
%2 Radian/sec
T_2 = Voltage2(1:3783,1);
Vin_2 = Voltage2(1:3783,3);
Vout_2 = Voltage2(1:3783,2);
 
%3 Radian/sec
T_3 = Voltage3(1:3783,1);
Vin_3 = Voltage3(1:3783,3);
Vout_3 = Voltage3(1:3783,2);
 
%4 Radian/sec
T_4 = Voltage4(1:3783,1);
Vin_4 = Voltage4(1:3783,3);
Vout_4 = Voltage4(1:3783,2);
 
%5 Radian/sec
T_5 = Voltage5(1:3783,1);
Vin_5 = Voltage5(1:3783,3);
Vout_5 = Voltage5(1:3783,2);
 
%6 Radian/sec
T_6 = Voltage6(1:3783,1);
Vin_6 = Voltage6(1:3783,3);
Vout_6 = Voltage6(1:3783,2);
 
%7 Radian/sec
T_7 = Voltage7(1:3783,1);
Vin_7 = Voltage7(1:3783,3);
Vout_7 = Voltage7(1:3783,2);
 
%8 Radian/sec
T_8 = Voltage8(1:3783,1);
Vin_8 = Voltage8(1:3783,3);
Vout_8 = Voltage8(1:3783,2);
 
%9 Radian/sec
T_9 = Voltage9(1:3783,1);
Vin_9 = Voltage9(1:3783,3);
Vout_9 = Voltage9(1:3783,2);
 
%10 Radian/sec
T_10 = Voltage10(1:3783,1);
Vin_10 = Voltage10(1:3783,3);
Vout_10 = Voltage10(1:3783,2);
 
%20 Radian/sec
T_20 = Voltage20(1:3783,1);
Vin_20 = Voltage20(1:3783,3);
Vout_20 = Voltage20(1:3783,2);
 
%30 Radian/sec
T_30 = Voltage30(1:3783,1);
Vin_30 = Voltage30(1:3783,3);
Vout_30 = Voltage30(1:3783,2);
 
%40 Radian/sec
T_40 = Voltage40(1:3783,1);
Vin_40 = Voltage40(1:3783,3);
Vout_40 = Voltage40(1:3783,2);
 
%50 Radian/sec
T_50 = Voltage50(1:3783,1);
Vin_50 = Voltage50(1:3783,3);
Vout_50 = Voltage50(1:3783,2);
 
%60 Radian/sec
T_60 = Voltage60(1:3783,1);
Vin_60 = Voltage60(1:3783,3);
Vout_60 = Voltage60(1:3783,2);
 
%70 Radian/sec
T_70 = Voltage70(1:3783,1);
Vin_70 = Voltage70(1:3783,3);
Vout_70 = Voltage70(1:3783,2);
 
%80 Radian/sec
T_80 = Voltage80(1:3783,1);
Vin_80= Voltage80(1:3783,3);
Vout_80 = Voltage80(1:3783,2);
 
%90 Radian/sec
T_90 = Voltage90(1:3783,1);
Vin_90 = Voltage90(1:3783,3);
Vout_90 = Voltage90(1:3783,2);
 
%100 Radian/sec
T_100 = Voltage100(1:3783,1);
Vin_100 = Voltage100(1:3783,3);
Vout_100 = Voltage100(1:3783,2);
 
%200 Radian/sec
T_200 = Voltage200(1:3783,1);
Vin_200 = Voltage200(1:3783,3);
Vout_200 = Voltage200(1:3783,2);
 
%300 Radian/sec
T_300 = Voltage300(1:3783,1);
Vin_300 = Voltage300(1:3783,3);
Vout_300 = Voltage300(1:3783,2);
 
%400 Radian/sec
T_400 = Voltage400(1:3783,1);
Vin_400 = Voltage400(1:3783,3);
Vout_400 = Voltage400(1:3783,2);
 
%500 Radian/sec
T_500 = Voltage500(1:3783,1);
Vin_500 = Voltage500(1:3783,3);
Vout_500 = Voltage500(1:3783,2);

%1 and 500 radian/sec plot-------------------------------------------------
 
figure(1)
plot(T_1,Vin_1,'linewidth',3)
hold on
plot(T_1,Vout_1,'g','linewidth',3)
 
axis([0 15 -2 2])
title('1 Rad/sec Output vs Input')
xlabel('Time (sec)')
ylabel('Voltage')
legend('Input','Output')
 
figure(2)
plot(T_500,Vin_500,'linewidth',3)
hold on
plot(T_500,Vout_500,'g','linewidth',3)
 
title('500 Rad/sec Output vs Input')
xlabel('Time (sec)')
ylabel('Voltage')
legend('Input','Output')
axis([0 0.2 -2 2])
 
%magnitude and phase calculations-------------------------------------------------
 
w = [1;2;3;4;5;6;7;8;9;10;20;30;40;50;60;70;80;90;100;200;300;400;500];
w_hz = w./2./pi
 
R = 5100; % Ohm
C = 3.3 * 10^-6; % Farad
 
for i = 1:23
   Mag(i) = (1/(R*C))/(sqrt(w(i)^2+(1/(R*C))^2));
   Phase(i) = -atand(w(i)*R*C);
end
 
%matrix vout vin and time
Vout = [Vout_1 Vout_2 Vout_3 Vout_4 Vout_5 Vout_6 Vout_7 Vout_8 Vout_9 Vout_10 Vout_20 Vout_30 Vout_40 Vout_50 Vout_60 Vout_70 Vout_80 Vout_90 Vout_100 Vout_200 Vout_300 Vout_400 Vout_500];
Vin = [Vin_1 Vin_2 Vin_3 Vin_4 Vin_5 Vin_6 Vin_7 Vin_8 Vin_9 Vin_10 Vin_20 Vin_30 Vin_40 Vin_50 Vin_60 Vin_70 Vin_80 Vin_90 Vin_100 Vin_200 Vin_300 Vin_400 Vin_500];
Time = [T_1 T_2 T_3 T_4 T_5 T_6 T_7 T_8 T_9 T_10 T_20 T_30 T_40 T_50 T_60 T_70 T_80 T_90 T_100 T_200 T_300 T_400 T_500];
 
%magnitude for loop
for i = 1:23;
    Max_Out(i) = max(Vout(:,i));
    Min_Out(i) = min(Vout(:,i));
    Max_In(i) = max(Vin(:,i));
    Min_In(i) = min(Vin(:,i));
    Mag_Out(i) = (Max_Out(i)-Min_Out(i))/2;
    Mag_In(i) = (Max_In(i)-Min_In(i))/2;
    Magnitude(i) = Mag_Out(i)/Mag_In(i);
end
 
%phase matrix
 
phase=zeros(23,1);
phase(1,1)=(T_1(3217)-T_1(3224));
phase(2,1)=T_2(2695)-T_2(2769);
phase(3,1)=T_3(3854)-T_3(3944);
phase(4,1)=T_4(3345)-T_4(3404);
phase(5,1)=T_5(3814)-T_5(3908);
phase(6,1)=T_6(3689)-T_6(3756);
phase(7,1)=T_7(3209)-T_7(3260);
phase(8,1)=T_8(1860)-T_8(1952);
phase(9,1)=T_9(2797)-T_9(2898);
phase(10,1)=T_10(3630)-T_10(3759);
phase(11,1)=T_20(3576)-T_20(4104);
phase(12,1)=T_30(4194)-T_30(4533);
phase(13,1)=T_40(3573)-T_40(3942);
phase(14,1)=T_50(3716)-T_50(4389);
phase(15,1)=T_60(3233)-T_60(3946);
phase(16,1)=(T_70(653)-T_70(1400));
phase(17,1)=T_80(5064)-T_80(5602);
phase(18,1)=T_90(1762)-T_90(2319);
phase(19,1)=T_100(5217)-T_100(5718);
phase(20,1)=T_200(2451)-T_200(3186);
phase(21,1)=T_300(3281)-T_300(3770);
phase(22,1)=T_400(1742)-T_400(2579);
phase(23,1)=T_500(2335)-T_500(2923);
 
 
newphase = 360*phase.*w_hz;
 
%magnitude plot------------------------------------------------------------
 
figure(3)
loglog(w_hz,Magnitude,'.','MarkerSize',10)
hold on
loglog(w_hz,Mag,'-')
ylim([0.1 1.5])
title('Magnitude vs Frequency')
xlabel('Freq (Hz)')
ylabel('Mag')
legend('Voltageal','Theory')
 
%phase plot----------------------------------------------------------------
 
figure(4)
semilogx(w_hz,newphase,'*')
title('Phase vs Frequency')
xlabel('Freq (Hz)')
ylabel('Phase (deg)')
hold on
semilogx(w_hz,Phase,'-')
legend('Voltageal','Theory')
