clear all; clc; close all


% load data
c = [1.7185; 2.0417; 2.1675; 2.4443;...
    2.7455;  2.9934; 2.8355; 2.9647;...
    3.1859;  3.1002; 3.4029; 4.5731];
T = [252; 266; 290; 305; 312; 315; 324; 324; 338; 343; 352; 388];

% (a) Plot
plot(T,c,'o')
xlabel('T')
ylabel('c')

% (b) find regression coefficients
clog = log(c);
n = length(T);
invT = 1./T;
X = [ones(n,1) invT ];
a = X \ clog

% (c) plot regression function
f = @(invT) exp(a(1) + a(2) * invT + a(3) * invT.^2 );
hold on
plot(T,f(invT),'-')
legend('data','regression')

% (d) make a prediction
c_298 = f(1/298)

% what about a direct linear model bewteen T and c? 
% c = a0 + a1 * T
reg_lin = regstats(c,T);
reg_lin.rsquare 
reg_lin.tstat.pval 
plot(T,reg_lin.yhat,'-')
legend('data','regression','linear')

% check residuals
figure()
plot(T,c - reg_lin.yhat,'o')
xlabel('T')
ylabel('c resid')

% check residuals for exp inv quad model
figure()
plot(invT,clog - X*a,'o')
xlabel('invT')
ylabel('clog resid')

% check statistics for exp inv quad model
reg_expinvquad = regstats(clog,[invT invT.^2]);
reg_expinvquad.rsquare 
reg_expinvquad.tstat.pval 

% try with exp inv lin model
reg_expinvlin = regstats(clog,[invT]);
reg_expinvlin.rsquare 
reg_expinvlin.tstat.pval 

% using exp inv lin model, what is the uncertainty in a0? a1? 
% confidence intervals for regression coefficients
% at the alpha % level, Eqs 17.29 and 30
a = reg_expinvlin.beta
a_std = reg_expinvlin.tstat.se;
DOF = reg_expinvlin.tstat.dfe;  % length(T) - length(a)

% compute confidence intervals at alpha-level
alpha    = 0.95;
t_crt   = abs(tinv((1-alpha)/2,DOF));
a_upper = a + t_crt.*a_std
a_lower = a - t_crt.*a_std


