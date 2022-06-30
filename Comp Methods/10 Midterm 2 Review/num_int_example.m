clear all; clc; close all


% experimental data:

% distance (x), force (f), and angle (th)
x  = [0.0000  5.0000 10.000  15.0000 20.0000];  % [m]
F  = [5.5750  5.8245  5.1341  4.2761  5.9457];  % [N]
th = [0.8950  0.8958  0.6908  0.3563  0.0990];

y = F .* cos(th)

A_trap_h5 = 5/2*(y(1) + 2*sum(y(2:4)) + y(5))

% (b) 81.5310
%

A_trap_h10 = 10/2*(y(1) + 2*y(3) + y(5))

n = 2
error_trap_h5 = abs(A_trap_h5 - A_trap_h10)/(2^n - 1)

A_trap_h20 = 20/2*(y(1) + y(5))

% (a) 2
% (b) 3
% (c) 4
% (d) 15
% (e) other

n = 2;
A_rich_h5_h10 = (2^n*A_trap_h5 - A_trap_h10)/(2^n-1)
A_rich_h10_h20 = (2^n*A_trap_h10 - A_trap_h20)/(2^n-1)

% estimate error in better Richardson
n = 4;
err_rich_h5_h10 = abs(A_rich_h5_h10 - A_rich_h10_h20)/(2^n-1)

% (a) 2
% (b) 3
% (c) 4
% (d) 15
% (e) other

answer = A_rich_h5_h10
error = err_rich_h5_h10

% Richardson again (ie Romberg)
n = 4;
A_romb = (2^n*A_rich_h5_h10 - A_rich_h10_h20 )/(2^n-1)
err_rich_h5_h10 = abs(A_romb - A_rich_h5_h10)

% USING SIMPSONs


% with h=5
A_simp_h5 = 5/3*(y(1) + 4*y(2) + 2*y(3) + 4 * y(4) + y(5))

% same as A_rich_h5_h10!

% with h = 10
A_simp_h10 = 10/3*(y(1)+4*y(3)+y(5))

% same as A_rich_h10_h20! 

answer = A_simp_h5

n = 4
error_A_simp_h5 = abs(A_simp_h5 - A_simp_h10)/(2^n -1) %15
























