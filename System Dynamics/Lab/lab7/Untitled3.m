clear all; clc;

% figure(1)
% subplot(3,1,1)
% [Voltage1] = xlsread('Experiment1.csv');
% time1 = Voltage1(1:6021,1);
% output1 = Voltage1(1:6021,2);
% input1 = Voltage1(1:6021,3);
% plot(time1,input1,'b','Linewidth',2)
% xlim([0 15])
% hold on;
% plot(time1,output1,'g','Linewidth',1);
% xlabel('Time (s)')
% ylabel('Signal (V)')
% title('1 rad/s input signal')
% legend('Input','Output')
% 
% subplot(3,1,2)
% [Voltage100] = xlsread('Experiment100.csv');
% time100 = Voltage100(1:6021,1);
% output100 = Voltage100(1:6021,2);
% input100 = Voltage100(1:6021,3);
% plot(time100,input100,'b','Linewidth',2)
% xlim([0 0.1])
% hold on;
% plot(time100,output100,'g','Linewidth',1);
% xlabel('Time (s)')
% ylabel('Signal (V)')
% title('100 rad/s input signal')
% legend('Input','Output')
% 
% subplot(3,1,3)
% [Voltage500] = xlsread('Experiment500.csv');
% time500 = Voltage500(1:181,1);
% output500 = Voltage500(1:181,2);
% input500 = Voltage500(1:181,3);
% plot(time500,input500,'b','Linewidth',1)
% xlim([0 0.05])
% hold on;
% plot(time500,output500,'g','Linewidth',1);
% xlabel('Time (s)')
% ylabel('Signal (V)')
% title('500 rad/s input signal')
% legend('Input','Output')
% 
% [Voltage1] = xlsread('Experiment500.csv');
% time =  Voltage1(:,1);
% output = Voltage1(:,2);
% input = Voltage1(:,3);
%         
% ampoutmax = max(output);
% for i = 1:7000
%     if (output(i) == ampoutmax)
%         indexo = i;
%         outputtime = time(indexo);
%         break
%     end
% end
% ampinputmax = max(input);
% for i = 1:7000
%     if (input(i) == ampinputmax)
%         indexi = i;
%         inputtime = time(indexi);
%         break
%     end
% end
        
% x = outputtime-inputtime

[Voltage1] = xlsread('Experiment500.csv');
time =  Voltage1(:,1);
output = Voltage1(:,2);
input = Voltage1(:,3);
uppermax = 20;
lowermax = 1;
j = lowermax:1:uppermax;
figure()
subplot(2,1,1)
plot(j,input(j))
hold on
plot(j,output(j))
legend('Input','Output')

subplot(2,1,2)

plot(time(lowermax:uppermax),input(lowermax:uppermax),'b','Linewidth',2)
hold on;
plot(time(lowermax:uppermax),output(lowermax:uppermax),'g','Linewidth',1);
xlabel('Time (s)')
ylabel('Signal (V)')
title('1 rad/s input signal')
legend('Input','Output')

x = phase(Voltage1,uppermax,lowermax)
        
function [x] = phase(data,uppermax,lowermax)
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