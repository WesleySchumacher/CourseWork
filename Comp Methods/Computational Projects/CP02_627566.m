%% Wesley Schumacher
% ME ID:627-566
% MCEN 3030 Computational Methods
% Spring 2020
%Computational Project 2

%% House-keeping Runner function
clear all; clc; close all;
%x = Jacobian(1,1)
ThreeDplot();

tic
%bad initial guesses 
%magenta starts on the plot
fprintf('<strong>Newtons method with a bad guess: </strong> \n');
NewtonSolver(10,10,10e-6,15);
time1(1) = toc; fprintf('\n');

tic
%Blue starts on the plot
fprintf('<strong>Newtons method for first x-root: </strong> \n');
NewtonSolver(-1,-1,10e-6,15);
time1(1) = toc; fprintf('\n')
fprintf('Computational cost(time required to solve using hand-written code):%20.16f seconds \n', time1(1)); fprintf('\n');

%part 8 (a)
%good initial guesses 
tic
%Red starts on the plot
fprintf('<strong>Newtons method for second x-root:  </strong>\n');
NewtonSolver(1,-1,10e-6,15);
time1(2) = toc;
fprintf('Computational cost(time required to solve using hand-written code):%20.16f seconds \n', time1(2)); fprintf('\n');

%part 8 (c)
tic
fprintf('<strong>Matlab built-in function fsolve without Jacovian:  </strong>\n');
x0 = [0;0];
options = optimoptions('fsolve','Display','iter','StepTolerance',1e-06);
x1 = fsolve(@myfun,x0,options)
time1(3) = toc; 
fprintf('x-root#1 = %f, x-root#2 = %f  \n', x1(1),x1(2));fprintf('\n');
fprintf('Computational cost(time required to solve using fsolve without the Jacobian):%20.16f seconds \n', time1(3)); fprintf('\n');


%part 8 (b)
tic
fprintf('<strong>Matlab built-in function fsolve with Jacovian: </strong> \n');
options = optimoptions('fsolve','Display','iter','Jacobian','on','StepTolerance',1e-06);
x2 = fsolve(@f_And_J, x0,options)
time1(4) = toc;
fprintf('x-root#1 = %f, x-root#2 = %f  \n', x2(1),x2(2));fprintf('\n');

fprintf('Computational cost(time required to solve using fsolve with the Jacobian):%20.16f seconds \n', time1(4)); fprintf('\n');
% x1 = 1.1832128135796373247675778621329
% x2 = -1.566939439402574299237398421323
fprintf('computational time required to solve for roots for each method\n')
fprintf('time required to solve using hand-written code:%20.16f seconds \n', time1(2)); 
fprintf('time required to solve using fsolve without the Jacobian:%20.16f seconds \n', time1(3)); 
fprintf('time required to solve using fsolve with the Jacobian:%20.16f seconds \n', time1(4)); fprintf('\n');
fprintf('It is very interesting that the fastest method seems to be the hand written code \n even though it took 5 iterations and ran part 2 5 times  \n and the method that takes the most time is the fsolve using Jacobian \n Both Jacobian and standard took 6 iterations.  ')
% x1 = -0.97509
% x2 = -0.58331

c1 = @(x,y) (((x+2).^2 + (y-3).^2 - (5.^2)));
c2 = @(x,y) ((x-3).^2 + (y-1).^2 - (2.5.^2));
range =  [-10:0.1:10];
[X,Y]=meshgrid(range,range);
[n,m]=size(X);
for i = 1:n
    for j = 1:m
        n = [c1(X(i,j),Y(i,j)); c2(X(i,j),Y(i,j))];
        Z(i,j) = norm(n);
        %((c1(X(i,j),Y(i,j)))^2 +(c2(X(i,j),Y(i,j)))^2)^(1/2); 
    end
end
figure()
meshc(X,Y,Z)
title('Graph of cell phone towers coverage');
xlabel('x');
ylabel('y');
zlabel('z =||f(x)||');
fprintf('<strong>Coordinates of the first intersection of the towers:  </strong>\n');
options = optimoptions('fsolve','Display','iter','StepTolerance',1e-06);
x3 = fsolve(@myfun1,[2.7;3.7],options)
fprintf('X Coordinate = %f, Y Coordinate = %f  \n', x3(1),x3(2));fprintf('\n');

fprintf('<strong>Coordinates of the second intersection of the towers: </strong> \n');
options = optimoptions('fsolve','Display','iter','StepTolerance',1e-06);
x4 = fsolve(@myfun1,[0.9;-0.8],options)
fprintf('X Coordinate = %f, Y Coordinate = %f  \n', x4(1),x4(2));fprintf('\n');


%% Sup-Fumctions BELOW
%% part 1
% x1^2 +sin(x2) = 0.4
% exp(x1) +x2^3 = 0.1*pi*x1*x2
% =>
% sin(x2) + x1^2 -0.4 = 0
% exp(x1) +x2^3- 0.1*pi*x1*x2 = 0
% =>
% x1^2    +  sin(x2) + -0.4         = 0
% exp(x1) +  x2^3    - 0.1*pi*x1*x2 = 0
% =>
% f = [x1^2    +  sin(x2) + -0.4         ]= [0]
%     [exp(x1) +  x2^3    - 0.1*pi*x1*x2 ]= [0]
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
%3D grid to plot the graph of the systems equations
meshc(X,Y,Z)
title('Graph of system of nonlinear equations');
xlabel('x');
ylabel('y');
zlabel('z =||f(x)||');

%legend({'bad initial guesses: green stars', 'first x-root: blue' , 'second x-root: red '})
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
% J =[ f1  f1 ;  f1  f2
%      x1  x2 ;  x1  x2 ]
% syms xi1 xi2;
%  f1 =  (sin(xi2) + xi1^2 -0.4);
%  f2 =  (exp(xi1) +xi2^3- 0.1*pi*xi1*xi2) ;
% J = [subs(diff(f1,xi1),xi1,x1), subs(diff(f1,xi2),xi2,x2); subs(diff(f2,xi1),[xi1 xi2],[x1 x2]), subs(diff(f2,xi2),[xi1 xi2],[x1 x2])];
%hard coding the partial derivative at each respected positon to form the Jacobian matrix
J = [2*x1, cos(x2); exp(x1) - ((pi*x2)/10), 3*x2.^2 - ((x1*pi)/10);];

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
% iterative variable for iterations and number of time part 2 was called
iter = 0;
part2counter = 0;
% setting vector x equal to a coloum vector of the 2 initial guesses 
x = [x1g; x2g];
%building a coloum vector of zeros to use to calulate error 
zero = [0;0];
%while loop to traverse the different x values to get to a more accurate x
%value with error and iteration as conditions
while (abs(norm(zero -(valuefinder(x(1),x(2))))) > ex) && iter < kmax

    %Finding the more accurate x values using the code from class
    x = x - (Jacobian(x(1),x(2)) \ valuefinder(x(1),x(2)));
    %incrementing the part#2 counter and the iterative variable 
    part2counter = part2counter +1;
    iter = iter +1;
    
    %calculating estimated error at each x1 and x2 value by finding the error 
    est_err = abs(norm(zero - (valuefinder(x(1),x(2)))));
    
    
    if x1g == -1
        plot3(x(1),x(2),norm(valuefinder(x(1),x(2))),'*','MarkerSize',5,'color','b')
        ylim([-2 2]);
        xlim([-2 2]);
        zlim([0 15]);
    elseif x1g == 10
        plot3(x(1),x(2),norm(valuefinder(x(1),x(2))),'*','MarkerSize',6,'color','m')
        ylim([-2 2]);
        xlim([-2 2]);
        zlim([0 15]);
    else 
        plot3(x(1),x(2),norm(valuefinder(x(1),x(2))),'*','MarkerSize',6,'color','r')
        ylim([-2 2]);
        xlim([-2 2]);
        zlim([0 15]);
    end
    iterv(iter,:) = iter;
    x1v(iter,:) = x(1);
    x2v(iter,:) = x(2);
    estv(iter,:) = est_err;
    
end
if iter >= kmax
    
    varNames = {'Iteration','x1 estimated values','x2 estimated values', 'Estimated Error'};
    T = table(iterv, x1v,x2v, estv, 'VariableNames',varNames);
    disp(T)
    fprintf('Number of times the function for f from part 2 was called: %i  \n',part2counter);
    fprintf('Real roots were unable to be found given tolerance in %i iterations  \n', iter);
    fprintf('\n');
else
    
    varNames = {'Iteration','x1 estimated values','x2 estimated values', 'Estimated Error'};
    T = table(iterv, x1v,x2v, estv, 'VariableNames',varNames);
    disp(T)
    xroots = [x(1), x(2)]
    fprintf('x-root#1 = %f, x-root#2 = %f  \n', xroots(1,1),xroots(1,2));fprintf('\n');
    fprintf('Number of times the function for f from part 2 was called: %i  \n',part2counter);
    
    
end
end

%% function for part 9
function [C] = myfun1(y)
 
  C = [((y(1)+2).^2 + (y(2)-3).^2 - 5.^2);
            ((y(1)-3).^2 + (y(2)-1).^2 - 2.5.^2)];
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
  
J = [2*x(1), cos(x(2)); exp(x(1)) - (pi*x(2))/10, 3*x(2)^2 - (x(1)*pi)/10;];
 
end


