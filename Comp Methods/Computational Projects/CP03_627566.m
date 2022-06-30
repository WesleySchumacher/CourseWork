%% Wesley Schumacher
% ME ID:627-566
% MCEN 3030 Computational Methods
% Spring 2020
%Computational Project 3

%% House-keeping Runner function
clear all; clc; close all; warning('off','all');

%% part 1

%loading the data from txt files into matlab
strain = load('strain.txt');
stress = load('stress.txt');

%Using regstats to find the r^2, yhat, and other values
%whichstats = {'yhat','r','rsquare','beta'};
stats = regstats(log(stress),log(strain));%,'linear',whichstats);
yhat1 = stats.yhat;
r1 = stats.r;
rsquare1 = stats.rsquare;
beta1 = stats.beta;
pval1 = stats.tstat.pval;
fprintf('part 1(a)  pseudo-plastic model \n');

subplot(3,2,1)
%ploting the natural log of both strain and stress
plot(log(strain),log(stress),'o','MarkerSize',6)
ylabel('ln(Stress)')
xlabel('ln(strain)')
title('Psedo plastic fluids Stress vs strain')

%Creating X as a matrix with 1s in the column and the strain values
X = [ones(length(strain),1), strain];
%solving for
a = X\stress;
f = X*a;
hold on
plot(log(strain),yhat1,'-')
legend('stress vs strain','regression','Location','NorthWest')
txts1=['y= ' , num2str(beta1(1)), '+' , num2str(beta1(2)) '*x'];
text(0.5,-0.5,txts1)

%solving for the residual
e = f-stress;
subplot(3,2,2)
plot(log(strain),r1,'o')
xlabel('ln(stress)');
ylabel('residual e')
title('Psedo plastic fluids residual vs strain')

%r-squard value
Sr = r1' * r1; %sum (e.^2)
R21 = 1 -Sr /sum((stress -mean(stress)).^2);
fprintf('R^2 value of linear regression: %f \n', rsquare1);

%solving for standard deviation
DOF   = length(strain) - length(beta1);
s_yx  = sqrt( Sr/DOF );
Cov_a = s_yx^2 * inv( X'*X );
a_std = sqrt( diag(Cov_a) );

% confidence intervals for regression coefficients
% at the alpha % level, Eqs 17.29 and 30
alpha    = 0.95;
t_crt   = abs(tinv((1-alpha)/2,DOF));
a_upper = beta1 + t_crt.*a_std;
a_lower = beta1 - t_crt.*a_std;

% p-values for null hypothesis that regression coefficients are zero
t    = (beta1 - 0) ./ a_std;
pval = (1-tcdf(abs(t),DOF))*2;
fprintf(' i     a(i)        std dev      %2.0f%% lower    %2.0f%% upper    p-value \n', alpha*100, alpha*100)
%using a for loop to print the values to a table 
for i = 1:length(beta1)
    
    fprintf(' %i %12.4g %12.4g %12.4g %12.4g %12.4g  \n', i, beta1(i), a_std(i), a_lower(i), a_upper(i), pval1(i) )
    
end


fprintf(' \n');
fprintf('part 1(b)  Newtonian model \n');
subplot(3,2,3)
%ploting the stress strain for the newtonian model
plot((strain),(stress),'o','MarkerSize',6)
ylabel('Stress')
xlabel('strain')
title('Newtonian fluids Stress vs strain')

hold on;
%building The matrix and setting it equal to stain becasue its one
%dimention
X = strain;
%solving for coefficients 
a2 = X\stress;

f = strain*a2;
%ploting the resitual line verses strain
plot(strain,f,'-')
legend('stress vs strain','regression','Location','NorthWest')
txts2=['y= ' , num2str(a2(1)) '*x'];
text(2.2,1,txts2)
newslope = a2(1);

%solving for the residual
e = f-stress;
subplot(3,2,4)
plot(strain,e,'o')
xlabel('strain');
ylabel('residual e')
title('Newtonian fluids residual vs strain')

Sr = e' * e; %sum (e.^2)
R2 = 1 -Sr /sum((stress -mean(stress)).^2);
fprintf('R^2 value of linear regression: %f \n', R2);

DOF   = length(strain) - length(a2);
s_yx  = sqrt( Sr/DOF );
Cov_a = s_yx^2 * inv( X'*X );
a_std = sqrt( diag(Cov_a) );

% confidence intervals for regression coefficients
% at the alpha % level, Eqs 17.29 and 30
alpha    = 0.95;
t_crt   = abs(tinv((1-alpha)/2,DOF));
a_upper = a2 + t_crt.*a_std;
a_lower = a2 - t_crt.*a_std;

% p-values for null hypothesis that regression coefficients are zero
t    = (a2 - 0) ./ a_std;
pval2 = (1-tcdf(abs(t),DOF))*2;

% % display results
fprintf(' i     a(i)        std dev      %2.0f%% lower    %2.0f%% upper    p-value \n', alpha*100, alpha*100)
for i = 1:length(a2)
    
    fprintf(' %i %12.4g %12.4g %12.4g %12.4g %12.4g  \n', i, a2(i), a_std(i), a_lower(i), a_upper(i), pval2(i) )
    
end

fprintf(' \n');
fprintf('part 1(c) Bingham plastic model \n');

%building The matrix and setting it equal to stain becasue its one dimention
X = [ones(length(strain),1), strain];
%solving for coefficients 
a = X\stress;
f = X*a;

%using regstats to solve for the needed values
%whichstats = {'yhat','r','rsquare','beta'};
stats = regstats(stress,strain);%,'linear',whichstats);
yhat3 = stats.yhat;
r3 = stats.r;
rsquare3 = stats.rsquare;
beta3 = stats.beta;
pval3 = stats.tstat.pval;

subplot(3,2,5)
%ploting strain vs stress
plot((strain),(stress),'o','MarkerSize',6)
ylabel('Stress')
xlabel('strain')
title('Bingham plastic fluids Stress vs strain')

hold on;
%ploting the residual line
plot(strain,yhat3,'-')
legend('stress vs strain','regression','Location','NorthWest')
txts3=['y= ' , num2str(beta3(1)), '+' , num2str(beta3(2)) '*x'];
text(2.2,1,txts3)

subplot(3,2,6)
%plotting the residual liine
plot(strain,r3,'o')
xlabel('stress');
ylabel('residual e')
title('Bingham plastic fluids residual vs strain')
fprintf('R^2 value of linear regression: %f \n', rsquare3);
DOF   = length(strain) - length(a);
s_yx  = sqrt( Sr/DOF );
Cov_a = s_yx^2 * inv( X'*X );
a_std = sqrt( diag(Cov_a) );

% confidence intervals for regression coefficients
% at the alpha % level, Eqs 17.29 and 30
alpha    = 0.95;
t_crt   = abs(tinv((1-alpha)/2,DOF));
a_upper = a + t_crt.*a_std;
a_lower = a - t_crt.*a_std;

% p-values for null hypothesis that regression coefficients are zero
t    = (a - 0) ./ a_std;
pval = (1-tcdf(abs(t),DOF))*2;

% % display results in a table like form
fprintf(' i     a(i)        std dev      %2.0f%% lower    %2.0f%% upper    p-value \n', alpha*100, alpha*100)
for i = 1:length(a)
    
    fprintf(' %i %12.4g %12.4g %12.4g %12.4g %12.4g  \n', i, a(i), a_std(i), a_lower(i), a_upper(i), pval3(i) )
    
end

fprintf(' \n');
fprintf('part 1(d)(i) \n');
%printing answer as a fprintf line
fprintf('The fluid represented by the data given most closely aligns with Newtonian fluid \n this is because the p-value is the lowest which represents that the data represents \n the graph well. And the residuals are random and dont seem to have any order. \n And difference of the 95 percent interval is small. ');
fprintf(' \n');
fprintf('part 1(d)(ii) \n');
%printing answer as a fprintf line
fprintf('The best estimate of this samples viscosity would be the slope of the Newtonian fluid which is %f \n The standard deviation for this sample is ',newslope);
fprintf(' \n');



%% part 2

fprintf('part 2(a) refer to Figure 2 \n');

figure(2)
%converting the txt files into matlab as matrixs
t = load('temperature.txt');
r = load('density.txt');

n = length(t);
%ploting tempature vs density
plot(t,r,'o','MarkerSize',6)
ylabel('density (g/cm^3)')
xlabel('temperature (K)')
title('Temperature vs Density')
hold on
fprintf('part 2(b) refer to Figure 2 \n');

x1 = 396:0.5:512;
p =5;
%using polyfit with tempature, density and p as inputs
a1 = polyfit(t,r,p);
%using polyval to find the values in the polynomial
f = polyval(a1,x1);
plot(x1,f,'k')
X = ones(n,1);
fprintf('part 2(c) refer to Figure 2\n');
for i = 1:p
    
    X = [X t.^i ]  ;
end
%solving for the coefficients 
a = X\r;

%using polyval and flip functions to find the values in the polynomial
h = polyval(flip(a),x1);
%ploting the found values
plot(x1,h,'b')

fprintf('part 2(d) refer to Figure 2 \n');
%changing p value to 24
p =24;
%using polyfit with tempature, density and p+24 as inputs
a = polyfit(t,r,p);
%using polyval and to find the values in the polynomial
f = polyval(a,x1);
%plotting found values
plot(x1,f,'k--')
X = ones(n,1);
fprintf('part 2(e) refer to Figure 2 \n');
for i = 1:p
    %adding elements to matrix
    X = [X t.^i ]  ;
end
%Solving for coefficients
a = X\r;

%using polyval and flip functions to find the values in the polynomial
h = polyval(flip(a),x1);
%plotting values calulated
plot(x1,h,'b--')
legend('data','5th order using polyfit ','5th order using directly solving','24th order using polyfit ','24th order using directly solving','Location','North')
fprintf('part 2(g) \n');
fprintf('The numerical mehtod of finding regression polynomial works better large p values but not for small p values \n small p values are found better using polyfit because of how accurate the lines were. \n');
fprintf('part 2(h) \n');
%finding the density at a given point on the graph
density = polyval(a1,440);
fprintf('Using the 5th order polynomial by polyfit gives a value for density of %f at 440 K \n',density);

fprintf('part 2(h)(i) refer to Figure 3 \n');


%Extra credit option... not sure if this is correct. was just messing
%around
figure(3)
p = 2:1:24;
X = ones(n,1);
for i = p
    
    a = polyfit(t,r,i);
    E(i-1,1) = sum((polyval(a,t)-r).^2);
    
    for j = 1:p-1
        X = [X t.^j ]  ;
    end
    a1 = X\r;
    h1 = (flip(a1));
    E1(i-1,1) = sum((polyval(h1,t)-r).^2);
end
hold on
semilogy(p,E)

semilogy(p,E1)
xlabel('p');
ylabel('residual error')
title('polynomial of size p')
legend('polynomial by using polyval','polynomial by directly solving','Location','North')
