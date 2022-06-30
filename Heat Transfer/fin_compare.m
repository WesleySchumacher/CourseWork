function fin_compare
%built by keith regner 2/2017 with R2014b (8.4, OSX)
clear all
close all

%% description
% This demo compares the spatial temperature profile in a fin for four 
% tip boundary conditions [tip convection (TC), adiabatic tip (A), fixed 
% tip temperature at the ambient temperature T? (FT), and an infinite fin 
% (IF)]. The analysis assumes steady state, 1-D conduction in the fin, 
% constant properties, and no radiation or volumetric heat generation. 
% Adjust the thermal conductivity of the fin k, the convection coefficient 
% h, the ambient temperature T?, and the ratio of the cross-sectional 
% perimeter Pc and cross-sectional area Ac using the slider bars. The 
% spatial temperature profiles for each tip boundary condition are shown 
% in the top plot. The total heat dissipated by each fin and the fin 
% effectiveness are calculated and shown visually in the lower plots. 
% Note that the use of fins is justified if the effectiveness is above ~2. 
% Edit the slider bar limits in the m-file to change the available range of 
% parameters. Note that all initial values must be within the range of the 
% slider limits.

%% parameters and slider bar limits
b.h = 150;
slide_maxh = 1001;
slide_minh = 1;

b.T_inf = 200;
slide_maxTinf = 400;
slide_minTinf = 200;

b.k = 10;
slide_maxk = 301;
slide_mink = 1;

%% base temp and length of fin
b.Tb = 300;

%% create cross section 
slide_minpcac = .1;
slide_maxpcac = 1;
b.a = 1;
b.Pc_Ac = [(2*sqrt(2*(b.a^2) - 2*b.a +1)/b.a) (4*b.a)];
[xstar,ystar] = star(b.a);

%% spatial temperature profile
b.L = .17;
b.x = 0:b.L/100:b.L;
[b.T1,b.T2,b.T3,b.T4,b.q1,b.q2,b.q3,b.q4,...
    b.e1,b.e2,b.e3,b.e4] = fintemp(b,b.h,b.T_inf,b.k,b.Pc_Ac);

%% figure and axis formatting
b.fig = figure('Units','inches','Position',[5 .25 8 8.3],...
    'Name','fin_compare','NumberTitle','off');
b.ax1 = axes('Units','inches','Position',[6.5 6.8 1 1],'FontSize',12,...
    'LineWidth',1.5,'XLim', [-1 1],'YLim',[-1 1],'Box','on','Visible',...
    'off');
axis equal
hold on
b.ax2 = axes('Units','inches','Position',[1 2.8 6 3],'FontSize',12,...
    'LineWidth',1.5,'XLim', [0 b.L],'YLim', [200 400],'Box','on');
hold on
b.ax2.XLabel.String = 'position [m]';
b.ax2.YLabel.String = 'temperature [K]';

b.ax3 = axes('Units','inches','Position',[.8 .4 2.8 1.8],'FontSize',12,...
    'LineWidth',1.5,'XLim',[0 5],'Box','on','XTick',[1 2 3 4],...
    'XTickLabel',{'TC' 'A' 'FT' 'IF'});
hold on
b.ax3.YLabel.String = 'heat dissipated {\itq}_f [W]';

b.ax4 = axes('Units','inches','Position',[4.4 .4 2.8 1.8],'FontSize',12,...
    'LineWidth',1.5,'XLim', [0 5],'Box','on','XTick',[1 2 3 4],...
    'XTickLabel',{'TC' 'A' 'FT' 'IF'},'YLim',[-.1 20]);
hold on
b.ax4.YLabel.String = 'fin effectiveness \epsilon_f';

%% plot solution
b.h_star = plot(b.ax1,xstar,ystar,'Color',[0 0.44 0.74],...
    'LineWidth',1.5);
b.h_temp1 = plot(b.ax2,b.x,b.T1,'Color',[1 0 0],...
    'LineWidth',1.5);
b.h_temp2 = plot(b.ax2,b.x,b.T2,'Color',[0 0 0],...
    'LineWidth',1.5);
b.h_temp3 = plot(b.ax2,b.x,b.T3,'Color',[0 0 1],...
    'LineWidth',1.5);
b.h_temp4 = plot(b.ax2,b.x,b.T4,'Color',[0 1 0],...
    'LineWidth',1.5);
b.leg = legend(b.ax2,{'tip convection (TC)','adiabatic (A)',...
    'fixed temperature @ {\itT}_\infty (FT)','infinite fin (IF)'},...
    'Location','NorthWest','Box','off','FontSize',12);
plot(b.ax3,[-10 10],[0 0],'LineWidth',0.5,'LineStyle','--','Color',[0 0 0])
b.h_q1 = plot(b.ax3,[1 1],[0 b.q1],'Color',[1 0 0],...
    'LineWidth',5);
b.h_q2 = plot(b.ax3,[2 2],[0 b.q2],'Color',[0 0 0],...
    'LineWidth',5);
b.h_q3 = plot(b.ax3,[3 3],[0 b.q3],'Color',[0 0 1],...
    'LineWidth',5);
b.h_q4 = plot(b.ax3,[4 4],[0 b.q4],'Color',[0 1 0],...
    'LineWidth',5);
plot(b.ax4,[-10 10],[2 2],'LineWidth',0.5,'LineStyle','--','Color',[0 0 0])
b.h_e1 = plot(b.ax4,[1 1],[0 b.e1],'Color',[1 0 0],...
    'LineWidth',5);
b.h_e2 = plot(b.ax4,[2 2],[0 b.e2],'Color',[0 0 0],...
    'LineWidth',5);
b.h_e3 = plot(b.ax4,[3 3],[0 b.e3],'Color',[0 0 1],...
    'LineWidth',5);
b.h_e4 = plot(b.ax4,[4 4],[0 b.e4],'Color',[0 1 0],...
    'LineWidth',5);

%% schematic
annotation('textbox','Units','inches','Position',...
    [2.9 7.05 3 .5],'BackgroundColor',[.6 .6 .6]);
annotation('textbox','Units','inches','Position',...
    [2.6 6.67 .3 1.2],'BackgroundColor',[.6 .6 .6]);
annotation('arrow','Units','inches','Position',...
    [2.9 7.05 .3 0],'HeadStyle','vback2');
annotation('textbox','Units','inches','Position',...
    [3.1 6.7 .5 .3],'String','{\itx}','LineStyle','none','FontSize',12);
annotation('textbox','Units','inches','Position',...
    [6.45 7.8 1 .3],'String','cross-section','LineStyle','none',...
    'FontSize',12);
annotation('textbox','Units','inches','Position',...
    [4.4 6.6 1 .3],'String','{\ith}, {\itT}_\infty','LineStyle','none',...
    'FontSize',12);
annotation('arrow','Units','inches','Position',...
    [3.8 6.5 .6 .4],'HeadStyle','vback2');
annotation('line','Units','inches','Position',...
    [2.9 7.4 .6 .4]);
annotation('textbox','Units','inches','Position',...
    [3.45 7.6 1 .3],'String',['{\itT}_b = ' num2str(b.Tb) ' K'],...
    'LineStyle','none','FontSize',12);
annotation('textbox','Units','inches','Position',...
    [4.2 7.07 1 .3],'String','{\itk}','LineStyle','none',...
    'FontSize',12);

%% add user control
%perimeter/area
b.txtbox_pcac = annotation('textbox','Units','inches','Position',...
    [6.4 6.1 4 .3],'String',...
    ['{\itP}_c/{\itA}_c = ' num2str(round(b.Pc_Ac(1),2)) ' [m^-^1]'],...
    'FontSize',12,'LineStyle','none');
b.slpcac = uicontrol('Parent',b.fig,'Style','slide','Units','inches',...
    'Position',[6.3 6.45 1.45 .2],'Min',slide_minpcac,'Max',...
    slide_maxpcac,'Value',b.a,'SliderStep',[1/100 1/20],...
    'Tag','sliderpcac','UserData',struct('PCAC',b.Pc_Ac,'H',b.h,...
    'TINF',b.T_inf,'K',b.k),...
    'Callback',{@slider_pcac,b},'BackgroundColor',b.fig.Color);

%h
b.txtbox_h = annotation('textbox','Units','inches','Position',...
    [.7 6.1 4 .3],'String',...
    ['{\ith} = ' num2str(b.h) ' [W/m^2-K]'],'FontSize',12,...
    'LineStyle','none');
b.slh = uicontrol('Parent',b.fig,'Style','slide','Units','inches',...
    'Position',[.3 6.45 2 .2],'Min',slide_minh,'Max',slide_maxh,...
    'Value',b.h,'SliderStep',[1/1000 1/20],...
    'Tag','sliderh','UserData',struct('PCAC',b.Pc_Ac,'H',b.h,...
    'TINF',b.T_inf,'K',b.k),...
    'Callback',{@slider_h,b},'BackgroundColor',b.fig.Color);

%T_inf
b.txtbox_Tinf = annotation('textbox','Units','inches','Position',...
    [.7 6.7 4 .3],'String',...
    ['{\itT}_\infty = ' num2str(b.T_inf) ' [K]'],'FontSize',12,...
    'LineStyle','none');
b.slTinf = uicontrol('Parent',b.fig,'Style','slide','Units','inches',...
    'Position',[.3 7.05 2 .2],'Min',slide_minTinf,'Max',...
    slide_maxTinf,'Value',b.T_inf,'SliderStep',[1/200 1/20],...
    'Tag','sliderTinf','UserData',struct('PCAC',b.Pc_Ac,'H',b.h,...
    'TINF',b.T_inf,'K',b.k),...
    'Callback',{@slider_Tinf,b},'BackgroundColor',b.fig.Color);

%k
b.txtbox_k = annotation('textbox','Units','inches','Position',...
    [.7 7.3 4 .3],'String',...
    ['{\itk} = ' num2str(b.k) ' [W/m-K]'],'FontSize',12,...
    'LineStyle','none');
b.slk = uicontrol('Parent',b.fig,'Style','slide','Units','inches',...
    'Position',[.3 7.7 2 .2],'Min',slide_mink,'Max',slide_maxk,...
    'Value',b.k,'SliderStep',[1/300 1/20],...
    'Tag','sliderk','UserData',struct('PCAC',b.Pc_Ac,'H',b.h,...
    'TINF',b.T_inf,'K',b.k),...
    'Callback',{@slider_k,b},'BackgroundColor',b.fig.Color);

set(findall(b.fig,'-property','FontUnits'),'FontUnits','normalized')
set(findall(b.fig,'-property','Units'),'Units','normalized')

end

%% callback functions
%star
function [] = slider_pcac(varargin)
%callback for the slider
[H,b] = varargin{[1,3]};

h1 = findobj('Tag','sliderh');
data1 = h1.UserData;
h2 = findobj('Tag','sliderTinf');
data2 = h2.UserData;
h3 = findobj('Tag','sliderk');
data3 = h3.UserData;

slider_value = H.Value;
%calculate new star
[x,y] = star(slider_value);
Pc_Ac = [(2*sqrt(2*(slider_value^2) - 2*slider_value + 1)/slider_value)...
    (4*(slider_value^2))];
%calculate new temperature
[T1,T2,T3,T4,q1,q2,q3,q4,...
    e1,e2,e3,e4] = fintemp(b,data1.H,data2.TINF,data3.K,Pc_Ac);
%update plot and indicators
set(b.h_star,'ydata',y,'xdata',x);
set(b.h_temp1,'ydata',T1);
set(b.h_temp2,'ydata',T2);
set(b.h_temp3,'ydata',T3);
set(b.h_temp4,'ydata',T4);
set(b.h_q1,'ydata',[0 q1]);
set(b.h_q2,'ydata',[0 q2]);
set(b.h_q3,'ydata',[0 q3]);
set(b.h_q4,'ydata',[0 q4]);
set(b.h_e1,'ydata',[0 e1]);
set(b.h_e2,'ydata',[0 e2]);
set(b.h_e3,'ydata',[0 e3]);
set(b.h_e4,'ydata',[0 e4]);
set(b.txtbox_pcac,'String',...
    ['{\itP}_c/{\itA}_c = ' num2str(round(Pc_Ac(1),2)) ' [m^-^1]'])
data = struct('PCAC',Pc_Ac,'H',data1.H,'TINF',data2.TINF,...
    'K',data3.K);
H.UserData = data;
end

%h
function [] = slider_h(varargin)
%callback for the slider
[H,b] = varargin{[1,3]};

h1 = findobj('Tag','sliderpcac');
data1 = h1.UserData;
h2 = findobj('Tag','sliderTinf');
data2 = h2.UserData;
h3 = findobj('Tag','sliderk');
data3 = h3.UserData;

slider_value = H.Value;
%calculate new temperature
[T1,T2,T3,T4,q1,q2,q3,q4,...
    e1,e2,e3,e4] = fintemp(b,slider_value,data2.TINF,data3.K,data1.PCAC);

%update plot and indicators
set(b.h_temp1,'ydata',T1);
set(b.h_temp2,'ydata',T2);
set(b.h_temp3,'ydata',T3);
set(b.h_temp4,'ydata',T4);
set(b.h_q1,'ydata',[0 q1]);
set(b.h_q2,'ydata',[0 q2]);
set(b.h_q3,'ydata',[0 q3]);
set(b.h_q4,'ydata',[0 q4]);
set(b.h_e1,'ydata',[0 e1]);
set(b.h_e2,'ydata',[0 e2]);
set(b.h_e3,'ydata',[0 e3]);
set(b.h_e4,'ydata',[0 e4]);
set(b.txtbox_h,'String',...
    ['{\ith} = ' num2str(round(slider_value,0)) ' [W/m^2-K]'])
data = struct('PCAC',data1.PCAC,'H',slider_value,'TINF',data2.TINF,...
    'K',data3.K);
H.UserData = data;
end

%Tinf
function [] = slider_Tinf(varargin)
%callback for the slider
[H,b] = varargin{[1,3]};

h1 = findobj('Tag','sliderpcac');
data1 = h1.UserData;
h2 = findobj('Tag','sliderh');
data2 = h2.UserData;
h3 = findobj('Tag','sliderk');
data3 = h3.UserData;

slider_value = H.Value;
%calculate new temperature
[T1,T2,T3,T4,q1,q2,q3,q4,...
    e1,e2,e3,e4] = fintemp(b,data2.H,slider_value,data3.K,data1.PCAC);

%update plot and indicators
set(b.h_temp1,'ydata',T1);
set(b.h_temp2,'ydata',T2);
set(b.h_temp3,'ydata',T3);
set(b.h_temp4,'ydata',T4);
set(b.h_q1,'ydata',[0 q1]);
set(b.h_q2,'ydata',[0 q2]);
set(b.h_q3,'ydata',[0 q3]);
set(b.h_q4,'ydata',[0 q4]);
set(b.h_e1,'ydata',[0 e1]);
set(b.h_e2,'ydata',[0 e2]);
set(b.h_e3,'ydata',[0 e3]);
set(b.h_e4,'ydata',[0 e4]);
set(b.txtbox_Tinf,'String',...
    ['{\itT}_\infty = ' num2str(round(slider_value,0)) ' [K]'])
data = struct('PCAC',data1.PCAC,'H',data2.H,'TINF',slider_value,...
    'K',data3.K);
H.UserData = data;
end

%k
function [] = slider_k(varargin)
%callback for the slider
[H,b] = varargin{[1,3]};

h1 = findobj('Tag','sliderpcac');
data1 = h1.UserData;
h2 = findobj('Tag','sliderh');
data2 = h2.UserData;
h3 = findobj('Tag','sliderTinf');
data3 = h3.UserData;

slider_value = H.Value;
%calculate new temperature
[T1,T2,T3,T4,q1,q2,q3,q4,...
    e1,e2,e3,e4] = fintemp(b,data2.H,data3.TINF,slider_value,data1.PCAC);

%update plot and indicators
set(b.h_temp1,'ydata',T1);
set(b.h_temp2,'ydata',T2);
set(b.h_temp3,'ydata',T3);
set(b.h_temp4,'ydata',T4);
set(b.h_q1,'ydata',[0 q1]);
set(b.h_q2,'ydata',[0 q2]);
set(b.h_q3,'ydata',[0 q3]);
set(b.h_q4,'ydata',[0 q4]);
set(b.h_e1,'ydata',[0 e1]);
set(b.h_e2,'ydata',[0 e2]);
set(b.h_e3,'ydata',[0 e3]);
set(b.h_e4,'ydata',[0 e4]);
set(b.txtbox_k,'String',...
    ['{\itk} = ' num2str(round(slider_value,0)) ' [W/m-K]'])
data = struct('PCAC',data1.PCAC,'H',data2.H,'TINF',data3.TINF,...
    'K',slider_value);
H.UserData = data;
end

function [x,y] = star(a)
x1 = [1 a 0];
y1 = [0 a 1];
x2 = [0 -a -1];
y2 = [1 a 0];
x3 = [-1 -a 0];
y3 = [0 -a -1];
x4 = [0 a 1];
y4 = [-1 -a 0];
x = [x1,x2,x3,x4];
y = [y1,y2,y3,y4];
end

function [T1,T2,T3,T4,q1,q2,q3,q4,e1,e2,e3,e4] = fintemp(b,h,T_inf,k,Pc_Ac)
m = sqrt(h*Pc_Ac(1)/k);
THb = b.Tb - T_inf;
M  = sqrt(h*k*Pc_Ac(1)*(Pc_Ac(2)^2))*THb;

%convection
T1 = (THb*(cosh(m*(b.L - b.x)) + (h/(m*k))*sinh(m*(b.L - b.x)))./...
    (cosh(m*b.L) + (h/(m*k))*sinh(m*b.L))) + T_inf;
q1t = (sinh(m*b.L) + (h/(m*b.L))*cosh(m*b.L))/...
    (cosh(m*b.L) + (h/(m*b.L))*sinh(m*b.L));
e1 = q1t*sqrt(k*Pc_Ac(1)/h);
q1 = M*q1t;
%adiabatic
T2 = (THb*cosh(m*(b.L - b.x))/cosh(m*b.L)) + T_inf;
q2t = tanh(m*b.L);
e2 = q2t*sqrt(k*Pc_Ac(1)/h);
q2 = M*q2t;
%fixed temp @ T_inf
T3 = (THb*sinh(m*(b.L - b.x))/sinh(m*b.L)) + T_inf;
q3t = (cosh(m*b.L))/sinh(m*b.L);
e3 = q3t*sqrt(k*Pc_Ac(1)/h);
q3 = M*q3t;
%infinite
T4 = (THb*exp(-m*b.x)) + T_inf;
q4t = 1;
e4 = q4t*sqrt(k*Pc_Ac(1)/h);
q4 = M*q4t;
end
