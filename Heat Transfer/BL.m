function BL
%built by keith regner 2/2017 with R2014b (8.4 OSX)
clear,close all

%% description
% This demo shows laminar flow over an isothermal, flat plate where the 
% plate temperature Ts is greater than the free stream fluid temperature 
% T?. The user has the ability to study hydrodynamic effects or thermal 
% effects by selecting the radio button in the top right corner of the 
% window. When ?velocity? is selected, the velocity boundary layer 
% thickness ? is highlighted and plotted with normalized position along 
% the length of the plate x/xcrit. Here, xcrit is the critical location 
% for transition from laminar flow to turbulent flow. Additionally, the 
% velocity profile inside the boundary layer (x-component of velocity u 
% with height above the plate y) is highlighted and plotted at the position 
% of the slider bar. The slope of the velocity profile at the surface of 
% the plate ?u/?y|_(y=0) as a function of x/xcrit is highlighted and 
% plotted in the lower left plot. The nondimensional quantity local 
% coefficient of friction Cf,x as a function of x/xcrit is highlighted and 
% plotted in the lower middle plot. The lower right plot shows the local 
% convection coefficient as a function of position for a specific fluid and 
% flow velocity.
% 
% When ?temperature? is selected, the thermal boundary layer thickness ?t 
% is highlighted and plotted with x/xcrit. The temperature profile inside 
% the boundary layer (fluid temperature T with height above the plate y) is 
% highlighted and plotted at the position of the slider bar. The slope of 
% the temperature profile at the surface of the plate ?T/?y|_(y=0) as a 
% function of x/xcrit is highlighted and plotted in the lower left plot. 
% The nondimensional quantity local Nusselt number Nux as a function of 
% x/xcrit is highlighted and plotted in the lower middle plot. The local 
% convection coefficient hx as a function of x/xcrit is shown in the lower 
% right plot (solid black line) for a specific fluid. The average 
% convection coefficient between the leading edge and the position of the 
% slider bar h_bar_(0-x) is related to the integral of hx and is indicated
% in the plot window.
% 
% Change the Prandtl number Pr of the fluid with the drop down menu and 
% observe how it affects ?t, ?T/?y|_(y=0), Nux, hx, and h_bar_(0-x).

%% parameters
b.U_inf = 1;
b.delT = 1;     % Ts - T_inf
b.kf = .0263;
b.nu = 15.89e-6;
b.Lcrit = (5e5)*b.nu/b.U_inf;
b.x = 0:b.Lcrit/10000:b.Lcrit*1.26;
b.x_pos = 5;
b.Rex = b.U_inf*b.x/b.nu;

%% calculate boundary layer and velocity/temp profiles
[b.eta,b.f,b.df_deta,b.d2f_deta2,b.TH,b.dTH_deta] = V_TH_BL;
b.delta = b.eta(4921)*sqrt(b.nu*b.x/b.U_inf);
b.vprofx = b.U_inf*b.df_deta + b.x_pos;
b.vprofy = b.eta*sqrt(b.nu*b.x_pos/b.U_inf);
b.du_dy_0 = b.d2f_deta2(1)*b.U_inf*sqrt(b.U_inf./(b.nu*b.x));
b.Cf_x = 2*b.nu*b.du_dy_0/(b.U_inf*b.U_inf);

b.deltaT = b.eta(3267)*sqrt(b.nu*b.x/b.U_inf);
b.Tprofx = -b.TH + 1 + b.x_pos;
b.Tprofy = b.eta*sqrt(b.nu*b.x_pos/b.U_inf);
b.dT_dy_0 = -b.dTH_deta(:,1)*sqrt(b.U_inf./(b.nu*b.x));
b.Nu_x = -[b.x;b.x;b.x].*b.dT_dy_0/b.delT;
b.h_x = -b.dT_dy_0*b.kf/b.delT;
b.h_avg = 0.664*b.kf*(3^(1/3))*sqrt(b.U_inf/b.nu)/sqrt(b.x_pos);
b.h_local = b.h_x(3,round(12600*b.x_pos/10));

%% figure and axis formatting
b.fig = figure('Units','inches','Position',[.5 .5 16 8],...
    'Name','BL','NumberTitle','off');
b.ax1 = axes('Units','inches','Position',[1 5.5 14 2],'FontSize',12,...
    'LineWidth',1.5,'XLim', [0 12.4],'YLim',[0 1.25*b.delta(end)],...
    'Box','on','Visible','off');
hold on
b.ax1.XLabel.String = '{\itx}/{\itx}_c_r_i_t';
b.ax1.YLabel.String = '{\ity} [m]';

%slope axes
b.ax2 = axes('Units','inches','Position',[1 1.3 3.5 3],'FontSize',12,...
    'LineWidth',1.5,'Box','off','XLim',[0 10],'YLim',[0 200],'YColor',...
    [0 .75 .75],'XTick',[0 2 4 6 8 10],'XTickLabel',...
    {'0','0.2','0.4','0.6','0.8','1.0'});
hold on
b.ax2.XLabel.String = '{\itx}/{\itx}_c_r_i_t or {\itRe}_x/{\itRe}_x_,_c_r_i_t';
b.ax2.YLabel.String = '\partial{\itu}/\partial{\ity} @ {\ity} = 0 [m/s/m]';

b.ax3 = axes('Units','inches','Position',[1 1.3 3.5 3],'FontSize',12,...
    'LineWidth',1.5,'Box','off','XLim',[0 10],'YLim',[-300 0],...
    'XAxisLocation','top','YAxisLocation','right','Color','none',...
    'XTickLabel','','YColor',[.85 .85 .85]);
hold on
b.ax3.YLabel.String = '\partial{\itT}/\partial{\ity} @ {\ity} = 0 [K/m]';

%schematic axes
b.ax4 = axes('Units','inches','Position',[1 5.28 11.26 2],'FontSize',12,...
    'LineWidth',1.5,'XLim', [0 10],'YLim',[0 b.delta(end)],'Box','off',...
    'Color','none','YColor','none','TickDir','out','XTick',...
    [0 2 4 6 8 10],'XTickLabel',...
    {'0','0.2','0.4','0.6','0.8','1.0'});
b.ax4.XLabel.String = '{\itx}/{\itx}_c_r_i_t or {\itRe}_x/{\itRe}_x_,_c_r_i_t';

%Cf and Nu axes
b.ax5 = axes('Units','inches','Position',[6.1 1.3 3.5 3],'FontSize',12,...
    'LineWidth',1.5,'Box','off','XLim',[0 10],'YLim',[0 .01],'YColor',...
    [0 .75 .75],'XTick',[0 2 4 6 8 10],'XTickLabel',...
    {'0','0.2','0.4','0.6','0.8','1.0'});
hold on
b.ax5.XLabel.String = '{\itx}/{\itx}_c_r_i_t or {\itRe}_x/{\itRe}_x_,_c_r_i_t';
b.ax5.YLabel.String = '{\itC}_f_,_x';
b.ax6 = axes('Units','inches','Position',[6.1 1.3 3.5 3],'FontSize',12,...
    'LineWidth',1.5,'Box','off','XLim',[0 10],'YLim',[0 400],...
    'XAxisLocation','top','YAxisLocation','right','Color','none',...
    'XTickLabel','','YColor',[.85 .85 .85]);
hold on
b.ax6.YLabel.String = '{\itNu}_x';

%local h axes
b.ax7 = axes('Units','inches','Position',[11.2 1.3 3.5 3],'FontSize',12,...
    'LineWidth',1.5,'Box','on','XLim',[0 10],'YLim',[0 10],'XTick',...
    [0 2 4 6 8 10],'XTickLabel',...
    {'0','0.2','0.4','0.6','0.8','1.0'});
hold on
b.ax7.XLabel.String = '{\itx}/{\itx}_c_r_i_t or {\itRe}_x/{\itRe}_x_,_c_r_i_t';
b.ax7.YLabel.String = '{\ith}_x [W/m^2-K]';

%% plotting
%velocity boundary layer
b.h_vBl = plot(b.ax1,b.x,b.delta,'Color',[0 0.75 0.75],...
    'LineWidth',1.5);
%velocity profile
b.h_vprof = plot(b.ax1,b.vprofx,b.vprofy,'Color',[0 0.75 0.75],...
    'LineWidth',1.5);
%y=0 velocity slope
b.h_slope_zero = plot(b.ax1,[b.x_pos b.x_pos+1.2],...
    [0 (1.2)/b.du_dy_0(round(12600*b.x_pos/10))],'LineWidth',1,...
    'Color',[0 0 0]);

%velocity profile arrows
b.h_vel1 = plot(b.ax1,[b.x_pos b.vprofx(1000)],...
    [b.vprofy(1000) b.vprofy(1000)],'Color',[0 0 0]);
b.h_velar1 = plot(b.ax1,b.vprofx(1000),b.vprofy(1000),'Color',...
    [0 0 0],'Marker','>','MarkerFaceColor',[0 0 0]);
b.h_vel2 = plot(b.ax1,[b.x_pos b.vprofx(2000)],...
    [b.vprofy(2000) b.vprofy(2000)],'Color',[0 0 0]);
b.h_velar2 = plot(b.ax1,b.vprofx(2000),b.vprofy(2000),'Color',...
    [0 0 0],'Marker','>','MarkerFaceColor',[0 0 0]);
b.h_vel3 = plot(b.ax1,[b.x_pos b.vprofx(3000)],...
    [b.vprofy(3000) b.vprofy(3000)],'Color',[0 0 0]);
b.h_velar3 = plot(b.ax1,b.vprofx(3000),b.vprofy(3000),'Color',...
    [0 0 0],'Marker','>','MarkerFaceColor',[0 0 0]);
b.h_vel4 = plot(b.ax1,[b.x_pos b.vprofx(4000)],...
    [b.vprofy(4000) b.vprofy(4000)],'Color',[0 0 0]);
b.h_velar4 = plot(b.ax1,b.vprofx(4000),b.vprofy(4000),'Color',...
    [0 0 0],'Marker','>','MarkerFaceColor',[0 0 0]);
b.h_vel5 = plot(b.ax1,[b.x_pos b.vprofx(4921)],...
    [b.vprofy(4921) b.vprofy(4921)],'Color',[0 0 0]);
b.h_velar5 = plot(b.ax1,b.vprofx(4921),b.vprofy(4921),'Color',...
    [0 0 0],'Marker','>','MarkerFaceColor',[0 0 0]);

%thermal boundary layer
b.h_TBl = plot(b.ax1,b.x,b.deltaT,'Color',[.85 .85 .85],...
    'LineWidth',1.5);
%temperature profile
b.h_Tprof = plot(b.ax1,b.Tprofx(3,:),b.Tprofy,'Color',[.85 .85 .85],...
    'LineWidth',1.5);
%y=0 temperature slope
b.h_slope_zeroT = plot(b.ax1,[b.x_pos-.2 b.x_pos+1],...
    [-1.2/(b.dT_dy_0(3,round(12600*b.x_pos/10))) 0],'LineWidth',1,...
    'Color',[0 0 0],'Visible','off');

%y-axis
b.h_yax = plot(b.ax1,[b.x_pos b.x_pos],...
    [0 b.delta(end)],'LineWidth',1,...
    'Color',[0 0 0]);
b.h_yaxar = plot(b.ax1,b.x_pos,b.delta(end),'Marker','^',...
    'MarkerFaceColor',[0 0 0],'MarkerEdgeColor',[0 0 0]);

%plot slopes at y = 0
b.h_dudy0 = plot(b.ax2,b.x,b.du_dy_0,'Color',[0 .75 .75],'LineWidth',1.5);
b.h_dTdy0 = plot(b.ax3,b.x,b.dT_dy_0(3,:),'Color',[.85 .85 .85],...
    'LineWidth',1.5);
b.h_x_ind = plot(b.ax3,[b.x_pos b.x_pos],[-300 300],'LineWidth',1.5,...
    'Color',[0 0 0]);

%local Cf and Nu
b.h_Cf = plot(b.ax5,b.x,b.Cf_x,'Color',[0 .75 .75],'LineWidth',1.5);
b.h_Nu = plot(b.ax6,b.x,b.Nu_x(3,:),'Color',[.85 .85 .85],'LineWidth',1.5);
b.h_x_ind2 = plot(b.ax6,[b.x_pos b.x_pos],[-300 600],'LineWidth',1.5,...
    'Color',[0 0 0]);

%local h
b.xshade = b.x(1:round(12600*b.x_pos/10));
b.hshade = b.h_x(3,(1:length(b.xshade)));
b.shade = area(b.xshade,b.hshade,'FaceColor',[1 0 0],'EdgeColor',...
    'none','LineStyle','none');
b.h_hx = plot(b.ax7,b.x,b.h_x(3,:),'Color',[0 0 0],'LineWidth',1.5);
b.h_x_ind3 = plot(b.ax7,[b.x_pos b.x_pos],[-300 6],'LineWidth',1.5,...
    'Color',[0 0 0]);
b.txthavg = annotation('textbox','Units','inches','Position',...
    [11.25 3.8 3.5 .3],'String',...
    ['{\ith}_0_-_x = ' num2str(round(b.h_avg,2)) ' W/m^2-K'],...
    'LineStyle','none','FontSize',12);
b.txthlocal = annotation('textbox','Units','inches','Position',...
    [11.25 3.4 3.5 .3],'String',...
    ['{\ith}_x = ' num2str(round(b.h_local,2)) ' W/m^2-K'],...
    'LineStyle','none','FontSize',12);
annotation('line','Units','inches','Position',...
    [11.35 4.07 .1 0])

%correlations for Nu and Cf from the text
plot(b.ax5,b.x,0.664./sqrt(b.Rex),'Color',[0 0 0],'LineWidth',1,...
    'LineStyle','--');
plot(b.ax6,b.x,0.332*sqrt(b.Rex)*(3^(1/3)),'Color',[0 0 0],'LineWidth',...
    1,'LineStyle','--');

%% schematic
annotation('textbox','Units','inches','Position',[1.5 7.5 5 .3],...
    'String','Laminar flow over an isothermal, flat plate',...
    'LineStyle','none','FontSize',16);
annotation('textbox','Units','inches','Position',...
    [.35 .3 5 .3],'String',...
    'Fig. 1. Slope of velocity and temperature profiles at the surface.',...
    'LineStyle','none','FontSize',12);
annotation('textbox','Units','inches','Position',...
    [6.95 .3 5 .3],'String','Fig. 2. Local {\itC}_f and {\itNu}.',...
    'LineStyle','none','FontSize',12);
annotation('textbox','Units','inches','Position',...
    [11.9 .3 5 .3],'String','Fig.3. Local and average {\ith}.',...
    'LineStyle','none','FontSize',12);
annotation('arrow','Units','inches','Position',...
    [.5 7.05 .5 0],'HeadStyle','vback2');
annotation('arrow','Units','inches','Position',...
    [.5 6.75 .5 0],'HeadStyle','vback2');
annotation('arrow','Units','inches','Position',...
    [.5 6.45 .5 0],'HeadStyle','vback2');
annotation('arrow','Units','inches','Position',...
    [.5 6.15 .5 0],'HeadStyle','vback2');
annotation('arrow','Units','inches','Position',...
    [.5 5.85 .5 0],'HeadStyle','vback2');
annotation('arrow','Units','inches','Position',...
    [.5 5.55 .5 0],'HeadStyle','vback2');
annotation('line','Units','inches','Position',...
    [.5 5.55 0 1.5]);
annotation('arrow','Units','inches','Position',...
    [1 5.55 0 2],'HeadStyle','plain','HeadWidth',4,'HeadLength',7);
annotation('textbox','Units','inches','Position',...
    [.1 7.1 1 .3],'String','{\itU}_\infty, {\itT}_\infty',...
    'LineStyle','none','FontSize',12);
annotation('textbox','Units','inches','Position',...
    [.9 7.5 1 .3],'String','{\ity}',...
    'LineStyle','none','FontSize',12);
annotation('textbox','Units','inches','Position',...
    [12.35 6.92 .4 .3],'LineStyle','none','String','\delta({\itx})',...
    'FontSize',12);
b.del = annotation('textbox','Units','inches','Position',...
    [12.35 6.37 .4 .3],'LineStyle','none','String','\delta_t({\itx})',...
    'FontSize',12);
annotation('textbox','Units','inches','Position',...
    [12.5 5.5 1 .3],'LineStyle','none','String',...
    '{\itT}_s > {\itT}_\infty','FontSize',12);
annotation('line','Units','inches','Position',...
    [12.2 5.72 .3 0])
annotation('arrow','Units','inches','Position',...
    [12.2 5.72 0 -.23],'HeadStyle','ellipse','HeadLength',5,'HeadWidth',5);
annotation('textbox','Units','inches','Position',...
    [13.79 5.5 1.5 .3],'String','Prandtl Number',...
    'LineStyle','none','FontSize',12);
annotation('textbox','Units','inches','Position',...
    [13.75 7.25 1.5 .3],'String','Boundary Layer',...
    'LineStyle','none','FontSize',12);

%% add user control
%slider
uicontrol('Parent',b.fig,'Style','slide','Units','inches',...
    'Position',[.75 5.3 11.75 .2],'Min',0,'Max',10,...
    'Value',5,'SliderStep',[1/1000 1/200],...
    'Callback',{@slider_call,b},'BackgroundColor',[.6 .6 .6],...
    'ForegroundColor',[.6 .6 .6],'Tag','POS');
uibuttongroup('Visible','on','Units','inches','Position',...
    [.73 5.3 .25 .2],'BorderType','none','BackGroundColor',b.fig.Color);
uibuttongroup('Visible','on','Units','inches','Position',...
    [12.28 5.3 .25 .2],'BorderType','none','BackGroundColor',b.fig.Color);
bg = uibuttongroup('Visible','on','Units','inches','Position',...
    [13.7 6.0 1.5 1.3],'SelectionChangedFcn',...
    {@bselection,b});
uicontrol('Parent',bg,'Style','radiobutton','String','velocity   ',...
    'Units','inches','Position',[.05 .75 1.3 .3],'HandleVisibility',...
    'off','FontSize',12,'ForegroundColor',[0 .75 .75]);
uicontrol('Parent',bg,'Style','radiobutton','String','temperature',...
    'Units','inches','Position',[.05 .25 1.3 .3],'HandleVisibility',...
    'off','FontSize',12,'ForegroundColor',[1 0 0]);
uicontrol('Style','popup','String', {'0.6','1','3'},...
     'Units','inches','Position', [13.95 5.13 1 .4],'Value',3,...
     'Callback',{@popupCallback,b},'FontSize',12,'Tag','PR');
 
% set(findall(b.fig,'-property','FontUnits'),'FontUnits','normalized')
% set(findall(b.fig,'-property','Units'),'Units','normalized')

end

%% BL selection
function bselection(varargin)
[H,b] = varargin{[1,3]};
if strcmp(H.SelectedObject.String,'velocity   ') == 1
    set(b.h_slope_zeroT,'Visible','off');
    set(b.h_Tprof,'Color',[.85 .85 .85]);
    set(b.h_TBl,'Color',[.85 .85 .85]);
    set(b.h_vBl,'Color',[0 .75 .75]);
    set(b.h_vprof,'Color',[0 .75 .75]);
    set(b.h_dudy0,'Color',[0 .75 .75]);
    set(b.h_dTdy0,'Color',[.85 .85 .85]);
    set(b.h_Cf,'Color',[0 .75 .75]);
    set(b.h_Nu,'Color',[.85 .85 .85]);
    set(b.ax2,'YColor',[0 .75 .75]);
    set(b.ax3,'YColor',[.85 .85 .85]);
    set(b.ax5,'YColor',[0 .75 .75]);
    set(b.ax6,'YColor',[.85 .85 .85]);
    set(b.h_slope_zero,'Visible','on');
    set(b.h_vel1,'Visible','on');
    set(b.h_velar1,'Visible','on');
    set(b.h_vel2,'Visible','on');
    set(b.h_velar2,'Visible','on');
    set(b.h_vel3,'Visible','on');
    set(b.h_velar3,'Visible','on');
    set(b.h_vel4,'Visible','on');
    set(b.h_velar4,'Visible','on');    
    set(b.h_vel5,'Visible','on');
    set(b.h_velar5,'Visible','on');
end
if strcmp(H.SelectedObject.String, 'temperature') == 1
    set(b.h_slope_zeroT,'Visible','on');
    set(b.h_Tprof,'Color',[1 0 0]);
    set(b.h_TBl,'Color',[1 0 0]);
    set(b.h_vBl,'Color',[.85 .85 .85]);
    set(b.h_vprof,'Color',[.85 .85 .85]);
    set(b.h_dudy0,'Color',[.85 .85 .85]);
    set(b.h_dTdy0,'Color',[1 0 0]);
    set(b.h_Cf,'Color',[.85 .85 .85]);
    set(b.h_Nu,'Color',[1 0 0]);
    set(b.ax2,'YColor',[.85 .85 .85]);
    set(b.ax3,'YColor',[1 0 0]);
    set(b.ax5,'YColor',[.85 .85 .85]);
    set(b.ax6,'YColor',[1 0 0]);
    set(b.h_slope_zero,'Visible','off');
    set(b.h_vel1,'Visible','off');
    set(b.h_velar1,'Visible','off');
    set(b.h_vel2,'Visible','off');
    set(b.h_velar2,'Visible','off');
    set(b.h_vel3,'Visible','off');
    set(b.h_velar3,'Visible','off');
    set(b.h_vel4,'Visible','off');
    set(b.h_velar4,'Visible','off');    
    set(b.h_vel5,'Visible','off');
    set(b.h_velar5,'Visible','off');
end
end

%% popup for Pr
function [] = popupCallback(varargin)
[H,b] = varargin{[1,3]};
if H.Value == 1 %Pr = 0.6
    h1 = findobj('Tag','POS');
    POS = h1.Value-5;
    h_avg = 0.664*b.kf*(0.6^(1/3))*sqrt(b.U_inf/b.nu)/sqrt(POS+5);
    h_local = b.h_x(1,round(12600*(POS+5)/10));
    set(b.txthlocal,'String',...
        ['{\ith}_x = ' num2str(round(h_local,2)) ' W/m^2-K']);
    set(b.txthavg,'String',...
    ['{\ith}_0_-_{\itx} = ' num2str(round(h_avg,2)) ' W/m^2-K'])
    set(b.h_dTdy0, 'YData',b.dT_dy_0(1,:))
    set(b.h_Nu,'YData',b.Nu_x(1,:))
    set(b.h_hx,'YData',b.h_x(1,:))
    set(b.h_slope_zeroT,'XData',[POS+5-.2 POS+5+1],'YData',...
        [-1.2/(b.dT_dy_0(1,round(12600*(POS+5)/10))) 0])
    set(b.h_Tprof,'XData',b.Tprofx(1,:)+POS)
    set(b.h_TBl,'YData',b.eta(5948)*sqrt(b.nu*b.x/b.U_inf))
    set(b.del,'Position',[12.35 7.23 .4 .3],'String','\delta_t({\itx})')
    xshade = b.x(1:round(12600*(POS+5)/10));
    hshade = b.h_x(1,(1:length(xshade)));
    set(b.shade,'XData',xshade,'YData',hshade);
end
if H.Value == 2 %Pr = 1
    h1 = findobj('Tag','POS');
    POS = h1.Value-5;   
    h_avg = 0.664*b.kf*(1^(1/3))*sqrt(b.U_inf/b.nu)/sqrt(POS+5);
    h_local = b.h_x(2,round(12600*(POS+5)/10));
    set(b.txthlocal,'String',...
        ['{\ith}_x = ' num2str(round(h_local,2)) ' W/m^2-K']);
    set(b.txthavg,'String',...
        ['{\ith}_0_-_{\itx} = ' num2str(round(h_avg,2)) ' W/m^2-K'])
    set(b.h_dTdy0, 'YData',b.dT_dy_0(2,:))
    set(b.h_Nu,'YData',b.Nu_x(2,:))
    set(b.h_hx,'YData',b.h_x(2,:))
    set(b.h_slope_zeroT,'XData',[POS+5-.2 POS+5+1],'YData',...
        [-1.2/(b.dT_dy_0(2,round(12600*(POS+5)/10))) 0])
    set(b.h_Tprof,'XData',b.Tprofx(2,:)+POS)
    set(b.h_TBl,'YData',b.eta(4892)*sqrt(b.nu*b.x/b.U_inf))
    set(b.del,'Position',[12.65 6.92 .7 .3],'String',', \delta_t({\itx})')
    xshade = b.x(1:round(12600*(POS+5)/10));
    hshade = b.h_x(2,(1:length(xshade)));
    set(b.shade,'XData',xshade,'YData',hshade);
end
if H.Value == 3 %Pr = 3
    h1 = findobj('Tag','POS');
    POS = h1.Value-5;
    h_avg = 0.664*b.kf*(3^(1/3))*sqrt(b.U_inf/b.nu)/sqrt(POS+5);
    h_local = b.h_x(3,round(12600*(POS+5)/10));
    set(b.txthlocal,'String',...
        ['{\ith}_x = ' num2str(round(h_local,2)) ' W/m^2-K']);
    set(b.txthavg,'String',...
        ['{\ith}_0_-_{\itx} = ' num2str(round(h_avg,2)) ' W/m^2-K'])
    set(b.h_dTdy0, 'YData',b.dT_dy_0(3,:))
    set(b.h_Nu,'YData',b.Nu_x(3,:))
    set(b.h_hx,'YData',b.h_x(3,:))
    set(b.h_slope_zeroT,'XData',[POS+5-.2 POS+5+1],'YData',...
        [-1.2/(b.dT_dy_0(3,round(12600*(POS+5)/10))) 0])
    set(b.h_Tprof,'XData',b.Tprofx(3,:)+POS)
    set(b.h_TBl,'YData',b.eta(3267)*sqrt(b.nu*b.x/b.U_inf))
    set(b.del,'Position',[12.35 6.37 .4 .3],'String','\delta_t({\itx})')
    xshade = b.x(1:round(12600*(POS+5)/10));
    hshade = b.h_x(3,(1:length(xshade)));
    set(b.shade,'XData',xshade,'YData',hshade);
end
end

%% slider for position
function [] = slider_call(varargin)
[H,b] = varargin{[1,3]};
slider_value = H.Value;
h1 = findobj('Tag','PR');
PR_choice = h1.Value;
if PR_choice == 1
    pr = 0.6;
elseif PR_choice == 2
    pr = 1;
elseif PR_choice == 3
    pr = 3;
end
h_avg = 0.664*b.kf*(pr^(1/3))*sqrt(b.U_inf/b.nu)/sqrt(slider_value);
h_local = b.h_x(PR_choice,round(12600*(slider_value)/10));
    set(b.txthlocal,'String',...
        ['{\ith}_x = ' num2str(round(h_local,2)) ' W/m^2-K']);
set(b.txthavg,'String',...
    ['{\ith}_0_-_{\itx} = ' num2str(round(h_avg,2)) ' W/m^2-K'])
vprofx = b.df_deta + slider_value;
vprofy = b.eta*sqrt(b.nu*slider_value/b.U_inf);
Tprofx = -b.TH + 1 + slider_value;
Tprofy = b.eta*sqrt(b.nu*slider_value/b.U_inf);
xshade = b.x(1:round(12600*slider_value/10));
hshade = b.h_x(PR_choice,(1:length(xshade)));
set(b.shade,'XData',xshade,'YData',hshade);
set(b.h_vprof,'xdata',vprofx,'ydata',vprofy);
set(b.h_slope_zero,'xdata',[slider_value slider_value+1.2],'ydata',...
    [0 (1.2)/b.du_dy_0(round(12600*slider_value/10))]);
set(b.h_Tprof,'xdata',Tprofx(PR_choice,:),'ydata',Tprofy);
set(b.h_slope_zeroT,'xdata',[slider_value-.2 slider_value+1],'ydata',...
    [-1.2/(b.dT_dy_0(PR_choice,round(12600*slider_value/10))) 0]);
set(b.h_x_ind,'xdata',[slider_value slider_value])
set(b.h_x_ind2,'xdata',[slider_value slider_value])
set(b.h_x_ind3,'xdata',[slider_value slider_value])
set(b.h_vel1,'XData',[slider_value vprofx(1000)],'YData',...
    [vprofy(1000) vprofy(1000)]);
set(b.h_velar1,'XData',vprofx(1000),'YData',vprofy(1000));
set(b.h_vel2,'XData',[slider_value vprofx(2000)],'YData',...
    [vprofy(2000) vprofy(2000)]);
set(b.h_velar2,'XData',vprofx(2000),'YData',vprofy(2000));
set(b.h_vel3,'XData',[slider_value vprofx(3000)],'YData',...
    [vprofy(3000) vprofy(3000)]);
set(b.h_velar3,'XData',vprofx(3000),'YData',vprofy(3000));
set(b.h_vel4,'XData',[slider_value vprofx(4000)],'YData',...
    [vprofy(4000) vprofy(4000)]);
set(b.h_velar4,'XData',vprofx(4000),'YData',vprofy(4000));
set(b.h_vel5,'XData',[slider_value vprofx(4921)],'YData',...
    [vprofy(4921) vprofy(4921)]);
set(b.h_velar5,'XData',vprofx(4921),'YData',vprofy(4921));
set(b.h_yax,'XData',[slider_value slider_value]);
set(b.h_yaxar,'XData',slider_value)
end

%% solve for velocity and thermal BL with similarity solution
function [etavec,fvec,gvec,hvec,THvec,THdvec] = V_TH_BL
% f''' + 1/2 f f'' = 0
% b.c. f(0)=f'(0)=0 and f'(inf)=1
% g = f'
% g' = f'' = h
% g'' = f''' = h' = -1/2 f f'' = -1/2 f h
deta = 0.001;
total = 10;
etavec = zeros(1,total/deta);
fvec = zeros(1,total/deta);
gvec = zeros(1,total/deta);
% vary initial value of h
hvec = ones(1,total/deta)*0.3319;
for jj=1:total/deta
    etavec(jj+1)=etavec(jj)+deta;
    fvec(jj+1)=fvec(jj)+gvec(jj)*deta;
    gvec(jj+1)=gvec(jj)+hvec(jj)*deta;
    hvec(jj+1)=hvec(jj)-1/2*fvec(jj)*hvec(jj)*deta;
end
Vel_check = gvec(total/deta);
if abs(Vel_check - 1) > 0.01
    error('Enter new guess for shooting method (velocity).')
end
% TH'' + Pr/2 f TH' = 0
% b.c. TH(0)=0 and TH(inf)=1
% THd = TH'
% etavec = zeros(1,total/deta);
shoot = [0.277 0.6;0.332 1;0.48485 3];
THvec = zeros(3,total/deta);
THdvec = ones(3,total/deta).*repmat(shoot(:,1),1,total/deta);
Pr = shoot(:,2);
for jj=1:total/deta
    THvec(:,jj+1)=THvec(:,jj)+THdvec(:,jj)*deta;
    THdvec(:,jj+1)=THdvec(:,jj) - [fvec(jj);fvec(jj);fvec(jj)].*...
        Pr.*THdvec(:,jj)*deta/2;
end
Temp_check = THvec(:,total/deta);
if max(abs(Temp_check - 1)) > 0.01
    error('Enter new guess for shooting method (temperature).')
end
end

