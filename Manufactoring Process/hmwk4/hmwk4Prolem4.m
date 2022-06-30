%% Wesley Schumacher & Dave George
% MCEN 4026 Manufactoring
% Spring 2020
% HW4 Problem 4
clc;
format long
%Constants for Control Charts from Table 36.2
n = 3;
A2 = 1.023;
D3 = 0;
D4 = 2.574;
d2 = 1.693;

fprintf('Part (a) see graphs \n');
fprintf('Part (b) \n');
%machine1
    %Averaging the samples 
    xbar1 = meancalc(machine_1);
    %Average the average of the samples
    xbarbar1 = meanavgcalc(machine_1);
    %Average of the range values
    R1 = Rcalc(machine_1);
    %Average the average of the range values
    Rbar1 = meanavgcalc(R1);
    %Calculating Upper and Lower contorl limits using function call
    UCLx1 = UpperControlLimitx(xbarbar1,A2,Rbar1);
    LCLx1 = LowerControlLimitx(xbarbar1,A2,Rbar1);
    %Calculating Upper and Lower range contorl limits
    UCLr1 = D4 * Rbar1;
    LCLr1 = D3 * Rbar1;
    %Solving for Sigma
    sigma1 = Rbar1/d2;
    %Measure of Potiential capability
    Cp1 = (12.1-11.9)/(6 *sigma1);
    %Measure of Actual Capability
    Cpk1 = min((xbarbar1-11.9)/(3*sigma1), (12.1-xbarbar1)/(3*sigma1));
    %printing Cp and Cpk values
    fprintf('  Machine_1 Cp value: %f   &  Cpk value: %f \n', Cp1,Cpk1);

    figure(1)
    subplot(2,1,1)
    y = 1:200;
    %Creating a vector of 200 set at LCL and UCL values
    lclx1 = LCLx1*(ones(200, 1));
    uclx1 = UCLx1*(ones(200, 1));
    %ploting the xbar values along with the sample
    plot(y,xbar1,'-ob')
    hold on
    %ploting the LCL and UCL
    plot(y,lclx1,'r')
    plot(y,uclx1,'r')
    title('Xbar Contor chart machine1')
    xlabel('sample index')
    ylabel('x_bar')
    legend('data', 'LCL', 'UCL')


    subplot(2,1,2)
    %Creating a vector of 200 set to LCL and UCL range values
    lclr1 = LCLr1*(ones(200, 1));
    uclr1 = UCLr1*(ones(200, 1));
    %ploting the range values along with the sample
    plot(y,R1,'-ob')
    hold on
    %ploting the range: LCL and UCL
    plot(y,lclr1,'r')
    plot(y,uclr1,'r')
    title('Range Contorl chart machine1')
    xlabel('sample index')
    ylabel('R')
    legend('data', 'LCL', 'UCL')
    
%machine2
    xbar2 = meancalc(machine_2);
    xbarbar2 = meanavgcalc(machine_2);
    R2 = Rcalc(machine_2);
    Rbar2 = meanavgcalc(R2);
    UCLx2 = UpperControlLimitx(xbarbar2,A2,Rbar2);
    LCLx2 = LowerControlLimitx(xbarbar2,A2,Rbar2);
    UCLr2 = D4 * Rbar2;
    LCLr2 = D3 * Rbar2;
    sigma2 = Rbar2/d2;
    Cp2 = (12.1-11.9)/(6 *sigma2);
    Cpk2 = min((xbarbar2-11.9)/(3*sigma2), (12.1-xbarbar2)/(3*sigma2));
    fprintf('  Machine_2 Cp value: %f   &  Cpk value: %f \n', Cp2,Cpk2);

    figure(2)
    subplot(2,1,1)
    y = 1:200;
    lclx2 = LCLx2*(ones(200, 1));
    uclx2 = UCLx2*(ones(200, 1));
    plot(y,xbar2,'-ob')
    hold on
    plot(y,lclx2,'r')
    plot(y,uclx2,'r')
    title('Xbar Contor chart machine2')
    xlabel('sample index')
    ylabel('x_bar')
    legend('data', 'LCL', 'UCL')


    subplot(2,1,2)
    lclr2 = LCLr2*(ones(200, 1));
    uclr2 = UCLr2*(ones(200, 1));
    plot(y,R2,'-ob')
    hold on
    plot(y,lclr2,'r')
    plot(y,uclr2,'r')
    title('Range Contorl chart machine2')
    xlabel('sample index')
    ylabel('R')
    legend('data', 'LCL', 'UCL')

%machine3
    xbar3 = meancalc(machine_3);
    xbarbar3 = meanavgcalc(machine_3);
    R3 = Rcalc(machine_3);
    Rbar3 = meanavgcalc(R3);
    UCLx3 = UpperControlLimitx(xbarbar3,A2,Rbar3);
    LCLx3 = LowerControlLimitx(xbarbar3,A2,Rbar3);
    UCLr3 = D4 * Rbar3;
    LCLr3 = D3 * Rbar3;
    sigma3 = Rbar3/d2;
    Cp3 = (12.1-11.9)/(6 *sigma3);
    Cpk3 = min((xbarbar3-11.9)/(3*sigma3), (12.1-xbarbar3)/(3*sigma3));
    fprintf('  Machine_3 Cp value: %f   &  Cpk value: %f \n', Cp3,Cpk3);

    figure(3)
    subplot(2,1,1)
    y = 1:200;
    lclx3 = LCLx3*(ones(200, 1));
    uclx3 = UCLx3*(ones(200, 1));
    plot(y,xbar3,'-ob')
    hold on
    plot(y,lclx3,'r')
    plot(y,uclx3,'r')
    title('Xbar Contor chart machine3')
    xlabel('sample index')
    ylabel('x_bar')
    legend('data', 'LCL', 'UCL')


    subplot(2,1,2)
    lclr3 = LCLr3*(ones(200, 1));
    uclr3 = UCLr3*(ones(200, 1));
    plot(y,R3,'-ob')
    hold on
    plot(y,lclr3,'r')
    plot(y,uclr3,'r')
    title('Range Contorl chart machine3')
    xlabel('sample index')
    ylabel('R')
    legend('data', 'LCL', 'UCL')


%machine4
    xbar4 = meancalc(machine_4);
    xbarbar4 = meanavgcalc(machine_4);
    R4 = Rcalc(machine_4);
    Rbar4 = meanavgcalc(R4);
    UCLx4 = UpperControlLimitx(xbarbar4,A2,Rbar4);
    LCLx4 = LowerControlLimitx(xbarbar4,A2,Rbar4);
    UCLr4 = D4 * Rbar4;
    LCLr4 = D3 * Rbar4;
    sigma4 = Rbar4/d2;
    Cp4 = (12.1-11.9)/(6 *sigma4);
    Cpk4 = min((xbarbar4-11.9)/(3*sigma4), (12.1-xbarbar4)/(3*sigma4));
    fprintf('  Machine_4 Cp value: %f   &  Cpk value: %f \n', Cp4,Cpk4);

    figure(4)
    subplot(2,1,1)
    y = 1:200;
    lclx4 = LCLx4*(ones(200, 1));
    uclx4 = UCLx4*(ones(200, 1));
    plot(y,xbar4,'-ob')
    hold on
    plot(y,lclx4,'r')
    plot(y,uclx4,'r')
    title('Xbar Contor chart machine4')
    xlabel('sample index')
    ylabel('x_bar')
    legend('data', 'LCL', 'UCL')


    subplot(2,1,2)
    lclr4 = LCLr4*(ones(200, 1));
    uclr4 = UCLr4*(ones(200, 1));
    plot(y,R4,'-ob')
    hold on
    plot(y,lclr4,'r')
    plot(y,uclr4,'r')
    title('Range Contorl chart machine4')
    xlabel('sample index')
    ylabel('R')
    legend('data', 'LCL', 'UCL')



%machine5
    xbar5 = meancalc(machine_5);
    xbarbar5 = meanavgcalc(machine_5);
    R5 = Rcalc(machine_5);
    Rbar5 = meanavgcalc(R5);
    UCLx5 = UpperControlLimitx(xbarbar5,A2,Rbar5);
    LCLx5 = LowerControlLimitx(xbarbar5,A2,Rbar5);
    UCLr5 = D4 * Rbar5;
    LCLr5 = D3 * Rbar5;
    sigma5 = Rbar5/d2;
    Cp5 = (12.1-11.9)/(6 *sigma5);
    Cpk5 = min((xbarbar5-11.9)/(3*sigma5), (12.1-xbarbar5)/(3*sigma5));
    fprintf('  Machine_5 Cp value: %f   &  Cpk value: %f \n', Cp5,Cpk5);

    figure(5)
    subplot(2,1,1)
    y = 1:200;
    lclx5 = LCLx5*(ones(200, 1));
    uclx5 = UCLx5*(ones(200, 1));
    plot(y,xbar5,'-ob')
    hold on
    plot(y,lclx5,'r')
    plot(y,uclx5,'r')
    title('Xbar Contor chart machine5')
    xlabel('sample index')
    ylabel('x_bar')
    legend('data', 'LCL', 'UCL')


    subplot(2,1,2)
    lclr5 = LCLr5*(ones(200, 1));
    uclr5 = UCLr5*(ones(200, 1));
    plot(y,R5,'-ob')
    hold on
    plot(y,lclr5,'r')
    plot(y,uclr5,'r')
    title('Range Contorl chart machine5')
    xlabel('sample index')
    ylabel('R')
    legend('data', 'LCL', 'UCL')


%machine6
    xbar6 = meancalc(machine_6);
    xbarbar6 = meanavgcalc(machine_6);
    R6 = Rcalc(machine_6);
    Rbar6 = meanavgcalc(R6);
    UCLx6 = UpperControlLimitx(xbarbar6,A2,Rbar6);
    LCLx6 = LowerControlLimitx(xbarbar6,A2,Rbar6);
    UCLr6 = D4 * Rbar6;
    LCLr6 = D3 * Rbar6;
    sigma6 = Rbar6/d2;
    Cp6 = (12.1-11.9)/(6 *sigma6);
    Cpk6 = min((xbarbar6-11.9)/(3*sigma6), (12.1-xbarbar6)/(3*sigma6));
    fprintf('  Machine_6 Cp value: %f   &  Cpk value: %f \n', Cp6,Cpk6);

    figure(6)
    subplot(2,1,1)
    y = 1:200;
    lclx6 = LCLx6*(ones(200, 1));
    uclx6 = UCLx6*(ones(200, 1));
    plot(y,xbar6,'-ob')
    hold on
    plot(y,lclx6,'r')
    plot(y,uclx6,'r')
    title('Xbar Contor chart machine6')
    xlabel('sample index')
    ylabel('x_bar')
    legend('data', 'LCL', 'UCL')


    subplot(2,1,2)
    lclr6 = LCLr6*(ones(200, 1));
    uclr6 = UCLr6*(ones(200, 1));
    plot(y,R6,'-ob')
    hold on
    plot(y,lclr6,'r')
    plot(y,uclr6,'r')
    title('Range Contorl chart machine6')
    xlabel('sample index')
    ylabel('R')
    legend('data', 'LCL', 'UCL')


%machine7
    xbar7 = meancalc(machine_7);
    xbarbar7 = meanavgcalc(machine_7);
    R7 = Rcalc(machine_7);
    Rbar7 = meanavgcalc(R7);
    UCLx7 = UpperControlLimitx(xbarbar7,A2,Rbar7);
    LCLx7 = LowerControlLimitx(xbarbar7,A2,Rbar7);
    UCLr7 = D4 * Rbar7;
    LCLr7 = D3 * Rbar7;
    sigma7 = Rbar7/d2;
    Cp7 = (12.1-11.9)/(6 *sigma7);
    Cpk7 = min((xbarbar7-11.9)/(3*sigma7), (12.1-xbarbar7)/(3*sigma7));
    fprintf('  Machine_7 Cp value: %f   &  Cpk value: %f \n', Cp7,Cpk7);

    figure(7)
    subplot(2,1,1)
    y = 1:200;
    lclx7 = LCLx7*(ones(200, 1));
    uclx7 = UCLx7*(ones(200, 1));
    plot(y,xbar7,'-ob')
    hold on
    plot(y,lclx7,'r')
    plot(y,uclx7,'r')
    title('Xbar Contor chart machine7')
    xlabel('sample index')
    ylabel('x_bar')
    legend('data', 'LCL', 'UCL')


    subplot(2,1,2)
    lclr7 = LCLr7*(ones(200, 1));
    uclr7 = UCLr7*(ones(200, 1));
    plot(y,R7,'-ob')
    hold on
    plot(y,lclr7,'r')
    plot(y,uclr7,'r')
    title('Range Contorl chart machine7')
    xlabel('sample index')
    ylabel('R')
    legend('data', 'LCL', 'UCL')

fprintf('Part (c)(i) \n');
fprintf(' After looking at the plots, cp, and cpk values for each particular machine we can conclude:  \n');
fprintf('  The machine that likely has a worn bearing is machine 4 because the cp and cpk values are not capable. \n');
fprintf('Part (c)(ii) \n');
fprintf('  The machine that most likely has a tool that’s wearing out very quickly is machine 2 because the range plot increases over time. \n');
fprintf('Part (c)(iii) \n');
fprintf('  The machine that is likely operated by an inexperienced machinist is machine 7 because the xbar plot has a trend every 20 samples. \n');
fprintf('Part (c)(iv) \n');
fprintf('  The machine that  likely has a misaligned fixture is machine 1 because machine 1 has a low cpk value, this implies bad condition or misaligned  fixture. \n');

function [x] = meancalc(data)
%x_bar calculator(Average calculator)
    for i = 1:200 
    x(i) = (data(1,i) + data(2,i) + data(3,i)) / 3;
    end
end
function [x] = meanavgcalc(data)
%x_bar_bar calculator(Average of Averages calculator)  
    %x = sum( data(:)) / 200;
    summer = 0;
    for i = 1:200 
    summer = summer + data(i);
    end
   x = summer / 200;
end
function [x] = Rcalc(data)
%R_bar calculator(Range Average)
    for i = 1:200 
    x(i) = max(data(:,i))- min(data(:,i));
    end
end
function [x] = UpperControlLimitx(x_bar_bar,A2,R_bar)
%UCLx calculator
    x = x_bar_bar  + A2 * R_bar;
end
function [x] = LowerControlLimitx(x_bar_bar,A2,R_bar)
%LCLx calculator
    x = x_bar_bar  - A2 * R_bar;
end