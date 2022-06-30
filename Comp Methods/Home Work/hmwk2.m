%% Wesley Schumacher
% MCEN 3030 Computational Methods
% Spring 2020
% HW2 code
%% HomeWork2 Problem # 1 part A
clear all; clc; close all;
T = [0.2,0.2,0.2,0.2,0.2; 
    0.35,0.15,0.35,0,0.15;
    0.1,0.3,0.1,0.1,0.4;
    0,0.3,0.1,0.4,0.2;
    0.15,0.3,0.2,0.35,0];
C = [1.44,1.16,1.38,1.78,1.61];
C= C';
Clb = T\C;
fprintf('Cost of Peanuts: %f $/lb \n',Clb(1));
fprintf('Cost of Raisins: %f $/lb \n',Clb(2));
fprintf('Cost of Almonds: %f $/lb \n',Clb(3));
fprintf('Cost of Chocolate Chips: %f $/lb \n',Clb(4));
fprintf('Cost of Dred Plums: %f $/lb \n',Clb(5));

%% HomeWork2 Problem # 2
clear all; clc; close all;
T1 = 0.45;
n1 = 500;
n2 = 1000;
T2 = T1*(((2/3)*n2^3)/((2/3)*n1^3));
fprintf('(a)  %f seconds \n',T2);
if T2 > 60
    fprintf('      %f mins \n',T2/60);
end

T2 = T1*(((2/3)*n1^4)/((2/3)*n1^3));
fprintf('(b)  %f seconds \n',T2);
if T2 > 60
    fprintf('     %f mins \n',T2/60);
end

T2 = T1*(((2/3)*n2^4)/((2/3)*n1^3));
fprintf('(c)  %f seconds \n',T2);
if T2 > 60
    fprintf('     %f mins \n',T2/60);
    fprintf('     %f hours \n',T2/3600);
end

T2 = T1*(((4/3)*n2^3)/((2/3)*n1^3));
fprintf('(d)  %f seconds \n',T2);
if T2 > 60
    fprintf('     %f mins \n',T2/60);
end

%% HomeWork2 Problem # 3
clear all; clc; close all;
a = 1/sqrt(2);

A = [0 1 0 0 0 -1 0 0 0 0 0 0 0
     0 0 1 0 0 0 0 0 0 0 0 0 0
     a 0 0 -1 -a 0 0 0 0 0 0 0 0
     a 0 1 0 a 0 0 0 0 0 0 0 0
     0 0 0 1 0 0 0 -1 0 0 0 0 0
     0 0 0 0 0 0 1 0 0 0 0 0 0
     0 0 0 0 a 1 0 0 -a -1 0 0 0
     0 0 0 0 a 0 1 0 a 0 0 0 0
     0 0 0 0 0 0 0 0 0 1 0 0 -1
     0 0 0 0 0 0 0 0 0 0 1 0 0
     0 0 0 0 0 0 0 1 a 0 0 -a 0
     0 0 0 0 0 0 0 0 a 0 1 a 0
     0 0 0 0 0 0 0 0 0 0 0 a 1];
 
b = [0 10 0 0 0 0 0 15 0 20 0 0 0];
b = b';
f = A\b;
for i = 1:length(A)
    fprintf(' Beam: %i force applied: %f  \n',i,f(i));
end
%% HomeWork2 Problem # 4
clear all; clc; close all;
%(b)


%(c)
A = [5 5 10
    2 8 6
    3 6 -9];
[L,U] = lu(A);
L;
U;
b =[1 2 3];
b = b';
c = (L*U)\b;

if (floor(L*U) == A)
    fprintf('L and U are the correct matrixes \n');
end
%(d)
T1 = 0.001;
n1 = 3;
n2 = 300;
T2 = T1*(((4/3)*n2^3))/(((1/3)*n1^3));
fprintf('(d)  %i seconds \n',T2);
%% HomeWork2 Problem # 5
clear all; clc; close all;

x = [5 10 15 20];
x = x';
y = [2 3.5 6 4];
y = y';

A1 = [x(1)^3 x(1)^2 x(1)^1 x(1)^0
    x(2)^3 x(2)^2 x(2)^1 x(2)^0
    x(3)^3 x(3)^2 x(3)^1 x(3)^0
    x(4)^3 x(4)^2 x(4)^1 x(4)^0]

A = [125 25 5 1
    1000 100 10 1
    3375 225 15 1
    8000 400 20 1];
c = A\y


plot(x,y, 'o')
xlabel('x');
ylabel('y');
title('plot of 3 order polynomial');
 
hold on
x2 = 4:22;
y1 = c(1).*x2.^3 + c(2).*x2.^2 + c(3).*x2.^1 +c(4);
plot(x2, y1)
legend('x & y values','3rd order polynomial','Location','NorthWest');


%% HomeWork2 Problem # 6 
clear all; clc; close all;

A = load('A.txt');
V = load('V.txt');
v1 = V(:,1);
v2 = V(:,2);
v3 = V(:,3);
v4 = V(:,4);
t = v4;

%(a)
figure(1)
plot(t,v1);
xlabel('time');
ylabel('di?erent vibrational data sets vs time');
title('Underground explosions');
hold on
plot(t,v2);
plot(t,v3);
legend('cheap sensor ','sophisticated sensor','expensive sensor','Location','NorthEast');
hold off

cs = A\v1;
ss = A\v2;
es = A\v3;

%(b)
figure(2)
plot(t,cs);
xlabel('time');
ylabel('Estimated explosion magnitudes');
title('Explosions');
hold on;
plot(t,ss);
hold on;
plot(t,es);
legend('cheap sensor ','sophisticated sensor','expensive sensor','Location','NorthEast');


%(c)

error_cs = cond(A) *0.033;
if (error_cs > 5)
    fprintf(' The cheap sensor is the not best option because the explosive pulse magnitude at: %f which is more than 5 percent \n',error_cs);
end
error_ss = cond(A) * 0.0035;
if (error_ss > 5)
    fprintf(' The sophisticated  sensor is not the best option because the explosive pulse magnitude at: %f which is more than 5 percent \n',error_ss);
end
error_es = cond(A) * 0.000017;
if (error_es < 5)
    fprintf(' The expensive  sensor is the best option because the explosive pulse magnitude at: %f which is less than 5 percent \n',error_es);
end
