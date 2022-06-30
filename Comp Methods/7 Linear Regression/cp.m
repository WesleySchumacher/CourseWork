% MCEN 3030
% Spring 2020
% multiple linear regression for heat capacity
% as a function of tempterature
clear all; close all; clc

% load heat capacity (c) and temp (T)
% data for propanol
data = load('cp_data.txt');
T    = data(:,1);
c    = data(:,2);
n    = length(T);


% t vs cp
subplot(2,2,1)
plot3(T, T.^2,c,'o')
xlabel('T','FontSize',16)
ylabel('T^2','FontSize',16)
zlabel('cp','FontSize',16)
grid on
view(0,0)

% t^2 vs cp
subplot(2,2,2)
plot3(T, T.^2,c,'o')
xlabel('T','FontSize',16)
ylabel('T^2','FontSize',16)
zlabel('cp','FontSize',16)
grid on
view(90,0)

% ln(t) vs cp
subplot(2,2,3)
scatter(log(T),c)
xlabel('ln(T)','FontSize',16)
ylabel('cp','FontSize',16)
grid on

% t vs ln(cp)
subplot(2,2,4)
scatter(1./T,(c))
xlabel('1/T','FontSize',16)
ylabel('cp','FontSize',16)
grid on


% Select correct code for making the desin matrix for 
% aquadratic fit: Cp = a0 + a1  * T + a2 * T^2

% (a) correct
% for i = 1:3
%     X(:,i) = T(:).^(i-1)
% end

% (b) imcorrect
%X = [1 T T.^2]
 %X = [ones(n,1) T T.^2] correct
% (c)
% for i = 1:n incorrect
%     X(i) = T(i)^i
% end

% (d) correct
for i = 1:n
    X(i,:) = [1 T(i) T(i)^2]    ;
end

% (e)
% none of these

% solve for regression coefficients
a = X\c;

[T1, T2] = meshgrid([250:350],[250:350].^2);
Z = a(1) +a(2)*T1 + a(3)*T2;
subplot(2,2,2)
hold on
surf(T1,T2,Z,'edgecolor', 'none')

figure()
f = a(1) + a(2) *T + a(3) *T.^2;
plot(T,f-c, 'o')
xlabel('T')
ylabel('resid')

%regstats
reg = regstats(c,X(:,2:end));
reg.beta;
reg.rsquare;
reg.tstat.pval;


%4th order fit
clear X
for i = 1:n
    X(i,:) = [1 T(i) T(i)^2 T(i)^3 T(i)^4]    ;
end

reg = regstats(c,X(:,2:end));
reg.beta;
reg.rsquare
reg.tstat.pval

 %
 a = polyfit(T,c,2)
 f = a(1)*T.^2 +a(2) *T + a(3)
 
 f = polyval(a,T)