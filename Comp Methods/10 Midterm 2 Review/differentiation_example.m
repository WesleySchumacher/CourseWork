clear all; close all; clc

% define function and value at which to calculate derivative 
f  = @(x) sin(x) + x^2 + 3;
xi = 4; 

% error tolerance
tol = 1e-6; 

% test
dfdx = adapt(f,xi,tol);

fprintf('numerical 2nd derivative = %20.16d +/- %e \n',dfdx,tol)



function D_return = adapt(f, xi, tol)
%%% ===============================================
%%% = adapt                                       =
%%% = f   :: function name                        =
%%% = xi  :: function value                       =
%%% = tol :: error tolerance                      =
%%% ===============================================

% initialize 
h     = 1;
error = 999;
imax  = 20;

% true value of 2nd deriv [use only for debugging]
D_true = 2 - sin(xi);

% differentiate adaptively 
for i = 1:imax

    % Evaluate the derivative using interval of size h
    D(i) = diff2_3pt(f,xi,h);
    
    % Calculate the error
  
        
    % estimate error
    if i > 1
        
        error(i) = abs(D(i) - D(i-1))/3;
        
        % true error [only use this for debugging]
        error_true(i) = abs((D(i) - D_true));
        
        h_save(i) = h;
        
        
        fprintf(' %0.12e with error < %0.8e (error_true = %0.8e) using interval %f  \n',...
            D(i), error(i), error_true(i), h)
        
        if error(i) < tol
            break
        end
        
    end
    
    
    % double the number of intervals
    h = h / 2;

end

% final answer: 
D_return = D(i);

figure()
loglog(h_save(2:end),error(2:end),'-')
xlabel('h')
ylabel('error')

end


function[diff2]= diff2_3pt(f,xi,h)    
% = Second derivative using 3 point centered FD =
% = f   :: function name                        =
% = xi  :: function value                       =
% = h   :: interval size                        =
% ===============================================

% 3 point centered FD estimate of f''

diff2 = ( f(xi-h) - 2*f(xi) + f(xi+h) ) / (h^2);

end



