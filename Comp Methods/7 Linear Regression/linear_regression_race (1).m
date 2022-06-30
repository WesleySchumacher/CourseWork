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
plot(x,y,'o','MarkerSize',12)
xlabel('distance [m]')
ylabel('record time [s]')
set(gca,'FontSize',22)

% what is slope of linear fit of time as a function of distance?
% (a)  -64.7299         (c) 0.1826
% (b)    0.1846         (d) other

% Build design matrix (Vandermonde matrix)
%X = ?

% solve for regression coefficients
%a = ?

% estimate values
% f = 

% plot estimates on top of data
hold on
plot(x,f,'-')
legend('data','regression','Location','NorthWest')


% what would record time be for a 30 km race?
% (a) 5.4732e+03
% (b) 5.5379e+03
% (c) 6000
% (d) other

% residuals



%  R^2  (Eq 17.10)



% uncertainty (standard devations) for regression coefficients
% Eq 17.27 (standard deviation = sqrt(variance)
% DOF   = length(x) - length(a);
% s_yx  = sqrt( Sr/DOF );
% Cov_a = s_yx^2 * inv( X'*X );
% a_std = sqrt( diag(Cov_a) );

% confidence intervals for regression coefficients
% at the alpha % level, Eqs 17.29 and 30
% alpha    = 0.95;
% t_crt   = abs(tinv((1-alpha)/2,DOF));
% a_upper = a + t_crt.*a_std;
% a_lower = a - t_crt.*a_std;

% p-values for null hypothesis that regression coefficients are zero
% t    = (a - 0) ./ a_std;
% pval = (1-tcdf(abs(t),DOF))*2;

% % display results
% fprintf(' i     a(i)        std dev      %2.0f%% lower    %2.0f%% upper    p-value \n', alpha*100, alpha*100)
% for i = 1:length(a)
%     
%     fprintf(' %i %12.4g %12.4g %12.4g %12.4g %12.4g  \n', i, a(i), a_std(i), a_lower(i), a_upper(i), pval(i) )
%     
% end



% which of the following is an indication that the linear regression
% model of y = a1 + a2*x is not a good model? 
% (a) The value of a(1)
% (b) The value of R2
% (c) The standard deviation of a(1)
% (d) The confidence interval for a(1)
% (e) the pvalue of a(1) 
