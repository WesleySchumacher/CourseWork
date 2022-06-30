function ss_1D_plane_wall
%built by keith regner 1/2017 with R2014b (8.4 OSX)
clear all
close all

%% description
% This demo solves the heat equation in a 1D, plane wall in the steady 
% state. The boundary condition on the right side of the wall is convection 
% with ambient fluid temperature T?,R and convection coefficient hR. The 
% boundary condition on the left side of the wall can be chosen with the 
% radio buttons. Options include constant surface temperature at Ts,L, 
% constant surface heat flux at q_s^'', and convection with ambient fluid 
% temperature T?,L and convection coefficient hL. Adjust all parameters 
% with the respective slider bar and observe the change in the spatial 
% temperature (left plot) and heat flux (right plot) profiles. Note that 
% the uniform volumetric heat generation q ? and the thermal conductivity of 
% the wall k can also be adjusted. Edit the slider bar limits in the m-file 
% to change the available range of parameters. Note that all initial values 
% must be within the range of the slider limits.
 
% NOTE: To simulate a constant surface temperature on the right hand 
% boundary, increase hR to infinity (>10000 W/m2-K).


%% parameters and slider bar limits
b.L = 0.075;                    %length of solid

b.k = 10;                       %k of solid, initial/slider limits
slidemink = 1;
slidemaxk = 301;

b.qdot = 0;                     %qdot in solid, initial/slider limits
slideminqdot = 0;
slidemaxqdot = 1e5;

b.T_infR = 275;                 %right side Tinf, initial/slider limits
slideminTinfR = 273;
slidemaxTinfR = 373;

b.hR = 10;                      %right side h, initial/slider limits
slideminhR = 0;
slidemaxhR = 10000;

b.TsL = 373;                    %left side surf temp, initial/slider limits
slideminTL = 273;
slidemaxTL = 373;

b.qs = 100;                     %left side surf flux, initial/slider limits
slideminflux = 0;
slidemaxflux = 150;

b.T_inf = 300;                  %left side Tinf, initial/slider limits
slideminconvT = 273;
slidemaxconvT = 373;

b.hL = 10;                      %left side h, initial/slider limits
slideminconvh = 0;
slidemaxconvh = 10000;

%% find solution
b.x = 0:b.L/100:b.L;
[b.TvX,b.qvX] = TvX(b,b.k,b.qdot,b.T_infR,b.hR,1,b.TsL,b.qs,b.hL,b.T_inf);

%% figure and axis formatting
b.fig = figure('Units','inches','Position',[3 .25 12 9],...
    'Name','ss_1D_plane_wall','NumberTitle','off');
b.ax1 = axes('Units','inches','Position',[1.1 .6 4.5 4],'FontSize',12,...
    'LineWidth',1.5,'Box','on','XLim',[0 b.L]);
hold on
b.ax1.XLabel.String = 'position [m]';
b.ax1.YLabel.String = 'temperature [K]';
b.ax2 = axes('Units','inches','Position',[6.7 .6 4.5 4],'FontSize',12,...
    'LineWidth',1.5,'Box','on','XLim',[0 b.L]);
hold on
b.ax2.XLabel.String = 'position [m]';
b.ax2.YLabel.String = 'heat flux [W/m^2]';

%% plot solution
b.h_TvX = plot(b.ax1,b.x,b.TvX,'Color',[0 0.44 0.74],...
    'LineWidth',1.5);
b.h_qvX = plot(b.ax2,b.x,b.qvX,'Color',[0 0.44 0.74],...
    'LineWidth',1.5);

%% add user control
%labels and border for radio buttons
b.txtboxr1 = annotation('textbox','Units','inches','Position',...
    [1.3 7.68 3.5 .3],'String',...
    'constant surface temperature, {\itT}_s_,_L',...
    'FontSize',12,'LineStyle','none');
b.txtboxr2 = annotation('textbox','Units','inches','Position',...
    [1.3 7.18 3.5 .3],'String',...
    'constant surface heat flux, {\itq}_s"',...
    'FontSize',12,'LineStyle','none');
b.txtboxr3 = annotation('textbox','Units','inches','Position',...
    [1.3 6.68 3.5 .3],'String',...
    'convection with {\ith}_L and {\itT}_\infty_,_L',...
    'FontSize',12,'LineStyle','none');
annotation('textbox','Units','inches','Position',...
    [.6 6.5 3.5 1.8]);
annotation('textbox','Units','inches','Position',...
    [.6 7.8 3.7 .8],'String', 'Left Side BC','LineStyle','none',...
    'FontSize',14);
annotation('textbox','Units','inches','Position',...
    [5.6 5.2 2.5 3],'BackgroundColor',[.6 .6 .6]);
annotation('arrow','Units','inches','Position',...
    [5.6 5.2 .3 0],'HeadStyle','vback2');
annotation('textbox','Units','inches','Position',...
    [5.8 4.85 .5 .3],'String','{\itx}','LineStyle','none','FontSize',12);

%surface flux BC illustrations and slider
b.fluxarrow1 = annotation('textarrow','Units','inches','Position',...
    [5.0 7.9 .6 0],'Visible','off');
b.fluxarrow2 = annotation('textarrow','Units','inches','Position',...
    [5.0 7.3 .6 0],'Visible','off');
b.fluxarrow3 = annotation('textarrow','Units','inches','Position',...
    [5.0 6.7 .6 0],'Visible','off');
b.fluxarrow4 = annotation('textarrow','Units','inches','Position',...
    [5.0 6.1 .6 0],'Visible','off');
b.fluxarrow5 = annotation('textarrow','Units','inches','Position',...
    [5.0 5.5 .6 0],'Visible','off');
b.txtboxflux = annotation('textbox','Units','inches','Position',...
    [4.5 3.85 2.5 3],'LineStyle','none','String','{\itq}_s"','FontSize',...
    14,'Visible','off');
b.txtboxfluxmin = annotation('textbox','Units','inches','Position',...
    [.8 5.9 .5 .3],'LineStyle','none','String',...
    num2str(slideminflux),'FontSize',14,'Visible','off');
b.txtboxfluxmax = annotation('textbox','Units','inches','Position',...
    [3.7 5.9 .5 .3],'LineStyle','none','String',...
    num2str(slidemaxflux),'FontSize',14,'Visible','off');
b.txtboxfluxlab = annotation('textbox','Units','inches','Position',...
    [1.5 2.95 2.5 3],'LineStyle','none','String',...
    ['{\itq}_s" = ' num2str(b.qs) ' [W/m^2]'],'FontSize',...
    14,'Visible','off');
b.slflux = uicontrol('Parent',b.fig,'Style','slide','Units','inches',...
    'Position',[1.1 6 2.5 .2],'Min',slideminflux,'Max',slidemaxflux,...
    'Value',b.qs,'SliderStep',[1/150 1/30],'Tag','sliderflux',...
    'UserData',struct('FLUX',b.qs),'Callback',{@slider_flux,b},...
    'BackgroundColor',b.fig.Color,'Visible','off');

%convection BC illustrations and slider bars
b.convarrow = annotation('textarrow','Units','inches','Position',...
    [5.0 5.6 0 1.5],'Visible','off');
b.txtboxconv = annotation('textbox','Units','inches','Position',...
    [4.55 2.48 2.5 3],'LineStyle','none','String',...
    '{\itT}_\infty_,_L, {\ith}_L','FontSize',14,'Visible','off');
b.txtboxconvhmin = annotation('textbox','Units','inches','Position',...
    [.8 5.9 .5 .3],'LineStyle','none','String',...
    num2str(slideminconvh),'FontSize',14,'Visible','off');
b.txtboxconvhmax = annotation('textbox','Units','inches','Position',...
    [3.7 5.9 .5 .3],'LineStyle','none','String',...
    num2str(slidemaxconvh),'FontSize',14,'Visible','off');
b.txtboxconvhlab = annotation('textbox','Units','inches','Position',...
    [1.5 2.95 2.5 3],'LineStyle','none','String',...
    ['{\ith}_L = ' num2str(b.hL) ' [W/m^2-K]'],'FontSize',...
    14,'Visible','off');
b.slconvh = uicontrol('Parent',b.fig,'Style','slide','Units','inches',...
    'Position',[1.1 6 2.5 .2],'Min',slideminconvh,'Max',slidemaxconvh,...
    'Value',b.hL,'SliderStep',[1/10000 1/200],'Tag','sliderconvh',...
    'UserData',struct('H',b.hL),'Callback',{@slider_convh,b},...
    'BackgroundColor',b.fig.Color,'Visible','off');

b.txtboxconvTmin = annotation('textbox','Units','inches','Position',...
    [.6 5.2 .5 .3],'LineStyle','none','String',...
    num2str(slideminconvT),'FontSize',14,'Visible','off');
b.txtboxconvTmax = annotation('textbox','Units','inches','Position',...
    [3.7 5.2 .5 .3],'LineStyle','none','String',...
    num2str(slidemaxconvT),'FontSize',14,'Visible','off');
b.txtboxconvTlab = annotation('textbox','Units','inches','Position',...
    [1.7 2.25 2.5 3],'LineStyle','none','String',...
    ['{\itT}_\infty_,_L  = ' num2str(b.T_inf) ' [K]'],'FontSize',...
    14,'Visible','off');
b.slconvT = uicontrol('Parent',b.fig,'Style','slide','Units','inches',...
    'Position',[1.1 5.3 2.5 .2],'Min',slideminconvT,'Max',slidemaxconvT,...
    'Value',b.T_inf,'SliderStep',[1/100 1/20],'Tag','sliderconvT',...
    'UserData',struct('TINF',b.T_inf),'Callback',{@slider_convT,b},...
    'BackgroundColor',b.fig.Color,'Visible','off');

%Left side constant surface temperature BC illustration and slider 
b.temparrowL = annotation('arrow','Units','inches','Position',...
    [5.05 7.9 .6 0],'HeadStyle','ellipse','HeadLength',7,...
    'HeadWidth',7);
b.txtboxtempL = annotation('textbox','Units','inches','Position',...
    [4.5 7.7 .5 .3],'LineStyle','none','String',...
    '{\itT}_s_,_L','FontSize',14);
b.txtboxTLmin = annotation('textbox','Units','inches','Position',...
    [.6 5.9 .5 .3],'LineStyle','none','String',...
    num2str(slideminTL),'FontSize',14);
b.txtboxTLmax = annotation('textbox','Units','inches','Position',...
    [3.7 5.9 .5 .3],'LineStyle','none','String',...
    num2str(slidemaxTL),'FontSize',14);
b.txtboxTLlab = annotation('textbox','Units','inches','Position',...
    [1.5 2.9 2.5 3],'LineStyle','none','String',...
    ['{\itT}_s_,_L = ' num2str(b.TsL) ' [K]'],'FontSize',...
    14);
b.slTL = uicontrol('Parent',b.fig,'Style','slide','Units','inches',...
    'Position',[1.1 6 2.5 .2],'Min',slideminTL,'Max',slidemaxTL,...
    'Value',b.TsL,'SliderStep',[1/100 1/20],'Tag','sliderTL','UserData',...
    struct('TSL',b.TsL),'Callback',{@slider_TL,b},...
    'BackgroundColor',b.fig.Color);

%Right side convection BC illustration and slider
b.temparrowR = annotation('arrow','Units','inches','Position',...
    [8.7 7.0 0 1.0]);
b.txtboxconvR = annotation('textbox','Units','inches','Position',...
    [8.75 7.9 1.5 .3],'LineStyle','none','String',...
    '{\itT}_\infty_,_R, {\ith}_R','FontSize',14);
b.txtboxtempR = annotation('textbox','Units','inches','Position',...
    [9.3 5.4 1.5 .3],'LineStyle','none','String',...
    ['{\itT}_\infty_,_R = ' num2str(b.T_infR) ' [K]'],'FontSize',14);
annotation('textbox','Units','inches','Position',...
    [8.5 5.7 .5 .3],'LineStyle','none','String',...
    num2str(slideminTinfR),'FontSize',14);
annotation('textbox','Units','inches','Position',...
    [11.05 5.7 .5 .3],'LineStyle','none','String',...
    num2str(slidemaxTinfR),'FontSize',14);
b.slTinfR = uicontrol('Parent',b.fig,'Style','slide','Units','inches',...
    'Position',[9.0 5.8 2.0 .2],'Min',slideminTinfR,'Max',slidemaxTinfR,...
    'Value',b.T_infR,'SliderStep',[1/100 1/20],'Tag','sliderTR',...
    'UserData',struct('K',b.k,'TINFR',b.T_infR,'QDOT',b.qdot,'HR',b.hR),...
    'Callback',{@slider_TR,b},'BackgroundColor',b.fig.Color);

b.txtboxhR = annotation('textbox','Units','inches','Position',...
    [9.15 6.1 2.35 .3],'LineStyle','none','String',...
    ['{\ith}_R = ' num2str(b.hR) ' [W/m^2-K]'],'FontSize',14);
annotation('textbox','Units','inches','Position',...
    [8.7 6.4 .5 .3],'LineStyle','none','String',...
    num2str(slideminhR),'FontSize',14);
annotation('textbox','Units','inches','Position',...
    [11.05 6.4 .5 .3],'LineStyle','none','String',...
    num2str(slidemaxhR),'FontSize',14);
b.slhR = uicontrol('Parent',b.fig,'Style','slide','Units','inches',...
    'Position',[9.0 6.5 2.0 .2],'Min',slideminhR,'Max',slidemaxhR,...
    'Value',b.hR,'SliderStep',[1/10000 1/200],'Tag','sliderhR',...
    'UserData',struct('K',b.k,'TINFR',b.T_infR,'QDOT',b.qdot,'HR',b.hR),...
    'Callback',{@slider_hR,b},'BackgroundColor',b.fig.Color);

%qdot slider bar
b.txtboxqdot = annotation('textbox','Units','inches','Position',...
    [6.1 6.2 2 .3],'LineStyle','none','String',...
    ['{\itq} = ' num2str(b.qdot) ' [W/m^3]'],'FontSize',14);
b.txtboxqdotdot = annotation('textbox','Units','inches','Position',...
    [6.17 6.28 .5 .3],'LineStyle','none','String',...
    '.','FontSize',14);
annotation('textbox','Units','inches','Position',...
    [5.9 6.47 .5 .3],'LineStyle','none','String',...
    num2str(slideminqdot),'FontSize',14);
annotation('textbox','Units','inches','Position',...
    [7.4 6.47 .5 .3],'LineStyle','none','String',...
    num2str(slidemaxqdot),'FontSize',14);
b.slqdot = uicontrol('Parent',b.fig,'Style','slide','Units','inches',...
    'Position',[6.2 6.57 1.2 .2],'Min',slideminqdot,'Max',slidemaxqdot,...
    'Value',b.qdot,'SliderStep',[1/100 1/20],'Tag','sliderqdot',...
    'UserData',struct('K',b.k,'TINFR',b.T_infR,'QDOT',b.qdot,'HR',b.hR),...
    'Callback',{@slider_qdot,b},'BackgroundColor',b.fig.Color);

%k slider bar
b.txtboxk = annotation('textbox','Units','inches','Position',...
    [6.1 7.2 1.5 .3],'LineStyle','none','String',...
    ['{\itk} = ' num2str(b.k) ' [W/m-K]'],'FontSize',14);
annotation('textbox','Units','inches','Position',...
    [5.9 7.47 .5 .3],'LineStyle','none','String',...
    num2str(slidemink),'FontSize',14);
annotation('textbox','Units','inches','Position',...
    [7.4 7.47 .5 .3],'LineStyle','none','String',...
    num2str(slidemaxk),'FontSize',14);
b.slk = uicontrol('Parent',b.fig,'Style','slide','Units','inches',...
    'Position',[6.2 7.57 1.2 .2],'Min',slidemink,'Max',slidemaxk,...
    'Value',b.k,'SliderStep',[1/300 1/20],'Tag','sliderk','UserData',...
    struct('K',b.k,'TINFR',b.T_infR,'QDOT',b.qdot,'HR',b.hR),...
    'Callback',{@slider_k,b},'BackgroundColor',b.fig.Color);

%radio buttons for BC selection
bg = uibuttongroup('Visible','off','Units','inches','Position',...
    [.7 6.65 .6 1.5],'SelectionChangedFcn',...
    {@bselection,b},'BorderType',...
    'none','UserData',struct('selection',1),'Tag','button');
r1 = uicontrol('Parent',bg,'Style','radiobutton','String','1.',...
    'Units','inches','Position',[.05 1.1 .5 .3],...
    'FontSize',12,'HandleVisibility','off');
r2 = uicontrol('Parent',bg,'Style','radiobutton','String','2.',...
    'Units','inches','Position',[.05 .6 .5 .3],...
    'FontSize',12,'HandleVisibility','off');
r3 = uicontrol('Parent',bg,'Style','radiobutton','String','3.',...
    'Units','inches','Position',[.05 .1 .5 .3],...
    'FontSize',12,'HandleVisibility','off');
bg.Visible = 'on';

set(findall(b.fig,'-property','FontUnits'),'FontUnits','normalized')
set(findall(b.fig,'-property','Units'),'Units','normalized')

end

%% change illustration when radio button selected
function bselection(varargin)
[H,b] = varargin{[1,3]};
if H.SelectedObject.String == '1.' %const surf temp
    data = struct('selection',1);
    H.UserData = data;
   
    h1 = findobj('Tag','sliderk');
    data1 = h1.UserData;
    h2 = findobj('Tag','sliderqdot');
    data2 = h2.UserData;
    h3 = findobj('Tag','sliderTR');
    data3 = h3.UserData;
    h4 = findobj('Tag','sliderhR');
    data4 = h4.UserData;
    h5 = findobj('Tag','sliderTL');
    data5 = h5.UserData;
    h6 = findobj('Tag','button');
    data6 = h6.UserData;
    radio = data6.selection;
    
    [Tnew,qnew] = TvX(b,data1.K,data2.QDOT,data3.TINFR,data4.HR,radio,...
        data5.TSL,b.qs,b.hL,b.T_inf);
    set(b.h_TvX,'YData',Tnew)
    set(b.h_qvX,'YData',qnew)
   
    set(b.temparrowL,'Visible','on');    
    set(b.txtboxtempL,'Visible','on');    
    set(b.slTL,'Visible','on');    
    set(b.txtboxTLmin,'Visible','on');    
    set(b.txtboxTLmax,'Visible','on');    
    set(b.txtboxTLlab,'Visible','on');    
    set(b.fluxarrow1,'Visible','off');    
    set(b.fluxarrow2,'Visible','off');    
    set(b.fluxarrow3,'Visible','off');    
    set(b.fluxarrow4,'Visible','off');    
    set(b.fluxarrow5,'Visible','off');    
    set(b.txtboxflux,'Visible','off');    
    set(b.slflux,'Visible','off');    
    set(b.txtboxfluxmin,'Visible','off');    
    set(b.txtboxfluxmax,'Visible','off');    
    set(b.txtboxfluxlab,'Visible','off');    
    set(b.convarrow,'Visible','off');    
    set(b.txtboxconv,'Visible','off');    
    set(b.slconvh,'Visible','off');    
    set(b.txtboxconvhmin,'Visible','off');    
    set(b.txtboxconvhmax,'Visible','off');    
    set(b.txtboxconvhlab,'Visible','off');    
    set(b.slconvT,'Visible','off');    
    set(b.txtboxconvTmin,'Visible','off');    
    set(b.txtboxconvTmax,'Visible','off');    
    set(b.txtboxconvTlab,'Visible','off');    
end

if H.SelectedObject.String == '2.' %const surf heat flux
    data = struct('selection',2);
    H.UserData = data;
    
    h1 = findobj('Tag','sliderk');
    data1 = h1.UserData;
    h2 = findobj('Tag','sliderqdot');
    data2 = h2.UserData;
    h3 = findobj('Tag','sliderTR');
    data3 = h3.UserData;
    h4 = findobj('Tag','sliderhR');
    data4 = h4.UserData;
    h5 = findobj('Tag','sliderflux');
    data5 = h5.UserData;
    h6 = findobj('Tag','button');
    data6 = h6.UserData;
    radio = data6.selection;
    
    [Tnew,qnew] = TvX(b,data1.K,data2.QDOT,data3.TINFR,data4.HR,...
        radio,b.TsL,data5.FLUX,b.hL,b.T_inf);
    set(b.h_TvX,'YData',Tnew) 
    set(b.h_qvX,'YData',qnew)

    set(b.temparrowL,'Visible','off');    
    set(b.txtboxtempL,'Visible','off');    
    set(b.slTL,'Visible','off');    
    set(b.txtboxTLmin,'Visible','off');    
    set(b.txtboxTLmax,'Visible','off');    
    set(b.txtboxTLlab,'Visible','off');    
    set(b.fluxarrow1,'Visible','on');    
    set(b.fluxarrow2,'Visible','on');    
    set(b.fluxarrow3,'Visible','on');    
    set(b.fluxarrow4,'Visible','on');    
    set(b.fluxarrow5,'Visible','on');    
    set(b.txtboxflux,'Visible','on');    
    set(b.slflux,'Visible','on');    
    set(b.txtboxfluxmin,'Visible','on');    
    set(b.txtboxfluxmax,'Visible','on');    
    set(b.txtboxfluxlab,'Visible','on');    
    set(b.convarrow,'Visible','off');    
    set(b.txtboxconv,'Visible','off');    
    set(b.slconvh,'Visible','off');    
    set(b.txtboxconvhmin,'Visible','off');    
    set(b.txtboxconvhmax,'Visible','off');    
    set(b.txtboxconvhlab,'Visible','off');    
    set(b.slconvT,'Visible','off');    
    set(b.txtboxconvTmin,'Visible','off');    
    set(b.txtboxconvTmax,'Visible','off');    
    set(b.txtboxconvTlab,'Visible','off');   
end

if H.SelectedObject.String == '3.' %surface convection
    data = struct('selection',3);
    H.UserData = data;
    
    h1 = findobj('Tag','sliderk');
    data1 = h1.UserData;
    h2 = findobj('Tag','sliderqdot');
    data2 = h2.UserData;
    h3 = findobj('Tag','sliderTR');
    data3 = h3.UserData;
    h4 = findobj('Tag','sliderhR');
    data4 = h4.UserData;
    h5 = findobj('Tag','sliderconvh');
    data5 = h5.UserData;
    h6 = findobj('Tag','sliderconvT');
    data6 = h6.UserData;
    h7 = findobj('Tag','button');
    data7 = h7.UserData;
    radio = data7.selection;
    
    [Tnew,qnew] = TvX(b,data1.K,data2.QDOT,data3.TINFR,data4.HR,...
        radio,b.TsL,b.qs,data5.H,data6.TINF);
    set(b.h_TvX,'YData',Tnew)
    set(b.h_qvX,'YData',qnew)
    
    set(b.temparrowL,'Visible','off');    
    set(b.txtboxtempL,'Visible','off');    
    set(b.slTL,'Visible','off');    
    set(b.txtboxTLmin,'Visible','off');    
    set(b.txtboxTLmax,'Visible','off');    
    set(b.txtboxTLlab,'Visible','off');    
    set(b.fluxarrow1,'Visible','off');    
    set(b.fluxarrow2,'Visible','off');    
    set(b.fluxarrow3,'Visible','off');    
    set(b.fluxarrow4,'Visible','off');    
    set(b.fluxarrow5,'Visible','off');    
    set(b.txtboxflux,'Visible','off');    
    set(b.slflux,'Visible','off');    
    set(b.txtboxfluxmin,'Visible','off');    
    set(b.txtboxfluxmax,'Visible','off');    
    set(b.txtboxfluxlab,'Visible','off');    
    set(b.convarrow,'Visible','on');    
    set(b.txtboxconv,'Visible','on');    
    set(b.slconvh,'Visible','on');    
    set(b.txtboxconvhmin,'Visible','on');    
    set(b.txtboxconvhmax,'Visible','on');    
    set(b.txtboxconvhlab,'Visible','on');    
    set(b.slconvT,'Visible','on');    
    set(b.txtboxconvTmin,'Visible','on');    
    set(b.txtboxconvTmax,'Visible','on');    
    set(b.txtboxconvTlab,'Visible','on');   
end
end

%% spatial temperature profile calculation
function [TvX,qvX] = TvX(b,val1,val2,val3a,val3b,radio,val4,val5,val6,val7)
% val1 = k
% val2 = qdot
% val3a = TINFR
% val3b = hR
% val4 = TsL
% val5 = qs
% val6 = h
% val7 = T_inf
if radio == 1; %const surface temp
    C2 = val4;
    C1 = (val2*b.L + ((val2*(b.L^2)*val3b)/(2*val1)) + val3a*val3b - ...
        C2*val3b)/(b.L*val3b + val1);
    
    TvX = (-val2*(b.x.^2)/(2*val1)) + C1*b.x + C2;  
    qvX = val2*b.x - C1*val1;
end
if radio == 2; %const surf heat flux
    C1 = -val5/val1;
    C2 = (val2*b.L + ((val2*(b.L^2)*val3b)/(2*val1)) + val3a*val3b - ...
        C1*(b.L*val3b + val1))/val3b;
   
    TvX = (-val2*(b.x.^2)/(2*val1)) + C1*b.x + C2;  
    qvX = val2*b.x - C1*val1;
end
if radio == 3; %surface convection
    C2 = (val2*b.L + ((val2*(b.L^2)*val3b)/(2*val1)) + val3a*val3b + ...
        (val6*(b.L*val3b + val1)*val7/val1))/(val3b + ...
        (val6*(b.L*val3b + val1)/val1));
    C1 = -val6*(val7 - C2)/val1;
    
    TvX = (-val2*(b.x.^2)/(2*val1)) + C1*b.x + C2;  
    qvX = val2*b.x - C1*val1;
end
end

%% slider bars for k, qdot, and right side surface temp
function [] = slider_k(varargin)    %k
[H,b] = varargin{[1,3]};
h1 = findobj('Tag','sliderqdot');
data1 = h1.UserData;
h2 = findobj('Tag','sliderTR');
data2 = h2.UserData;
h3 = findobj('Tag','sliderhR');
data3 = h3.UserData;
h4 = findobj('Tag','sliderTL');
data4 = h4.UserData;
h5 = findobj('Tag','sliderflux');
data5 = h5.UserData;
h6 = findobj('Tag','sliderconvh');
data6 = h6.UserData;
h7 = findobj('Tag','sliderconvT');
data7 = h7.UserData;
h8 = findobj('Tag','button');
data8 = h8.UserData;
radio = data8.selection;
slider_value = H.Value;
[Tnew,qnew] = TvX(b,slider_value,data1.QDOT,data2.TINFR,data3.HR,...
    radio,data4.TSL,data5.FLUX,data6.H,data7.TINF);
set(b.h_TvX,'YData',Tnew)
set(b.h_qvX,'YData',qnew)
set(b.txtboxk,'String',['{\itk} = ' num2str(slider_value) ' [W/m-K]']);
data = struct('K',slider_value,'TINFR',data2.TINFR,'QDOT',data1.QDOT,...
    'HR',data3.HR);
H.UserData = data;
end

function [] = slider_TR(varargin)      %right side Tinf
[H,b] = varargin{[1,3]};
h1 = findobj('Tag','sliderqdot');
data1 = h1.UserData;
h2 = findobj('Tag','sliderk');
data2 = h2.UserData;
h3 = findobj('Tag','sliderhR');
data3 = h3.UserData;
h4 = findobj('Tag','sliderTL');
data4 = h4.UserData;
h5 = findobj('Tag','sliderflux');
data5 = h5.UserData;
h6 = findobj('Tag','sliderconvh');
data6 = h6.UserData;
h7 = findobj('Tag','sliderconvT');
data7 = h7.UserData;
h8 = findobj('Tag','button');
data8 = h8.UserData;
radio = data8.selection;
slider_value = H.Value;
[Tnew,qnew] = TvX(b,data2.K,data1.QDOT,slider_value,data3.HR,radio,...
    data4.TSL,data5.FLUX,data6.H,data7.TINF);
set(b.h_TvX,'YData',Tnew)
set(b.h_qvX,'YData',qnew)
set(b.txtboxtempR,'String',...
    ['{\itT}_\infty_,_R = ' num2str(slider_value) ' [K]']);
data = struct('K',data2.K,'TINFR',slider_value,'QDOT',data2.QDOT,'HR',...
    data3.HR);
H.UserData = data;
end

function [] = slider_hR(varargin)      %right side h
[H,b] = varargin{[1,3]};
h1 = findobj('Tag','sliderqdot');
data1 = h1.UserData;
h2 = findobj('Tag','sliderk');
data2 = h2.UserData;
h3 = findobj('Tag','sliderTR');
data3 = h3.UserData;
h4 = findobj('Tag','sliderTL');
data4 = h4.UserData;
h5 = findobj('Tag','sliderflux');
data5 = h5.UserData;
h6 = findobj('Tag','sliderconvh');
data6 = h6.UserData;
h7 = findobj('Tag','sliderconvT');
data7 = h7.UserData;
h8 = findobj('Tag','button');
data8 = h8.UserData;
radio = data8.selection;
slider_value = H.Value;
[Tnew,qnew] = TvX(b,data2.K,data1.QDOT,data3.TINFR,slider_value,...
    radio,data4.TSL,data5.FLUX,data6.H,data7.TINF);
set(b.h_TvX,'YData',Tnew)
set(b.h_qvX,'YData',qnew)
set(b.txtboxhR,'String',...
    ['{\ith}_R = ' num2str(slider_value) ' [W/m^2-K]']);
data = struct('K',data2.K,'TINFR',slider_value,'QDOT',data2.QDOT,...
    'HR',slider_value);
H.UserData = data;
end

function [] = slider_qdot(varargin)     %qdot
[H,b] = varargin{[1,3]};
h1 = findobj('Tag','sliderTR');
data1 = h1.UserData;
h2 = findobj('Tag','sliderk');
data2 = h2.UserData;
h3 = findobj('Tag','sliderhR');
data3 = h3.UserData;
h4 = findobj('Tag','sliderTL');
data4 = h4.UserData;
h5 = findobj('Tag','sliderflux');
data5 = h5.UserData;
h6 = findobj('Tag','sliderconvh');
data6 = h6.UserData;
h7 = findobj('Tag','sliderconvT');
data7 = h7.UserData;
h8 = findobj('Tag','button');
data8 = h8.UserData;
radio = data8.selection;
slider_value = H.Value;
[Tnew,qnew] = TvX(b,data2.K,slider_value,data1.TINFR,data3.HR,...
    radio,data4.TSL,data5.FLUX,data6.H,data7.TINF);
set(b.h_TvX,'YData',Tnew)
set(b.h_qvX,'YData',qnew)
set(b.txtboxqdot,'String',['{\itq} = ' num2str(slider_value) ' [W/m^3]']);
data = struct('K',data1.K,'TINFR',data2.TINFR,'QDOT',slider_value,...
    'HR',data3.HR);
H.UserData = data;
end

%% left side boundary condition slider control
function [] = slider_TL(varargin)   %const surf temp
[H,b] = varargin{[1,3]};
h1 = findobj('Tag','sliderk');
data1 = h1.UserData;
h2 = findobj('Tag','sliderqdot');
data2 = h2.UserData;
h3 = findobj('Tag','sliderTR');
data3 = h3.UserData;
h4 = findobj('Tag','sliderhR');
data4 = h4.UserData;
h5 = findobj('Tag','button');
data5 = h5.UserData;
radio = data5.selection;
slider_value = H.Value;
[Tnew,qnew] = TvX(b,data1.K,data2.QDOT,data3.TINFR,data4.HR,...
    radio,slider_value,b.qs,b.hL,b.T_inf);
set(b.h_TvX,'YData',Tnew)
set(b.h_qvX,'YData',qnew)
set(b.txtboxTLlab,'String',...
    ['{\itT}_s_,_L = ' num2str(slider_value) ' [K]']);
data = struct('TSL',slider_value);
H.UserData = data;
end

function [] = slider_convh(varargin)    %convection (h)
[H,b] = varargin{[1,3]};
h1 = findobj('Tag','sliderk');
data1 = h1.UserData;
h2 = findobj('Tag','sliderqdot');
data2 = h2.UserData;
h3 = findobj('Tag','sliderTR');
data3 = h3.UserData;
h4 = findobj('Tag','sliderhR');
data4 = h4.UserData;
h5 = findobj('Tag','sliderconvT');
data5 = h5.UserData;
h6 = findobj('Tag','button');
data6 = h6.UserData;
radio = data6.selection;
slider_value = H.Value;
[Tnew,qnew] = TvX(b,data1.K,data2.QDOT,data3.TINFR,data4.HR,...
    radio,b.TsL,b.qs,slider_value,data5.TINF);
set(b.h_TvX,'YData',Tnew)
set(b.h_qvX,'YData',qnew)
set(b.txtboxconvhlab,'String',...
    ['{\ith}_L = ' num2str(slider_value) ' [W/m^2-K]']);
data = struct('H',slider_value);
H.UserData = data;
end

function [] = slider_convT(varargin)    %convection (T_inf)
[H,b] = varargin{[1,3]};
h1 = findobj('Tag','sliderk');
data1 = h1.UserData;
h2 = findobj('Tag','sliderqdot');
data2 = h2.UserData;
h3 = findobj('Tag','sliderTR');
data3 = h3.UserData;
h4 = findobj('Tag','sliderhR');
data4 = h4.UserData;
h5 = findobj('Tag','sliderconvh');
data5 = h5.UserData;
h6 = findobj('Tag','button');
data6 = h6.UserData;
radio = data6.selection;
slider_value = H.Value;
[Tnew,qnew] = TvX(b,data1.K,data2.QDOT,data3.TINFR,data4.HR,...
    radio,b.TsL,b.qs,data5.H,slider_value);
set(b.h_TvX,'YData',Tnew)
set(b.h_qvX,'YData',qnew)
set(b.txtboxconvTlab,'String',...
    ['{\itT}_\infty_,_L = ' num2str(slider_value) ' [K]']);
data = struct('TINF',slider_value);
H.UserData = data;
end

function [] = slider_flux(varargin)     %const surf heat flux
[H,b] = varargin{[1,3]};
h1 = findobj('Tag','sliderk');
data1 = h1.UserData;
h2 = findobj('Tag','sliderqdot');
data2 = h2.UserData;
h3 = findobj('Tag','sliderTR');
data3 = h3.UserData;
h4 = findobj('Tag','sliderhR');
data4 = h4.UserData;
h5 = findobj('Tag','button');
data5 = h5.UserData;
radio = data5.selection;
slider_value = H.Value;
[Tnew,qnew] = TvX(b,data1.K,data2.QDOT,data3.TINFR,data4.HR,...
    radio,b.TsL,slider_value,b.hL,b.T_inf);
set(b.h_TvX,'YData',Tnew)
set(b.h_qvX,'YData',qnew)
set(b.txtboxfluxlab,'String',...
    ['{\itq}_s" = ' num2str(slider_value) ' [W/m^2]']);
data = struct('FLUX',slider_value);
H.UserData = data;
end


