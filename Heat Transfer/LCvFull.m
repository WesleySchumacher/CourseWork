function LCvFull
%built by keith regner 10/2016 with R2014b (8.4 OSX)
clear, close all

%% description
% This demo models the time-dependent center temperature of a spherical 
% marble with the lumped capacitance model (solid blue line) and the full 
% solution (solid black line), as shown in the top plot. The percent 
% difference between the two solutions is shown in the bottom plot. Vary 
% the Biot number Bi with the slider bar and observe how the percent 
% difference between the two solutions changes. Note that the lumped 
% capacitance model is valid if Bi < 0.1. Physical parameters and the 
% number of terms used in the full solution can be edited in the m-file.


%% parameters
b.Ti = 500;                   %initial temp of marble
b.Tinf = 300;                 %temperature of water
b.R = .003;                   %radius of the marble
b.C = 1.6e6;                  %volumetric heat capacity of marble
b.h = 150;                    %heat transfer coefficient
b.k = 1.5;                    %thermal conductivity of glass
slide_min = .15;              %min h value on slider (to change Bi)
slide_max = 1500;             %max h value on slider (to change Bi)
b.terms = 30;                 %number of terms in the full solution sum 

%% LC solution
b.biotLC = b.h*b.R/(3*b.k);        %LC Biot number
b.tau = b.C*b.R/(3*b.h);
b.t = 0:b.tau/100:b.tau*10;   
b.T_LC = (b.Ti - b.Tinf)*exp(-b.t/b.tau) + b.Tinf;
    
%% full solution
hfull = b.h;
b.alpha = b.k/b.C;                 %thermal diffusivity
b.T_full = full_soln(b,b.t,hfull);

%% plot
%define axes properties
b.fig = figure('Units','inches','Position',[5 .25 8 8.3],...
    'Name','LCvFull','NumberTitle','off');
b.ax1 = axes('Units','inches','Position',[1 5 6 3],'FontSize',12,...
    'LineWidth',1.5,'XLim', [0 b.t(end)],'YLim',[250 505],'Box','on');
hold on
b.ax1.XLabel.String = 'time [sec]';
b.ax1.YLabel.String = 'center temperature [K]';
b.ax2 = axes('Units','inches','Position',[1 1.3 6 3],'FontSize',12,...
    'LineWidth',1.5,'XLim', [0 b.t(end)],'Box','on');
hold on
b.ax2.XLabel.String = 'time [sec]';
b.ax2.YLabel.String = '%error = ({\itT}_L_C - {\itT}_f_u_l_l)/({\itT}_i - {\itT}_\infty)';

%plot LC soln and full soln vs time
b.h_LC = plot(b.ax1,b.t,b.T_LC,'Color',[0 113/255 188/255],...
    'LineWidth',1.5);
b.h_full = plot(b.ax1,b.t,b.T_full,'Color',[0 0 0],...
    'LineWidth',1.5);
b.leg = legend(b.ax1,{'lumped capactitance, {\itT}_L_C',...
    'full solution, {\itT}_f_u_l_l'},...
    'Location','NorthEast','Box','off','FontSize',12);

%plot percent difference with time
b.perc_diff = 100*(b.T_LC - b.T_full)./(b.Ti - b.Tinf);
b.h_PD = plot(b.ax2,b.t,b.perc_diff,'Color',[0 0 0],...
    'LineWidth',1.5);

%add UI to control heat transfer coefficient
b.txtbox = annotation('textbox','Units','inches','Position',...
    [3.5 .1 4 .3],'String',...
    [ 'Bi_L_C = ' num2str(b.biotLC)],'FontSize',12,'LineStyle','none');
b.sl = uicontrol('Parent',b.fig,'Style','slide','Units','inches',...
    'Position',[1.5 .5 5 .2],'Min',slide_min,'Max',slide_max,'Value',...
    b.h,'SliderStep',[1/100 1/20],'Callback',{@slider_call,b},...
    'BackgroundColor',b.fig.Color);

set(findall(b.fig,'-property','FontUnits'),'FontUnits','normalized')
set(findall(b.fig,'-property','Units'),'Units','normalized')

end

%% callback function
function [] = slider_call(varargin)
%callback for the slider
[H,b] = varargin{[1,3]};
slider_value = H.Value;

%calculate new quantities
biotLC = slider_value*b.R/(3*b.k);
taunew = b.C*b.R/(3*slider_value);
timenew = 0:taunew/100:taunew*10;   

%calculate new LC and full soln temperatures
new_LC = (b.Ti - b.Tinf)*exp(-timenew/taunew) + b.Tinf;
new_full = full_soln(b,timenew,slider_value);
new_pd = 100*(new_LC - new_full)./(b.Ti - b.Tinf);

%update plot and indicators
set(b.h_LC,'ydata',new_LC,'xdata',timenew);
set(b.h_full,'ydata',new_full,'xdata',timenew);
set(b.h_PD,'ydata',new_pd,'xdata',timenew);
set(b.ax1,'XLim',[0 timenew(end)]);
set(b.ax2,'XLim',[0 timenew(end)]);
set(b.txtbox,'String',['Bi_L_C = ' num2str(biotLC)])
end

%% full soln function
function [T_full] = full_soln(b,time,hfull)
%calculate full solution
b.biotfull = hfull*b.R/b.k;

%find roots of transcendental eqn
fun = @(zetan)1-(zetan*cot(zetan))-b.biotfull;
b.dum = .1:.1:b.terms;
b.yy = zeros(1,length(b.dum));
for ii = 1:length(b.dum)
    b.yy(ii) = fzero(fun,b.dum(ii));
end
b.zz = unique(b.yy);
b.zz = sort(b.zz);
b.z = round(1e9*b.zz)*1e-9; % Get rid of spurious differences
b.z = unique(b.z);
b.z(b.z<0) = [];
b.z(b.z>b.dum(end)) = [];
b.zetan = b.z(1:2:end);

%solve full solution for temperature 
b.Fo = b.alpha*time/(b.R^2);
b.theta = zeros(length(b.zetan),length(time));
for n = 1:length(b.zetan)
    Cn = 4*(sin(b.zetan(n)) - b.zetan(n)*cos(b.zetan(n)))/...
        (2*b.zetan(n) - sin(2*b.zetan(n)));
    b.theta(n,:) = Cn*exp(-(b.zetan(n)^2)*b.Fo);
end
b.THETA = sum(b.theta,1);
T_full = b.THETA*(b.Ti - b.Tinf) + b.Tinf;
end

