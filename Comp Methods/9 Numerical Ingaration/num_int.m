clc; close all; clear all

% sample function from Ex 21.2
f = @(x) 0.2 + 25*x - 200*x.^2 + 675*x.^3 - 900*x.^4 + 400*x.^5;

% bounds
a = 0;
b = 0.8;

% true int
f_int = @(x) 0.2 * x + 1/2 * 25 * x.^2 - 1/3 * 200 * x.^3 + 1/4 * 675 * x.^4 - 1/5 * 900 * x.^5 + 1/6 * 400 * x.^6;
I_tru = f_int(b) - f_int(a);

%unit testing
a_t = 0;
b_t = 10;

f_test = @(x) x - 3;
I_test = @(x) 1/2*x.^2 -3*x;
I_test_tru = I_test(b_t) - I_test(a_t);
A_test = trapezoid(f_test,a_t,b_t, 112343);



%perform adaptive itegration
tol = 1e-12;

N = 4;
err_est = 999;

while err_est > tol
    
    A = trapezoid(f,a,b,N);
    
    %errror est in A
    err_est = abs( A - trapezoid(f,a,b,N/2) ) /3;
    
    %debug
    err_tru = abs(I_tru-A);
    fprintf('trap with %i int gives %f with err est %e (err true = %e) \n ',N, A, err_est, err_tru)
    
    
    N = 2* N;
end

N = 4;
err_est = 999;

fprintf(' \n\n\n with Richardson +trap \n')

while err_est > tol
    
    A = trap_rich(f,a,b,N);
    
    %errror est in A
    err_est = abs( A - trap_rich(f,a,b,N/2))/3;
    
    %debug
    err_tru = abs(I_tru-A);
    
    fprintf('trap_rich with %i int gives %f with err est %e (err true = %e) \n ',N, A, err_est, err_tru)
    
    
    N = 2* N;
end


A1 = trap_rich(f,a,b,4);
A2 = trap_rich(f,a,b,8);
E1 = abs(A2 - A1 ) /15;
N = 8 / (tol/E1)^(1/4)
N = floor(N)
if mod(N,2) == 1
    N = N+1
end
A_final = trap_rich(f,a,b,N)
err_final = abs(A_final - I_tru)

% trapizoid method
function A_ret = trapezoid(f,a,b,N)

% N - # of intervals
h = (b-a)/N;
x = a:h:b;

%composite trapezoid (muli-apploication)
A_ret = h/2 * (f(x(1)) + 2*sum(f(x(2:N))) + f(x(end)));

end

%reichardson
function A_ret = trap_rich(f,a,b,N)

A_ret = (4* trapezoid(f,a,b,N)- trapezoid(f,a,b,N))/3;
end