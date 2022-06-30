%--------------------
% MCEN 3030
% Spring 2020
% L05 driver script
% Bisection in class
%--------------------
function[xroot] = bisectioninclass(xa,xb,f)

% % Colebrook White function for Darcy friction factor
% 
% % roughness
% e  = 0.3;
% 
% % diameter
% D  = 10;
% 
% % Reynolds 
% Re = 5000;
% 
% f = @(x)  1./sqrt(x) + 2*log10(e/(3.7*D) - 2.51./(Re*sqrt(x))); % @ varulable and equation ./ for vector

% ezplot(f)
% grid on
% set(gca, 'FontSize', 18)
% ezplot(f, [0,1]);grid on;set(gca, 'FontSize', 18);

% xa = 0.04;
% xb = 0.06;
if f(xa) == 0
    xroot = xa;
    return
elseif f(xb) == 0
    xroot = xb;
    return
elseif f(xa) * f(xb) > 0
    disp('bad interval!')
    return 
end
kmax = 100;
e_rel = eps;
for k = 1:kmax
    
    x(k) = (xa +xb)/2;
    
    
    if sign( f(x(k))) == sign( f(xa))
        xa = x(k);
    else
        xb = x(k); 
    end
    
    est_err = abs((xa-xb)/xb);
    
    fprintf(' at itr %i est_err = %20.16f \n', k, est_err);
    if (est_err <e_rel)
        fprintf(' bisection converged: x = %20.16f \n', x(k));
        xroot = x(k);
        return 
    end
end


disp('bisection :did not converge!')
end

%% function CW
function[f] = CW(x)
% Colebrook White function for Darcy friction factor

% roughness
e  = 0.3;

% diameter
D  = 10;

% Reynolds 
Re = 5000;

f = @(x)  1./sqrt(x) + 2*log10(e/(3.7*D) - 2.51./(Re*sqrt(x))); % @ varulable and equation ./ for vector

% ezplot(f)
% grid on
% set(gca, 'FontSize', 18)
% ezplot(f, [0,1]);grid on;set(gca, 'FontSize', 18);

% xa = 0.04;
% xb = 0.06;
end










    % if the root does not lie between xa and x(k)
    %if ??

    % (a) x(k)            ~= xa 
    % (b) f(x(k))         ~= f(xa)
    % (c) sign( x(k) )    ~= sign( xa )
    % (d) sign( f(x(k)) ) ~= sign( f(xa) )
    % (e) sign( f(x(k)) ) == sign( f(xa) )
    
    
            % adjust the range
        % (a)  xa = x(k)
        % (b)  xb = x(k)
        % (c)  xa = ( x(k) + xb ) / 2
        % (d)  xb = ( x(k) + xa ) / 2
        % (e)  other 
        
        
        
        
    % convergence criteria for relative error
    % (a) if abs( ( xa - xb ) / xb)            < e_rel
    % (b) if abs( ( x(k) - x_root ) / x_root ) < e_rel 
    % (c) if abs( f(x(k)) )                    < e_rel
    % (d) if abs( x(k) )                       < e_rel
    % (e) if abs( ( x(k) - x(k-1) ) / x(k) )   < e_rel
    
    