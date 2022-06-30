%% Wesley Schumacher
% ME ID:627-566
% MCEN 3030 Computational Methods
% Spring 2020
%Project 2

%% House-keeping
clear all; clc; close all;
%x = Jacobian(1,1)
ThreeDplot();

tic
%bad initial guesses 
%Blue starts on the plot
NewtonSolver(1.1,-1.56,10e-6,15);
time1(1) = toc; fprintf('\n');

%part 8 (a)
%good initial guesses 
tic
%Red starts on the plot
NewtonSolver(1.183,-1.5669,10e-6,15);
time1(2) = toc;
fprintf('Computational cost(time required to solve using hand-written code):%20.16f seconds \n', time1(2)); fprintf('\n');

%part 8 (c)
tic
x0 = [1;-1.5];
options = optimoptions('fmincon','Display','iter','StepTolerance',1e-06);
[x,fval] = fsolve(@myfun,x0,options)
time1(3) = toc; 

fprintf('Computational cost(time required to solve using fsolve with the Jacobian):%20.16f seconds \n', time1(2)); fprintf('\n');


%part 8 (b)
tic
options = optimoptions('fsolve','Display','iter','Jacobian','on','StepTolerance',1e-06);
[x1,fval1] = fsolve(@myfun,x0,options)
time1(4) = toc;

fprintf('Computational cost(time required to solve using fsolve without the Jacobian):%20.16f seconds \n', time1(2)); fprintf('\n');
% x1 = 1.1832128135796373247675778621329
% x2 = -1.566939439402574299237398421323

%% problem #9
clear all; clc; close all;

c1 = @(x,y) ((x+2).^2 + (y-3).^2 - 5.^2);
c2 = @(x,y) ((x-3).^2 + (y-1).^2 - 2.5.^2);
range =  [-10:0.1:10];
[X,Y]=meshgrid(range,range);
[n,m]=size(X);
for i = 1:n
    for j = 1:m
        Z(i,j) = ((c1(X(i,j),Y(i,j)))^2 +(c2(X(i,j),Y(i,j)))^2)^(1/2); 
    end
end
meshc(X,Y,Z)
title('graph of cell phone towers coverage');
xlabel('x');
ylabel('y');
zlabel('z');

%% Sup-Fumctions BELOW

%% Function for part 2
function[out] = valuefinder(x1,x2)
% function that takes as inputs values of x1, and x2, and returns a value of f = [f1,f2]T. 
% Input variables:
% x1  input value of x1.
% x2  input value of x2.
% Output variable:
% f  the solutions to the equations with the inputs
%Part1 

f1 = @(x1,x2) (sin(x2) + x1^2 -0.4);
f2 = @(x1,x2) (exp(x1) +x2^3- 0.1*pi*x1*x2) ;

out = [f1(x1,x2); f2(x1,x2) ];


end

%% Function for part 3
function[] = ThreeDplot()
% function that makes a 3D plot with meshc over the range of -2 to 2 with z
% being the nomral coordante 
f1 = @(x1,x2) (sin(x2) + x1.^2 -0.4);
f2 = @(x1,x2) (exp(x1) +x2.^3- 0.1*pi*x1*x2) ;


range =  [-2:.1:2];
[X,Y]=meshgrid(range,range);
[n,m]=size(X);
for i = 1:n
    for j = 1:m
        Z(i,j) = ((f1(X(i,j),Y(i,j)))^2 +(f2(X(i,j),Y(i,j)))^2)^(1/2);  
    end
end
meshc(X,Y,Z)
title('graph of f(x1,x2)');
xlabel('x');
ylabel('y');
zlabel('z');
hold on;
end
%% Function for part 4
function[J] = Jacobian(x1,x2)
% function that takes values of x1 and x2 as inputs and the returns the Jacobian matrix
% Input variables:
% x1  input value of x1.
% x2  input value of x2.
% Output variable:
%jacobian([sin(x1)+2*x1*x2-x3^2,x1*x2-8,x2^2 - 10*log(x3)],[x1,x2,x3])
% J a Jacobian matrix with the x1 and x2 as the input variables
% J =[ ?f1      ?f1
%      ?x1      ?x2
%
%      ?f1      ?f2
%      ?x1      ?x2 ]
% syms xi1 xi2;
%  f1 =  (sin(xi2) + xi1^2 -0.4);
%  f2 =  (exp(xi1) +xi2^3- 0.1*pi*xi1*xi2) ;
% J = [subs(diff(f1,xi1),xi1,x1), subs(diff(f1,xi2),xi2,x2); subs(diff(f2,xi1),[xi1 xi2],[x1 x2]), subs(diff(f2,xi2),[xi1 xi2],[x1 x2])];

J = [2*x1, cos(x2); exp(x1) - (pi*x2)/10, 3*x2^2 - (x1*pi)/10;];

end

%% Function for part 5
function[xroots] = NewtonSolver(x1g,x2g,ex,kmax )
% Newton solver function that  attempt to ?nd the roots using Newton’s method,
% and converge when the absolute estimated error in x is less than Ex
% It should display a table of the estimated values of x1, x2, and the absolute error at each iteration
% Input variables:
% x1g initial guess for x1.
% x2g initial guess for x2.
% ex the tolerance; converge when the absolute estimated error in x is less than Ex
% kmax the max number of iterations 
% Output variable:
% xroots the true roots of the equations 
%display a message to the screen stating whether or not a solution was found within kmax iterations.
x1_old = 2;
x1i = x1g;
x2i = x2g;
iter = 0;
part2counter = 0;
while (abs((x1i-x1_old)/x1_old)) > ex && iter < kmax
    x1_old = x1i; 
    x2_old = x2i;
    J = Jacobian(x1i,x2i);
    valuesinitalguesses = valuefinder(x1i,x2i);
    part2counter = part2counter +1;
    u0 = valuesinitalguesses(1);
    v0 = valuesinitalguesses(2);
    
    x1i = x1_old - ((u0*J(2,2) - v0*J(2,1))/det(J));
    x2i = x2_old - ((v0*J(1,1) - u0*J(1,2))/det(J));
    iter = iter +1;
    est_err = abs((x1i-x1_old)/x1_old);
    
    
    if x1g == 1.1
        plot3(x1i,x2i,0,'*','MarkerSize',5,'color','b')
        ylim([-2 2]);
        xlim([-2 2]);
        zlim([0 15]);
    else
        plot3(x1i,x2i,0,'*','MarkerSize',6,'color','r')
        ylim([-2 2]);
        xlim([-2 2]);
        zlim([0 15]);
    end
    %fprintf('iteration: %i estimated values for x1: %20.16f and x2: %20.16f  est_err = %20.16f \n',iter ,x1i,x2i, est_err);
    iterv(iter,:) = iter;
    x1v(iter,:) = x1i;
    x2v(iter,:) = x2i;
    estv(iter,:) = est_err;
    
end
if iter >= kmax
    
    varNames = {'Iteration','x1 estimated values','x2 estimated values', 'Estimated Error'};
    T = table(iterv, x1v,x2v, estv, 'VariableNames',varNames)
    fprintf('Number of times the function for f from part 2 was called: %i  \n',part2counter);
    fprintf('Real roots were unable to be found given tolerance in %i iterations  \n', iter);
    fprintf('\n');
else
    xroots = [x1i, x2i];
    varNames = {'Iteration','x1 estimated values','x2 estimated values', 'Estimated Error'};
    T = table(iterv, x1v,x2v, estv, 'VariableNames',varNames)
    
    %fprintf('Newtons Method converged:  x1 = %20.16f, x2 = %20.16f after %i number of iterations \n', xroots(1),xroots(2),iter);
    fprintf('Number of times the function for f from part 2 was called: %i  \n',part2counter);
    
    
end
end


%% Function for part 7 a and c
function [F] = myfun(x)
 F = [ (sin(x(2)) + x(1)^2 -0.4) ;
      (exp(x(1)) +x(2)^3- 0.1*pi*x(1)*x(2))];
end

%% Function for part 7 b 
function [f,J] = f_And_J(x)
% function that takes x as an input and provides [f,J] as the output. 
% Input variables:
% x  a vector of x1, x2.
% Output variable:
% f  the solutions to the equations with the inputs
% J  the jacobian solution with the inputs

f = [ (sin(x(2)) + x(1)^2 -0.4) ;
      (exp(x(1)) +x(2)^3- 0.1*pi*x(1)*x(2))];
  
J = [2*x1, cos(x2); exp(x1) - (pi*x2)/10, 3*x2^2 - (x1*pi)/10;];
 
end




