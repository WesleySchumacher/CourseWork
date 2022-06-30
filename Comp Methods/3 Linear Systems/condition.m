%--------------------
% MCEN 3030
% Spring 2020
% L03 driver script
% Condition
%--------------------
clear all; clc; close all

format long

% define coef matrix
A = [3/7 5/6; 10.5001/49 15/36];

% pick true solution
x_t = ones(2,1);

% generate the b values corresponding to the true solution
b = A * x_t;

fprintf('keep all digits: %18.15f %18.15f \n',b(1),b(2));

% loop over number of sig digits
for k = 3:15
    
    % chop
    d = fix( b .* (10^k) ) ./ 10^k;
    
    fprintf('keep %3i digits: %18.15f %18.15f \n',k,d(1),d(2));
    
    % find x using this d
    x = A \ d;
        
    % what is the relative true error in this estimate of d?
    error_d(k) =  norm(d - b)/norm(b);
    % (a) k 
    % (b) norm(d) 
    % (c) norm(d-b)
    % (d) norm(d-x_t)/norm(x_t)
    % (e) norm(d - b)/norm(b) =====CORRECT ANSWER
    
    % what is the relative residual error of our equation Ax = d?
    resid(k) = max( norm(A*x -d)/norm(d));
    
    % what is the relative true error in x? 
    error_x(k) = norm(x-x_t)/norm(x_t);
end
% 

% Make a plot of the error in d, the residual error, and the true error on one
% figure using log-scale for the vertical axis, labeled with a legend
semilogy(3:15,error_d(3:15))
hold on
semilogy(3:15,resid(3:15))
semilogy(3:15,error_x(3:15))
xlabel('error');
ylabel('digits of accuracy in d(k)');
legend('error in d', 'residual','true error x')

% how much is the true error different from residual error?
%b depends on k


%how much is the true eror different from the relative error in k
%always by a factor of cond(A)

% how could we have better approximated the relative error in x, for 
% a (realistic) situation in which we know the error in d but not the true x? 
 semilogy(3:15,error_d(3:15)*cond(A))
 legend('error in d','residual error','true err','est error')


%set(gca,'FontSize',18);

