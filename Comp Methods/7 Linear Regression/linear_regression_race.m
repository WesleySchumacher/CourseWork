% MCEN 3030
% Spring 2020
% regresssion of distances vs record times
clear all; clc; close all

% distances [m]
x = [100,200,400,800,1500,5000,10000,42195]';

% Olympic record times (as of 1985) [s]
y = [9.9, 19.8, 43.8, 103, 212.5, 785.6, 1658.4, 7761]';

% plot data
subplot(2,2,1)
plot(x,y,'o','MarkerSize',8)
xlabel('distance [m]')
ylabel('record time [s]')
 set(gca,'FontSize',10)

% what is slope of linear fit of time as a function of distance?
% (a)  -64.7299         (c) 0.1826
% (b)    0.1846   correct      (d) other

% Build design matrix (Vandermonde matrix)
X = [ones(length(x),1), x];

% solve for regression coefficients
a = X\y;

% estimate values
 f = X*a;

% plot estimates on top of data
hold on
plot(x,f,'-')
legend('data','regression','Location','NorthWest')
txts=['y= ' , num2str(a(1)), '+' , num2str(a(2)) '*x'];
text(2e4,500,txts)


%-64.7299+0.1846*30000
% what would record time be for a 30 km race?
% (a) 5.4732e+03 correct
% (b) 5.5379e+03
% (c) 6000
% (d) other
f_30km = [1 30000]*a;

% residuals


e = f-y;
subplot(2,2,2)
plot(x,e,'o')
xlabel('distance x');
ylabel('residual e')
%  R^2  (Eq 17.10)


Sr = e' * e; %sum (e.^2)
R2 = 1 -Sr /sum((y -mean(y)).^2)

%physical intuition


%when R^2 is 1 you have explained 100%

% uncertainty (standard devations) for regression coefficients
% Eq 17.27 (standard deviation = sqrt(variance)
DOF   = length(x) - length(a);
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

% % display results
fprintf(' i     a(i)        std dev      %2.0f%% lower    %2.0f%% upper    p-value \n', alpha*100, alpha*100)
for i = 1:length(a)
    
    fprintf(' %i %12.4g %12.4g %12.4g %12.4g %12.4g  \n', i, a(i), a_std(i), a_lower(i), a_upper(i), pval(i) )
    
end



% which of the following is an indication that the linear regression
% model of y = a1 + a2*x is not a good model? 
% (a) The value of a(1)     70% say its not a good option  prof-nogood
% (b) The value of R2       70% say its not a good option  prof -n
% (c) The standard deviation of a(1)    50% say its not a good option prf-n
% (d) The confidence interval for a(1)    60% say its not a good option
% (e) the pvalue of a(1)     30% say its a good option     prof-useful

% distances [m]
z = [100,200,400,800,1500,5000,10000,42195]';

% Olympic record times (as of 1985) [s]
w = [9.9, 19.8, 43.8, 103, 212.5, 785.6, 1658.4, 7761]';

x = log(z);
y = log(w);
% plot data
subplot(2,2,3)
plot(x,y,'o','MarkerSize',8)
xlabel('distance [m]')
ylabel('record time [s]')
 set(gca,'FontSize',10)

% what is slope of linear fit of time as a function of distance?
% (a)  -64.7299         (c) 0.1826
% (b)    0.1846   correct      (d) other

% Build design matrix (Vandermonde matrix)
X = [ones(length(x),1), x];

% solve for regression coefficients
a = X\y;

% estimate values
 f = X*a;

% plot estimates on top of data
hold on
plot(x,f,'-')
legend('data','regression','Location','NorthWest')
txts=['y= ' , num2str(a(1)), '+' , num2str(a(2)) '*x'];
text(7,3,txts);


%-64.7299+0.1846*30000
% what would record time be for a 30 km race?
% (a) 5.4732e+03 correct
% (b) 5.5379e+03
% (c) 6000
% (d) other
f_30km = [1 30000]*a;

% residuals


e = f-y;
subplot(2,2,4)
plot(x,e,'o')
xlabel('distance x');
ylabel('residual e')
%  R^2  (Eq 17.10)


Sr = e' * e; %sum (e.^2)
R2 = 1 -Sr /sum((y -mean(y)).^2)

%physical intuition


%when R^2 is 1 you have explained 100%

% uncertainty (standard devations) for regression coefficients
% Eq 17.27 (standard deviation = sqrt(variance)
DOF   = length(x) - length(a);
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

% % display results
fprintf(' i     a(i)        std dev      %2.0f%% lower    %2.0f%% upper    p-value \n', alpha*100, alpha*100)
for i = 1:length(a)
    
    fprintf(' %i %12.4g %12.4g %12.4g %12.4g %12.4g  \n', i, a(i), a_std(i), a_lower(i), a_upper(i), pval(i) )
    
end

%with regstats alwasy includes and intercept
reg = regstats(y,X(:,2:end))




