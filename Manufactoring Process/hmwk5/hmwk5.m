%% Wesley Schumacher
% MCEN 4026 Manufactoring
% Spring 2020
% HW5 Problem 5
clear all; close all; clc;

Et1 = 0:0.01:0.15;
Et2 = 0.15:0.01:0.8;
Yf1 = 787 .* Et1 + 435;
Yf2 = 345 .* Et2 + 501;

% for i = 1:80
%     et = 0:0.01:0.8;
%     if et< 0.15
%         y(i) = 787 .*et + 435;
%     else 
%         y(i) = 345 .*et + 501;
%     end
% end
% figure(1)
% E = 0.01:0.01:0.8;
% plot(E, y(E));

figure(1)
plot(Et1,Yf1)
hold on
plot(Et2,Yf2)

xlim([0 0.8]);

for i = 1:80
    if i <=15
        y(i) = Yf1(i);
    end
    if i > 15
      y(i) = Yf2(i-15);
    end     
end

figure(2)
et = 0.00:0.01:0.79;
plot(et,y)


%r = sqrt(180000./(y .* pi));
he = 0.05 ./ exp(et);

Vi = pi .* 0.007.^2 *0.05;

hf = (Vi .* y*10^6)/(180000);

figure(3)
plot(y,hf)
hold on
plot(y,he)