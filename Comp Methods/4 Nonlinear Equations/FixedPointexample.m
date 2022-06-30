

g1= @(x) (x^3  - 6*x^2 - 6.1)/-11;
x1 = 2.9;
y = fixed_point(x1,g1);

function[xroot]=fixed_point(x_init, g)
%---------------------------------------------
% inputs
%  xa = value less than or equal to root
%  xb = value greater than or equal to root
%   f = name of function of which to find root
% ouputs
%  xroot = root of f(x) between xa and xb
%----------------------------------------------

kmax  = 100;

e_rel = 0.1;    % machine precision
x(1) = x_init;

for k = 1:kmax
    x(k+1) = g(x(k));
    
    % error estimate
    est_err = abs( ( x(k+1) - x(k) ) / x(k));
    
    fprintf(' at itr %i x = %20.15f est_err = %20.16f \n', k, x(k+1), est_err);
    
    % convergence criteria for relative error
    if est_err  < e_rel
        fprintf(' Fixed point converged: x = %20.16f \n', x(k))
        xroot = x(k);
        return
    end
    
end
     
disp('Fixed point: did not converge!')

end