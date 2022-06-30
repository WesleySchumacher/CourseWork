%Sara Khorchidian 11/2019
clear 
close all
clc
%% description
% This gui solves all your problems. Not quite, but it will solve for the
% convective coefficient, h, for all basic models. First input values for 
% x, k, Pr, and Re. When entering new values in input boxes, you must press
% control + Enter. Second, follow the toggle buttons for the appropriate
% model conditions. Enter any other values when prompted. If the program
% says to reset you may have a mistake in your initial calculation of Re.
% Finally, don't blow up the program.

%% figure and parameter formatting
global h 
h = {};
h.fig = figure('Units','inches','Position',[3 .25 6.5 7.2],...
    'Name','Convective Coefficient Solver','NumberTitle','off');
h.title = annotation('textbox','Units','inches','Position',...
    [0.4 2.2 6 5],'LineStyle','none','String',...
    'Convection Coefficient for Basic Models','FontSize',20);
h.reset = uicontrol('Style','pushbutton','Units','inches',...
    'Position',[5.7 6.75 0.6 0.4],'String','Reset','Tag',...
    'reset','Callback',@resetPushed);
h.DISPLAY = annotation('textbox','Units','inches','Position',...
    [1 -3.7 6 5],'LineStyle','none','String',...
    'h','FontSize',20,'Visible','off');
%Parameters
h.k = 0.273;
h.D = 0.5;
h.L = 10;
h.Pr = 0.8;
h.PrTxt = annotation('textbox','Units','inches','Position',...
    [3.9 5.63 2.5 1.0],'LineStyle','none','String',...
    '{\itPr} = ','Color',[1 0 .6],'FontSize',14);
h.PrVal = uicontrol('Style','edit','Units','inches','Position',...
    [4.4 6.3 1.0 0.3],'Value',h.Pr,'Tag','valPr','String','0.8',...
    'Callback',@val_Pr,'BackgroundColor',h.fig.Color);
h.Re = 10000;
h.ReTxt = annotation('textbox','Units','inches','Position',...
    [1.9 5.63 2.5 1.0],'LineStyle','none','String',...
    '{\itRe} = ','Color',[1 0 .6],'FontSize',14);
h.ReVal = uicontrol('Style','edit','Units','inches','Position',...
    [2.45 6.3 1.25 0.3],'Value',h.Re,'Tag','valRe','String','10000',...
    'Callback',@val_Re,'BackgroundColor',h.fig.Color);
h.IPTxt = annotation('textbox','Units','inches','Position',...
    [0.4 5.75 1.0 1.0],'LineStyle','none','String',...
    [{'     Initial'}, {'Parameters'}],'Color',[1 0 .6],'FontSize',16);
h.Rexc = 8000;
h.mumus = 1.6;
h.x = 1.0;
h.moveEval = 0;

%First options
h.flowLocTxt = uicontrol('Style','text','Units','inches','Position',...
    [0.25 5.0 1.0 1.0],'String','Flow Location','FontSize',16);
h.extFlow = uicontrol('Style','togglebutton','Units','inches',...
    'Position',[1.4 5.5 1.5 0.4],'String','External', 'Tag',...
    'extButt','Callback',@extFlowPushed);
h.intFlow = uicontrol('Style','togglebutton','Units','inches',...
    'Position',[3.0 5.5 1.5 0.4],'String','Internal', 'Tag',...
    'intButt','Callback',@intFlowPushed);

%% Callback for buttons

function [] = sliderK()
global h
h.slideMink = 0;
h.slideMaxk = 1;
h.kTxt = uicontrol('Style','text','Units','inches','Position',...
    [3.2 4.35 2.5 0.3],'String',['k = ' num2str(round(h.k,3)) ' W/(m·K)'],...
    'FontSize',14,'Tag','Button3');
h.kVal = uicontrol('Style','slide','Units','inches','Position',...
    [3.4 4.1 2.0 0.2],'Min',h.slideMink,'Max',h.slideMaxk,...
    'Value',round(h.k,3),'SliderStep',[1/1000 1/100],'Tag','Button3',...
    'Callback',@slider_k,'BackgroundColor',h.fig.Color);
end

function [] = sliderK2()
global h
h.slideMink = 0;
h.slideMaxk = 1;
h.kTxt = uicontrol('Style','text','Units','inches','Position',...
    [0.3 4.35 2.5 0.3],'String',['k = ' num2str(round(h.k,3)) ' W/(m·K)'],...
    'FontSize',14,'Tag','Button3');
h.kVal = uicontrol('Style','slide','Units','inches','Position',...
    [0.8 4.1 1.5 0.2],'Min',h.slideMink,'Max',h.slideMaxk,...
    'Value',round(h.k,3),'SliderStep',[1/1000 1/100],'Tag','Button3',...
    'Callback',@slider_k2,'BackgroundColor',h.fig.Color);
end

function [] = sliderD()
global h
h.slideMinD = 0;
h.slideMaxD = 1;
h.DTxt = uicontrol('Style','text','Units','inches','Position',...
    [2.6 4.35 1.5 0.3],'String',['D = ' num2str(round(h.D,3)) ' m'],...
    'FontSize',14,'Tag','Button3');
h.DVal = uicontrol('Style','slide','Units','inches','Position',...
    [2.6 4.1 1.5 0.2],'Min',h.slideMinD,'Max',h.slideMaxD,...
    'Value',round(h.D,3),'SliderStep',[1/1000 1/100],'Tag','Button3',...
    'Callback',@slider_D,'BackgroundColor',h.fig.Color);
end

function [] = sliderL()
global h
h.slideMinL = 0;
h.slideMaxL = 1000;
h.LTxt = uicontrol('Style','text','Units','inches','Position',...
    [4.4 4.35 1.5 0.3],'String',['L = ' num2str(round(h.L,3)) ' m'],...
    'FontSize',14,'Tag','Button3');
h.LVal = uicontrol('Style','slide','Units','inches','Position',...
    [4.4 4.1 1.5 0.2],'Min',h.slideMinL,'Max',h.slideMaxL,...
    'Value',round(h.L,3),'SliderStep',[1/1000 1/100],'Tag','Button3',...
    'Callback',@slider_L,'BackgroundColor',h.fig.Color);
end

function [] = sliderX()
global h
h.slideMinx = 0.01;
h.slideMaxx = 10;
h.xTxt = uicontrol('Style','text','Units','inches','Position',...
    [0.8 4.35 2.0 0.3],'String',['x = ' num2str(round(h.x,3)) ' m'],...
    'FontSize',14,'Tag','Button3');
h.xVal = uicontrol('Style','slide','Units','inches','Position',...
    [0.8 4.1 2.0 .2],'Min',h.slideMinx,'Max',h.slideMaxx,...
    'Value',round(h.x,3),'SliderStep',[1/1000 1/100],'Tag','Button3',...
    'Callback',@slider_x,'BackgroundColor',h.fig.Color);
end

function [] = evalPushed(~,~)
global h
%% LINES ADDED BY KEITH revised by Sara
if isfield(h, 'lvar') && h.lvar.Value == 1 %because h needs to evaluated after mumus input
        last_butt.Callback = @lvarPushed;
        feval(last_butt.Callback)
elseif isfield(h, 'lvar2') && h.lvar2.Value == 1  %same thing chicken wing
        last_butt.Callback = @lvar2Pushed;
        feval(last_butt.Callback)
elseif isfield(h, 'ngeo') && strcmp(h.ngeo.Visible, 'on') == 1 %in case first popup gets changed
        last_butt.Callback = @ngeoSelected;
        feval(last_butt.Callback)
elseif isfield(h, 'sphere') && h.sphere.Value == 1 %because h needs to evaluated after mumus input
        last_butt.Callback = @spherePushed;
        feval(last_butt.Callback)
else %-not '0' doesn't work, there are 10 options in one of the popup menus
    current_butt = findobj('Value',1,'-or','Value',2,'-or','Value',3,'-or',... 
        'Value',4,'-or','Value',5,'-or','Value',6,'-or','Value',7,...
        '-or','Value',8,'-or','Value',9,'-or','Value',10) %unsuppress to see the buttons pushed in the sequence
    last_butt = current_butt(2);
    feval(last_butt.Callback)
end
%%
resethPushed()
if isnumeric(h.h) == 1
    if h.moveEval == 1
        h.hTxt = uicontrol('Style','text','Units','inches',...
            'Position',[3.0 1.25 2.0 0.3],'FontSize',12,'Tag','h',...
            'String',['h_bar = ' num2str(round(h.h,2)) ' W/(m^2*K)']);
    elseif h.moveEval == 2
        h.hTxt = uicontrol('Style','text','Units','inches',...
            'Position',[3.0 1.95 2.0 0.3],'FontSize',12,'Tag','h',...
            'String',['h_bar = ' num2str(round(h.h,2)) ' W/(m^2*K)']);
    elseif h.moveEval == 3
        h.hTxt = uicontrol('Style','text','Units','inches',...
            'Position',[3.0 2.65 2.0 0.3],'FontSize',12,'Tag','h',...
            'String',['h_bar = ' num2str(round(h.h,2)) ' W/(m^2*K)']);
    else
        h.hTxt = uicontrol('Style','text','Units','inches',...
            'Position',[3.0 0.55 2.0 0.3],'FontSize',12,'Tag','h',...
            'String',['h_bar = ' num2str(round(h.h,2)) ' W/(m^2*K)']);
    end
else
    if h.moveEval == 1
        h.hTxt = uicontrol('Style','text','Units','inches','Tag','h',...
            'Position',[3.1 0.5 3.25 1.2],'FontSize',12,'String',h.h); 
    elseif h.moveEval == 2
        h.hTxt = uicontrol('Style','text','Units','inches','Tag','h',...
            'Position',[3.1 1.2 3.25 1.2],'FontSize',12,'String',h.h); 
    elseif h.moveEval == 3
        h.hTxt = uicontrol('Style','text','Units','inches','Tag','h',...
            'Position',[3.1 1.9 3.25 1.2],'FontSize',12,'String',h.h);      
    else    
        h.hTxt = uicontrol('Style','text','Units','inches','Tag','h',...
            'Position',[3.1 0 3.25 1.2],'FontSize',12,'String',h.h);  
    end
end
end

function [] = evalButton()
global h
if h.moveEval == 1
    h.eval = uicontrol('Style','pushbutton','Units','inches',...
        'Position',[1.4 1.2 1.5 0.4],'String','Evaluate!',...
        'Tag','Button7','Callback',@evalPushed);
elseif h.moveEval == 2
    h.eval = uicontrol('Style','pushbutton','Units','inches',...
        'Position',[1.4 1.9 1.5 0.4],'String','Evaluate!',...
        'Tag','Button7','Callback',@evalPushed);
elseif h.moveEval == 3
    h.eval = uicontrol('Style','pushbutton','Units','inches',...
        'Position',[1.4 2.6 1.5 0.4],'String','Evaluate!',...
        'Tag','Button7','Callback',@evalPushed);
else
    h.eval = uicontrol('Style','pushbutton','Units','inches',...
        'Position',[1.4 0.5 1.5 0.4],'String','Evaluate!',...
        'Tag','Button7','Callback',@evalPushed);
end
end

%%%%%%%%%%%%%%%%%%%
%%%External Flow%%%
%%%%%%%%%%%%%%%%%%%

function [] = extFlowPushed(~,~)
global h
resetExt()
    if h.extFlow.Value == 1
        h.intFlow.Value = 0;
        h.geoTxt = uicontrol('Style','text','Units','inches',...
            'Position',[0 4.2 1.5 1.0],'String','Geometry',...
            'FontSize',16,'Tag','Button2');
        h.flatPlate = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 4.8 1.5 0.4],'String','Flat Plate', 'Tag',...
            'Button2','Callback',@flatPlatePushed);
        h.cyl1 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 4.8 1.5 0.4],'String','Cylinder', 'Tag',...
            'Button2','Callback',@cyl1Pushed);
        h.sphere = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[4.6 4.8 1.5 0.4],'String','Sphere', 'Tag',...
            'Button2','Callback',@spherePushed);
    else
        resetPushed()
    end
end

function [] = flatPlatePushed(~,~)
global h
reset2Pushed();
    if h.flatPlate.Value == 1
        h.cyl1.Value = 0; h.sphere.Value = 0;
        sliderK(), sliderX()
        h.flowTypeTxt = uicontrol('Style','text','Units','inches',...
            'Position',[0 2.8 1.5 1.0],'String','Flow Type',...
            'FontSize',16,'Tag','Button3');
        h.lam = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 3.4 1.5 0.4],'String','Laminar','Tag',...
            'Button3','Callback',@lamPushed);
        h.mix = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 3.4 1.5 0.4],'String','Mixed','Tag',...
            'Button3','Callback',@mixPushed);
        h.turb = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[4.6 3.4 1.5 0.4],'String','Turbulent','Tag',...
            'Button3','Callback',@turbPushed);
    end
end

function [] = lamPushed(~,~)%External laminar flow over flat plate
global h
reset3Pushed();
    if h.lam.Value == 1
        h.mix.Value = 0; h.turb.Value = 0;
        h.nuNumTxt = uicontrol('Style','text','Units','inches',...
            'Position',[0 2.2 1.5 1.0],'String','Nusselt Number',...
            'FontSize',16,'Tag','Button4');
        h.avg = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 2.7 1.5 0.4],'String','Average','Tag',...
            'Button4','Callback',@avgPushed);
        h.loc1 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 2.7 1.5 0.4],'String','Local','Tag',...
            'Button4','Callback',@loc1Pushed);
    end
end

function [] = avgPushed(~,~)%Average h for flow over laminar flat plate
global h
reset4Pushed();
    if h.avg.Value == 1
        h.loc1.Value = 0;
        h.bcTxt = uicontrol('Style','text','Units','inches',...
            'Position',[0.3 1.5 1.0 1.0],'String',...
            'Boundary Condition','FontSize',16,'Tag','Button5');
        h.iso1 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 2.0 1.5 0.4],'String','Isothermal Plate',...
            'Tag','Button5','Callback',@iso1Pushed);
        h.chf1 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 2.0 1.5 0.4],'String','Constant Heat Flux',...
            'Tag','Button5','Callback',@chf1Pushed);
    end
end

function [] = iso1Pushed(~,~)%7.30 Avg h for Laminar Isothermal Flat Plate
global h
reset5Pushed();
h.moveEval = 1;
if h.iso1.Value == 1
    evalButton()
end
        h.chf1.Value = 0;
        if h.Pr>=0.6
            h.h = (0.664*h.Re^(1/2))*(h.Pr^(1/3))*h.k/h.x;
        else
            h.h = ['Sorry, h cannot be calculated.' ...
                ' Pr must be greater than 0.6.'];
        end
end

function [] = chf1Pushed(~,~)%7.49 Avg h Laminar Const Heat Flux Flat Plate
global h
reset5Pushed();
h.moveEval = 1;
if h.chf1.Value == 1
    evalButton()
end
    h.iso1.Value = 0;
    h.h = 0.68*h.Re^(1/2)*h.Pr^(1/3)*h.k/h.x;
end

function [] = loc1Pushed(~,~)%Local h for flow over laminar flat plate
global h
reset4Pushed();
    if h.loc1.Value == 1
        h.avg.Value = 0;
        h.bcTxt = uicontrol('Style','text','Units','inches','Position',...
            [0.25 1.5 1.0 1.0],'String','Boundary Condition','FontSize',...
            16,'Tag','Button5');
        h.iso2 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 2.0 1.5 0.4],'String','Isothermal Plate',...
            'Tag','Button5','Callback',@iso2Pushed);
        h.chf2 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 2.0 1.5 0.4],'String','Constant Heat Flux',...
            'Tag','Button5','Callback',@chf2Pushed);
    end
end
     
function [] = iso2Pushed(~,~)%7.23 & 7.33 Local h laminar iso flat plate
global h
reset5Pushed(); 
h.moveEval = 1;
if h.iso2.Value == 1
    evalButton()
end
    h.chf2.Value = 0;
    h.Pex = h.Re*h.Pr;
    if h.Pex > 100
        h.h = ((0.3387*h.Re^(1/2)*h.Pr^(1/3))/(1+(0.0468/h.Pr)^...
            (2/3))^(1/4))*h.k/h.x;
    elseif h.Pr >= 0.6 && h.Pex < 100
        h.h = 0.332*h.Re^(1/2)*h.Pr^(1/3)*h.k/h.x;
    elseif h.Pr < 0.6 && h.Pex < 100
        h.h = ['Sorry, h could not be calculated. '...
            'Pr must be greater than 0.6 or Re*Pr '...
            'must be greater than 100.'];
    else
        h.h = ['Sorry, h could not be calculated. '...
            'Pr must be greater than 0.6 or Re*Pr '...
            'must be greater than 100.'];
    end
end

function [] = chf2Pushed(~,~)%7.45 Local h lam const heat flux flat plate
global h
reset5Pushed(); 
h.moveEval = 1;
if h.chf2.Value == 1
    evalButton()
end
button = imread('button.jpg');
        button = imresize(button, [50 70]);
        h.explodable = uicontrol('Style','togglebutton','Units',...
            'inches','Position',[5.2 0.2 1.0 0.7],'Tag',...
            'Button4','Callback',@explode,'cdata',button);
    h.iso2.Value = 0;
    if h.Pr >= 0.6
        h.h = 0.453*h.Re^(1/2)*h.Pr^(1/3)*h.k/h.x;
    else
        h.h = ['Sorry, h could not be calculated. '...
            'Pr must greater than or equal to 0.6.'];          
    end
end

function [] = mixPushed(~,~)%7.38 Average h mixed flow iso flat plate
global h
reset3Pushed();
h.moveEval = 2;
if h.mix.Value == 1
    evalButton()
end
    h.lam.Value = 0; h.turb.Value = 0;
    h.addPam = uicontrol('Style','text','Units','inches',...
        'Position',[0.15 2.2 1.25 1.0],'String',...
        'Additional Parameters','FontSize',16,'Tag','Button5');
    h.RexcTxt = uicontrol('Style','text','Units','inches',...
        'Position',[1.5 2.7 1.0 0.3],'String','Re_x,c =',...
        'Tag','Button4','FontSize',12);
    h.Rexcval = uicontrol('Style','edit','Units','inches',...
        'Position',[2.4 2.7 1.5 0.3],'Value',h.Rexc,'String',...
        h.Rexc,'Tag','Button4','CallBack',@val_Rexc);
    A = 0.037*h.Rexc^(4/5)-0.664*h.Rexc^(1/2);
    if (0.6 <= h.Pr) && (h.Pr <= 60) && (h.Rexc <= h.Re) &&...
        (h.Re<=10^8)
        h.h = ((0.037*h.Re^(4/5)-A)*h.Pr^(1/3))*h.k/h.x;
    else
        h.h = ['Sorry, h_bar could not be calculated. '...
            'Pr must be in the interval [0.6,60]. Re_x,c'...
            ' must be greater than Re, and Re must be '...
            'less than or equal to 10^8'];
    end
end

function [] = turbPushed(~,~)%External turbulent flow over flat plate
global h
reset3Pushed(); 
    if h.turb.Value == 1 
        h.lam.Value = 0; h.mix.Value = 0;
        h.bcTxt = uicontrol('Style','text','Units','inches',...
            'Position',[0.2 2.2 1.0 1.0],'String',...
            'Boundary Condition','FontSize',16,'Tag','Button4');
        h.iso3 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 2.7 1.5 0.4],'String','Isothermal Plate',...
            'Tag','Button4','Callback',@iso3Pushed);
        h.chf3 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 2.7 1.5 0.4],'String','Constant Heat Flux',...
            'Tag','Button4','Callback',@chf3Pushed);
    end
end

function [] = iso3Pushed(~,~)%7.36 Local h turb flow iso flat plate
global h
reset4Pushed(); 
h.moveEval = 2;
if h.iso3.Value == 1
    evalButton()
end
    h.chf3.Value = 0;
    if (0.6 <= h.Pr) && (h.Pr <= 60)
        h.chf3.Value = 0; 
        h.h = (0.0296*h.Re^(4/5)*h.Pr^(1/3))*h.k/h.x;
    else
        h.h = ['Sorry, h could not be calculated. '...
            'Pr must be in the interval [0.6, 60].'];
    end
end

function [] = chf3Pushed(~,~)%7.46 Local h turb flow const HF flat plate
global h
reset4Pushed();
h.moveEval = 2;
if h.chf3.Value == 1 
    evalButton()
end
    h.iso3.Value = 0;
    if(0.6 <= h.Pr) && (h.Pr <= 60)
        h.iso3.Value = 0; 
        h.h = (0.0308*h.Re^(4/5)*h.Pr^(1/3))*h.k/h.x;
    else
        h.h = ['Sorry, h could not be calculated. '...
            'Pr must be in the interval [0.6, 60].'];
    end
end

function [] = cyl1Pushed(~,~)%External flow over cylinder
global h
reset2Pushed();
    if h.cyl1.Value == 1
        h.flatPlate.Value = 0; h.sphere.Value = 0;
        sliderK2(), sliderD()
        h.xsecTxt = uicontrol('Style','text','Units','inches',...
            'Position',[0.25 2.95 1.0 1.0],'String','Cross Section',...
            'FontSize',16,'Tag','Button3');
        h.circ = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 3.4 1.5 0.4],'String','Circular','Tag',...
            'Button3','Callback',@circPushed);
        h.ncirc = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 3.4 1.5 0.4],'String','Non-Circular','Tag',...
            'Button3','Callback',@ncircPushed);
    end
end

function [] = circPushed(~,~)%7.54 External flow over circular cylinder
global h
reset3Pushed()
h.moveEval = 3;
if (h.circ.Value == 1) && (h.Re*h.Pr >= 0.2)
    evalButton()
end
    h.ncirc.Value = 0;
    h.h = (0.3 + (0.62*h.Re^(1/2)*h.Pr^(1/3))/(1 + (0.4/h.Pr)^...
        (2/3))^(1/4)*(1 + (h.Re/282000)^(5/8))^(4/5))*h.k/h.D;
end

function [] = ncircPushed(~,~)%External flow over non-circular cylinder
global h
reset3Pushed()
    if h.ncirc.Value == 1
        h.circ.Value = 0;
        h.sTxt = uicontrol('Style','text','Units','inches',...
            'Position',[0.15 2.2 1.2 1.0],'String','X-Sec Geometry',...
            'FontSize',16,'Tag','Button4');
        h.sgeo = uicontrol('Style','popupmenu','Units','inches',...
            'Position',[1.35 2.7 2.0 0.4],'String',[{'Diamond'},...
            {'Square'},{'Vertical Hexagon'},{'Horizontal Hexagon'},...
            {'Thin Plate (Front)'},{'Thin Plate (Back)'}],'Tag',...
            'Button4','Callback',@sgeoSelected);
    end
end

function [] = sgeoSelected(~,~)%7.46 Local h turb flow const HF flat plate
global h
reset4Pushed(); h.moveEval = 2;
if h.ncirc.Value == 1
    evalButton()
end
    if h.sgeo.Value == 1 && (6000 <= h.Re) && (h.Re <= 60000)
        C = 0.304; m = 0.59; 
        h.h = C*h.Re^m*h.Pr^(1/3)*h.k/h.D;
    elseif h.sgeo.Value == 2 && (5000 <= h.Re) && (h.Re <= 60000)
        C = 0.158; m = 0.66; 
        h.h = C*h.Re^m*h.Pr^(1/3)*h.k/h.D;
    elseif h.sgeo.Value == 3 && (5200 <= h.Re) && (h.Re <= 20400)
        C = 0.164; m = 0.638; 
        h.h = C*h.Re^m*h.Pr^(1/3)*h.k/h.D;
    elseif h.sgeo.Value == 3 && (20400 <= h.Re) && (h.Re <= 105000)
        C = 0.039; m = 0.78; 
        h.h = C*h.Re^m*h.Pr^(1/3)*h.k/h.D;
    elseif h.sgeo.Value == 4 && (4500 <= h.Re) && (h.Re <= 90700)
        C = 0.15; m = 0.638; 
        h.h = C*h.Re^m*h.Pr^(1/3)*h.k/h.D;
    elseif h.sgeo.Value == 5 && (10000 <= h.Re) && (h.Re <= 50000)
        C = 0.667; m = 0.5; 
        h.h = C*h.Re^m*h.Pr^(1/3)*h.k/h.D;
    elseif h.sgeo.Value == 6 && (7000 <= h.Re) && (h.Re <= 80000)
        C = 0.191; m = 0.667; 
        h.h = C*h.Re^m*h.Pr^(1/3)*h.k/h.D;     
    else
        h.h = ['Sorry, h could not be calculated. The given value for'...
        ' Re is not valid for your chosen geometry. Consult the'... 
        ' literature for more information.'];
    end
end

function [] = spherePushed(~,~)%7.56 External flow over sphere
global h
reset2Pushed()
h.moveEval = 3;
if h.sphere.Value == 1 
    evalButton()
end
    h.flatPlate.Value = 0; h.cyl1.Value = 0;
        h.addPam = uicontrol('Style','text','Units','inches',...
            'Position',[0.15 2.9 1.25 1.0],'String',...
            'Additional Parameters','FontSize',16,'Tag','Button5');
        h.mumusTxt = uicontrol('Style','text','Units','inches',...
            'Position',[1.6 3.4 1.0 0.3],'String','mu/mu_s =',...
            'Tag','Button3','FontSize',12);
        h.mumusVal = uicontrol('Style','edit','Units','inches',...
            'Position',[2.6 3.4 1.2 0.3],'Value',h.mumus,...
            'String',h.mumus,'Tag','Button3','CallBack',@val_mumus);
        sliderK2(), sliderD()
        if (0.71 <= h.Pr) && (h.Pr <= 380) && (3.5 <= h.Re) &&...
        (h.Re <= 7.6*10^4) && (1 <= h.mumus) && (h.mumus <= 3.2)
        h.h = (2+(0.4*h.Re^(1/2)+0.06*h.Re^...
            (2/3))*h.Pr^0.4*h.mumus^(1/4))*h.k/h.D;
        else
            h.h = ['Sorry, h could not be calculated. '...
                'Pr must be in the interval [0.71,380], '...
                'Re must be in the interval [3.5,7.6*10^4] '...
                'and mu/mu_s must be in the interval [1.0,3.2].'...
                ' Push reset or update these values.'];
        end
end

%%%%%%%%%%%%%%%%%%%
%%%Internal Flow%%%
%%%%%%%%%%%%%%%%%%%

function [] = intFlowPushed(~,~)
global h
resetInt()
    if h.intFlow.Value == 1
        h.extFlow.Value = 0;
        h.xsec2Txt = uicontrol('Style','text','Units','inches',...
            'Position',[0.25 4.3 1.0 1.0],'String','Cross Section',...
            'FontSize',16,'Tag','Button2');
        h.circXsec1 = uicontrol('Style','togglebutton','Units',...
            'inches','Position',[1.4 4.8 1.5 0.4],'String',...
            'Circular','Tag','Button2','Callback',@cx1Pushed);
        h.ncircXsec1 = uicontrol('Style','togglebutton','Units',...
            'inches','Position',[3.0 4.8 1.5 0.4],'String',...
            'Non-Circular','Tag','Button2','Callback',@ncx1Pushed);
    else
        resetPushed()
    end
end

function [] = cx1Pushed(~,~)%Internal circular cross section flow laminar
global h
reset2Pushed();
    if h.circXsec1.Value == 1
        h.ncircXsec1.Value = 0;
        sliderK2(), sliderD(), sliderL()
        h.flowtype2 = uicontrol('Style','text','Units','inches',...
            'Position',[0 2.8 1.5 1.0],'String','Flow Type',...
            'FontSize',16,'Tag','Button3');
        h.lam2 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 3.4 1.5 0.4],'String','Laminar','Tag',...
            'Button3','Callback',@lam2Pushed);
        h.turb2 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 3.4 1.5 0.4],'String','Turbulent','Tag',...
            'Button3','Callback',@turb2Pushed);
    end
end
function [] = lam2Pushed(~,~)%Internal circular cross section flow laminar
global h
reset3Pushed();
    if h.lam2.Value == 1
        h.turb2.Value = 0;
        h.fulldev = uicontrol('Style','text','Units','inches',...
            'Position',[0 2.24 1.5 1.0],'String','Fully Developed?',...
            'FontSize',16,'Tag','Button4');
        h.yes1 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 2.7 1.5 0.4],'String','Yes','Tag',...
            'Button4','Callback',@y1Pushed);
        h.no1 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 2.7 1.5 0.4],'String','No','Tag',...
            'Button4','Callback',@n1Pushed);
    end
end
function [] = y1Pushed(~,~)%Laminar fully-developed flow
global h
reset4Pushed();
    if h.yes1.Value == 1
        h.no1.Value = 0;
        h.bc2Txt = uicontrol('Style','text','Units','inches',...
            'Position',[0 1.5 1.5 1.0],'String','Boundary Condition',...
            'FontSize',16,'Tag','Button5');
        h.chf4 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 1.9 1.5 0.55],'Tag','Button5','String',...
            '<html>Constant Surface<br><div align="center">Heat Flux',...
            'Callback',@chf4Pushed);
        h.cst = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 1.9 1.5 0.55],'Tag','Button5','String',...
            '<html>Constant Surface<br><div align="center">Temperature',...
            'Callback',@cstPushed);
    end
end

function [] = chf4Pushed(~,~)%Lam full-dev constant heat flux
global h
reset5Pushed();
h.moveEval = 1;
if h.chf4.Value == 1
    evalButton()
end
    h.cst.Value = 0;
    h.h = 4.36*h.k/h.D;
end

function [] = cstPushed(~,~)%Lam full-dev constant surface temp
global h
reset5Pushed();
h.moveEval = 1;
if h.cst.Value == 1
    evalButton()
end
    h.chf4.Value = 0;
    h.h = 3.66*h.k/h.D;
end

function [] = n1Pushed(~,~)%Laminar not fully-developed flow
global h
reset4Pushed();
    if h.no1.Value == 1
        h.yes1.Value = 0;
        h.entTxt = uicontrol('Style','text','Units','inches',...
            'Position',[0.35 1.5 0.8 1.0],'String','Entry Length',...
            'FontSize',16,'Tag','Button5');
        h.tent = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 2.0 1.5 0.4],'String','Thermal','Tag',...
            'Button5','Callback',@tentPushed);
        h.cent = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 2.0 1.5 0.4],'String','Combined','Tag',...
            'Button5','Callback',@centPushed);
    end
end

function [] = tentPushed(~,~)%8.57 Thermal Entry Length Problem
global h
reset5Pushed();
h.moveEval = 1;
if h.tent.Value == 1
    evalButton()
end
    h.cent.Value = 0; h.moveEval = 1;
    Gzd = (h.D/h.x)*h.Re*h.Pr;
    h.h = (3.66 + (0.0668*Gzd/(1+(0.04*Gzd^(2/3)))))*h.k/h.D;
end

function [] = centPushed(~,~)%8.58 Combined Entry Length Problem
global h
reset5Pushed();
h.moveEval = 1;
if h.cent.Value == 1
    evalButton()
end
    h.tent.Value = 0; h.moveEval = 1;
    Gzd = (h.D/h.x)*h.Re*h.Pr;
    h.h = (((3.66/tanh(2.264*Gzd^(-1/3)+1.7*Gzd^(-2/3)))+0.0499*Gzd*...
        tanh(Gzd^(-1)))/tanh(2.432*h.Pr^(1/6)*Gzd^(-1/6)))*h.k/h.D;
end

function [] = turb2Pushed(~,~)%Internal circular cross section flow laminar
global h
reset3Pushed();
    if h.turb2.Value == 1
            h.lam2.Value = 0;
            h.flowtype3 = uicontrol('Style','text','Units','inches',...
                'Position',[0 2.24 1.5 1.0],'String','Fully Developed?',...
                'FontSize',16,'Tag','Button4');
            h.yes2 = uicontrol('Style','togglebutton','Units','inches',...
                'Position',[1.4 2.7 1.5 0.4],'String','Yes','Tag',...
                'Button4','Callback',@y2Pushed);
            h.no2 = uicontrol('Style','toggle','Units','inches',...
                'Position',[3.0 2.7 1.5 0.4],'String','No','Tag',...
                'Button4','Callback',@n2Pushed);
    end
end

function [] = y2Pushed(~,~)%Internal circular cross section turbulent flow
global h
reset4Pushed();
    if h.yes2.Value == 1
        h.no2.Value = 0;
        h.propTxt = uicontrol('Style','text','Units','inches',...
            'String','Defining Property','FontSize',16,...
            'Position',[0 1.5 1.5 1.0],'Tag','Button5');
        h.smooth = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 2.0 1.5 0.4],'String','Smooth Tube','Tag',...
            'Button5','Callback',@smoothPushed);
        h.lvar = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 2.0 1.5 0.4],'String','Large Variations',...
            'Tag','Button5','Callback',@lvarPushed);
        h.rough = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[4.6 2.0 1.5 0.4],'String','Rough Tube','Tag',...
            'Button5','Callback',@roughPushed);
    end
end

function [] = smoothPushed(~,~)%8.58 Combined Entry Length Problem
global h
reset5Pushed();
    if h.smooth.Value == 1
        h.lvar.Value = 0; h.rough.Value = 0;
        h.tempTxt = uicontrol('Style','text','Units','inches',...
            'String','Heat Flux','FontSize',16,'Tag',...
            'Button6','Position',[0 0.7 1.5 1.0]);
        h.heat = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 1.3 1.5 0.4],'String','Heating','Tag',...
            'Button6','Callback',@heatPushed);
        h.cool = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 1.3 1.5 0.4],'String','Cooling','Tag',...
            'Button6','Callback',@coolPushed);
    end
end

function [] = heatPushed(~,~)%8.60 Circular x-sec smooth tube turbulent
global h
reset6Pushed();
h.moveEval = 0;
if h.heat.Value == 1
    evalButton()
end
    h.cool.Value = 0;
    if (0.6 <= h.Pr) && (h.Pr <= 160) &&...
             (10^4 <= h.Re) && (10 <= h.L/h.D) 
        h.h = (0.0243*h.Re^(4/5)*h.Pr^0.4)*h.k/h.D;
    else
        h.h = ['Sorry, h could not be calculated. '...
            'Pr must be in the interval [0.6,160].'];
    end
end

function [] = coolPushed(~,~)%8.60 Circular x-sec smooth tube turbulent
global h
reset6Pushed();
h.moveEval = 0;
if h.cool.Value == 1
    evalButton()
end
    h.heat.Value = 0;
    if (0.6 <= h.Pr) && (h.Pr <= 160) &&...
        (10^4 <= h.Re) && (10 <= h.L/h.D) 
        h.h = (0.0265*h.Re^(4/5)*h.Pr^0.3)*h.k/h.D;
    else
        h.h = ['Sorry, h could not be calculated. '...
            'Pr must be in the interval [0.6,160], '...
            'Re must be greater than or equal to 10^4 '...
            'and the ratio of tube length to diameter '...
            'must be greater than or equal to 10.'];
    end
end

function [] = lvarPushed(~,~)%8.61 Combined Entry Length Problem CHECK EQUATION
global h
reset5Pushed();
h.moveEval = 0;
  if h.lvar.Value == 1
      evalButton()
  end
    h.smooth.Value = 0; h.rough.Value = 0;
    h.addPam = uicontrol('Style','text','Units','inches',...
        'Position',[0.15 0.8 1.25 1.0],'String',...
        'Additional Parameters','FontSize',16,'Tag','Button6');
    h.mumusTxt = uicontrol('Style','text','Units','inches',...
        'Position',[1.7 1.3 1.0 0.3],'String','mu/mu_s =',...
        'Tag','Button6','FontSize',12);
    h.mumusVal = uicontrol('Style','edit','Units','inches',...
        'Position',[2.7 1.3 0.7 0.3],'Value',h.mumus,'String',...
        h.mumus,'Tag','Button6','CallBack',@val_mumus);
    if (0.7<=h.Pr) && (h.Pr<=16700) && (h.Re>=10000) && ((h.L/h.D)>=10)
        h.h = (0.027*h.Re^(4/5)*h.Pr^(1/3)*h.mumus^0.14)*h.k/h.D;
    else 
        h.h = ['Sorry, h could not be calculated. Values for Pr '...
            'must be in between 0.7 and 16700, Re must be greater '...
            'than 10,000 and the ratio of L to D must be greater '...
            'than or equal to 10.'];
    end
end

function [] = n2Pushed(~,~)%Turbulent not fully-developed flow
global h
reset4Pushed();
    if h.no2.Value == 1
        h.yes2.Value = 0;
        h.Sorry = uicontrol('Style','text','Units','inches',...
            'Position',[2.5 2.0 1.5 0.4],'String',...
            'Consult Literature.','Tag','Button5');
    end
end

function [] = roughPushed(~,~)%8.62 Rough Circular Tubes!
global h
reset5Pushed();
h.moveEval = 1;
if h.rough.Value == 1
    evalButton()
end
    h.lvar.Value = 0; h.smooth.Value = 0;
     if (0.5<=h.Pr) && (h.Pr<=2000) && (3000<=h.Re) && (h.Re<=5*10^6)
        f = (0.79*log(h.Re)-1.64)^-2;
        h.h = (f/8)*(h.Re-1000)*h.Pr/(1 +12.7*(f/8)^(1/2)*...
            (h.Pr^(2/3)-1))*h.k/h.D;
     else 
         h.h = ['Sorry, h could not be calculated. Pr must be '...
             'in between 0.5 and 2,000 and Re must be in '...
             'between 3,000 and 5*10^6.'];
     end
end

function [] = ncx1Pushed(~,~)%Non-circular cross section flow laminar
global h
reset2Pushed();
    if h.ncircXsec1.Value == 1
        h.circXsec1.Value = 0;
        sliderK2(), sliderD(), sliderL()
        h.flowtype3 = uicontrol('Style','text','Units','inches',...
            'Position',[0 2.8 1.5 1.0],'String','Flow Type',...
            'FontSize',16,'Tag','Button3');
        h.lam3 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 3.4 1.5 0.4],'String','Laminar','Tag',...
            'Button3','Callback',@lam3Pushed);
        h.turb3 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 3.4 1.5 0.4],'String','Turbulent','Tag',...
            'Button3','Callback',@turb3Pushed);
    end
end

function [] = lam3Pushed(~,~)%Internal circular cross section flow laminar
global h
reset3Pushed();
    if h.lam3.Value == 1
        h.turb3.Value = 0;
        h.fulldev4 = uicontrol('Style','text','Units','inches',...
            'Position',[0 2.24 1.5 1.0],'String','Fully Developed?',...
            'FontSize',16,'Tag','Button4');
        h.yes3 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 2.7 1.5 0.4],'String','Yes','Tag',...
            'Button4','Callback',@y3Pushed);
        h.no3 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 2.7 1.5 0.4],'String','No','Tag',...
            'Button4','Callback',@n3Pushed);
    end
end

function [] = y3Pushed(~,~)%Laminar fully-developed flow
global h
h.no3.Value = 0;
reset5Pushed();
    if h.yes3.Value == 1
        h.no3.Value = 0;
        h.ngeotxt = uicontrol('Style','text','Units','inches',...
            'String','Pipe Geometry & Heating Conditions','Tag',...
            'Button5','Position',[0.1 1.4 1.3 1.0],'FontSize', 10);
        h.ngeo = uicontrol('Style','popupmenu','Units','inches',...
            'Position',[3.55 1.95 2.0 0.4],'String',[{'Circle'},...
            {'Square'},{'Rect (b/a = 1.43)'},{'Rect (b/a = 2.0)'},...
            {'Rect (b/a = 3.0)'},{'Rect (b/a = 4.0)'},...
            {'Rect (b/a = 8.0)'},{'Rect (b/a = Inf)'}...
            {'Insl. rect (b/a = Inf)'},{'Triangle'}],'Tag',...
            'Button5','Callback',@ngeoSelected);
        h.ncond = uicontrol('Style','popupmenu','Units','inches',...
            'Position',[1.35 1.95 2.2 0.4],'String',...
            [{'Uniform Heat Flux'},{'Uniform Surface Temp'}],...
            'Tag','Button5','Callback',@ncondSelected);
    end
end

function [] = ngeoSelected(~,~)%table 8.1 avg h fully dev non-circ pipes
global h
reset5Pushed();
h.moveEval = 1;
if h.yes3.Value == 1
    evalButton()
end
    if h.ngeo.Value == 1  && h.ncond.Value == 1
        h.h = 4.36*h.k/h.D;
    elseif h.ngeo.Value == 1  && h.ncond.Value == 2
        h.h = 3.66*h.k/h.D;
    elseif h.ngeo.Value == 2 && h.ncond.Value == 1
        h.h = 3.61*h.k/h.D;
    elseif h.ngeo.Value == 2 && h.ncond.Value == 2
        h.h = 2.98*h.k/h.D;
    elseif h.ngeo.Value == 3 && h.ncond.Value == 1
        h.h = 3.73*h.k/h.D;
    elseif h.ngeo.Value == 3 && h.ncond.Value == 2
        h.h = 3.08*h.k/h.D;
    elseif h.ngeo.Value == 4 && h.ncond.Value == 1
        h.h = 4.12*h.k/h.D;
    elseif h.ngeo.Value == 4 && h.ncond.Value == 2
        h.h = 3.39*h.k/h.D;
    elseif h.ngeo.Value == 5 && h.ncond.Value == 1
        h.h = 4.79*h.k/h.D;
    elseif h.ngeo.Value == 5 && h.ncond.Value == 2
        h.h = 3.96*h.k/h.D;
    elseif h.ngeo.Value == 6 && h.ncond.Value == 1
        h.h = 5.33*h.k/h.D;
    elseif h.ngeo.Value == 6 && h.ncond.Value == 2
        h.h = 4.44*h.k/h.D;
    elseif h.ngeo.Value == 7 && h.ncond.Value == 1
        h.h = 6.49*h.k/h.D;
    elseif h.ngeo.Value == 7 && h.ncond.Value == 2
        h.h = 5.6*h.k/h.D;
    elseif h.ngeo.Value == 8 && h.ncond.Value == 1
        h.h = 8.23*h.k/h.D;
    elseif h.ngeo.Value == 8 && h.ncond.Value == 2
        h.h = 7.54*h.k/h.D;
    elseif h.ngeo.Value == 9 && h.ncond.Value == 1
        h.h = 5.39*h.k/h.D;
    elseif h.ngeo.Value == 9 && h.ncond.Value == 2
        h.h = 4.86*h.k/h.D;
    elseif h.ngeo.Value == 10 && h.ncond.Value == 1
        h.h = 3.11*h.k/h.D;
    elseif h.ngeo.Value == 10 && h.ncond.Value == 2
        h.h = 2.49*h.k/h.D;
    else
        h.h = ['Sorry, h could not be calculated. Push reset '...
            'or try using a different value for Re.'];
    end
    h.moveEval = 1;
end

function [] = ncondSelected(~,~)%Allows selection of surface condition
end

function [] = n3Pushed(~,~)%Laminar not fully-developed flow
global h
reset4Pushed();
h.moveEval = 0;
    if h.no3.Value == 1
        h.yes3.Value = 0;
        h.h = 'Consult Literature.';
    end
    h.hTxt = uicontrol('Style','text','Units','inches','Tag','h',...
            'Position',[1.8 1.2 3.25 1.2],'FontSize',12,'String',h.h);
        
end

function [] = turb3Pushed(~,~)%Internal circular cross section flow laminar
global h
reset3Pushed();
    if h.turb3.Value == 1
            h.lam3.Value = 0;
            h.fulldev5 = uicontrol('Style','text','Units','inches',...
                'Position',[0 2.24 1.5 1.0],'String','Fully Developed?',...
                'FontSize',16,'Tag','Button4');
            h.yes4 = uicontrol('Style','togglebutton','Units','inches',...
                'Position',[1.4 2.7 1.5 0.4],'String','Yes','Tag',...
                'Button4','Callback',@y4Pushed);
            h.no4 = uicontrol('Style','togglebutton','Units','inches',...
                'Position',[3.0 2.7 1.5 0.4],'String','No','Tag',...
                'Button4','Callback',@n4Pushed);
    end
end

function [] = y4Pushed(~,~)%Internal circular cross section turbulent flow
global h
reset4Pushed();
    if h.yes4.Value == 1
       h.no4.Value = 0;
        h.propTxt2 = uicontrol('Style','text','Units','inches',...
            'String','Defining Property','FontSize',16,...
            'Position',[0 1.5 1.5 1.0],'Tag','Button5');
        h.smooth2 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 1.95 1.5 0.4],'String','Smooth Tube','Tag',...
            'Button5','Callback',@smooth2Pushed);
        h.lvar2 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 1.95 1.5 0.4],'String','Large Variations',...
            'Tag','Button5','Callback',@lvar2Pushed);
        h.rough2 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[4.6 1.95 1.5 0.4],'String','Rough Tube','Tag',...
            'Button5','Callback',@rough2Pushed);
    end
end

function [] = smooth2Pushed(~,~)%8.58 Combined Entry Length Problem
global h
reset5Pushed();
    if h.smooth2.Value == 1
        h.lvar2.Value = 0; h.rough2.Value = 0;
        h.tempTxt2 = uicontrol('Style','text','Units','inches',...
            'String','Heat Flux','FontSize',16,'Tag',...
            'Button6','Position',[0 0.6 1.5 1.0]);
        h.heat2 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[1.4 1.2 1.5 0.4],'String','Heating','Tag',...
            'Button6','Callback',@heat2Pushed);
        h.cool2 = uicontrol('Style','togglebutton','Units','inches',...
            'Position',[3.0 1.2 1.5 0.4],'String','Cooling','Tag',...
            'Button6','Callback',@cool2Pushed);
    end
end

function [] = heat2Pushed(~,~)%8.60 Circular x-sec smooth tube turbulent
global h
reset6Pushed();
h.moveEval = 0;
if h.heat2.Value == 1
    evalButton()
end
    h.cool2.Value = 0;
    h.h = (0.0243*h.Re^(4/5)*h.Pr^0.4)*h.k/h.D;
end

function [] = cool2Pushed(~,~)%8.60 Circular x-sec smooth tube turbulent
global h
reset6Pushed();
h.moveEval = 0;
if h.cool2.Value == 1
    evalButton()
end
    h.heat2.Value = 0;
    if (0.6 <= h.Pr) && (h.Pr <= 160) &&...
        (10^4 <= h.Re) && (10 <= h.L/h.D) 
        h.h = (0.0265*h.Re^(4/5)*h.Pr^0.3)*h.k/h.D;
    else
        h.h = ['Sorry, h could not be calculated. Pr must '...
            'be in between 0.6 and 160, Re must be greater '...
            'than or equal to 10^4 and the ratio of tube '...
            'length to diameter must be greater than or equal to 10.'];
    end
end

function [] = lvar2Pushed(~,~)%8.61 Combined Entry Length Problem
global h
reset5Pushed();
h.moveEval = 0;
if h.lvar2.Value == 1
    evalButton()
end
    h.smooth2.Value = 0; h.rough2.Value = 0;
    h.addPam = uicontrol('Style','text','Units','inches',...
        'Position',[0.15 0.8 1.25 1.0],'String',...
        'Additional Parameters','FontSize',16,'Tag','Button6');
    h.mumusTxt = uicontrol('Style','text','Units','inches',...
        'Position',[1.7 1.3 1.0 0.3],'String','mu/mu_s =',...
        'Tag','Button6','FontSize',12);
    h.mumusVal = uicontrol('Style','edit','Units','inches',...
        'Position',[2.7 1.3 0.8 0.3],'Value',h.mumus,'String',...
        h.mumus,'Tag','Button6','CallBack',@val_mumus);
    if (0.7<=h.Pr) && (h.Pr<=16700) && (h.Re>=10000) && ((h.L/h.D)>=10)
        h.h = (0.027*h.Re^(4/5)*h.Pr^(1/3)*h.mumus^0.14)*h.k/h.D;
    else
        h.h = ['Sorry, h could not be calculated. Values for '...
            'Pr must be in between 0.7 and 16700, Re must '...
            'be greater than 10,000 and the ratio of L to D'...
            ' must be greater than or equal to 10.'];
    end
end

function [] = rough2Pushed(~,~)%8.62 Rough Circular Tubes!
global h
reset5Pushed();
h.moveEval = 1;
if h.rough2.Value == 1
    evalButton()
end
    h.lvar2.Value = 0; h.smooth2.Value = 0;
     if (0.5<=h.Pr) && (h.Pr<=2000) && (3000<=h.Re) && (h.Re<=5*10^6)
        f = (0.79*log(h.Re)-1.64)^-2;
        h.h = (f/8)*(h.Re-1000)*h.Pr/(1 +12.7*(f/8)^(1/2)*...
            (h.Pr^(2/3)-1))*h.k/h.D;
     else 
        h.h = ['Sorry, h could not be calculated. Pr must '...
            'be in between 0.5 and 2000 and Re must '...
            'be in between 3000 and 5*10^6.'];
     end
     h.moveEval = 1;
end


function [] = n4Pushed(~,~)%Turbulent not fully-developed flow
global h
reset4Pushed();
    if h.no4.Value == 1
        h.yes4.Value = 0;
        h.Whoops = uicontrol('Style','text','Units','inches',...
            'Position',[2.6 2.0 1.5 0.4],'String',...
            'Consult Literature.','Tag','Button5','FontSize',12);
    end
end
%% Functions for people who need help

function [] = resetExt(~,~)
global h
topButton = findobj('Tag', 'intButt');
set(topButton, 'Value', 0)
buttons2 = findobj('Tag', 'Button2');
set(buttons2, 'Visible', 'Off', 'Value', 0)
buttons3 = findobj('Tag', 'Button3');
set(buttons3, 'Visible', 'Off', 'Value', 0)
buttons4 = findobj('Tag', 'Button4');
set(buttons4, 'Visible', 'Off', 'Value', 0)
buttons5 = findobj('Tag', 'Button5');
set(buttons5, 'Visible', 'Off', 'Value', 0)
buttons6 = findobj('Tag', 'Button6');
set(buttons6, 'Visible', 'Off', 'Value', 0)
buttons7 = findobj('Tag', 'Button7');
set(buttons7, 'Visible', 'Off', 'Value', 0)
h.h = findobj('Tag', 'h');
set(h.h, 'Visible', 'Off')
end

function [] = resetInt(~,~)
global h
topButton = findobj('Tag', 'extButt');
set(topButton, 'Value', 0)
buttons2 = findobj('Tag', 'Button2');
set(buttons2, 'Visible', 'Off', 'Value', 0)
buttons3 = findobj('Tag', 'Button3');
set(buttons3, 'Visible', 'Off', 'Value', 0)
buttons4 = findobj('Tag', 'Button4');
set(buttons4, 'Visible', 'Off', 'Value', 0)
buttons5 = findobj('Tag', 'Button5');
set(buttons5, 'Visible', 'Off', 'Value', 0)
buttons6 = findobj('Tag', 'Button6');
set(buttons6, 'Visible', 'Off', 'Value', 0)
buttons7 = findobj('Tag', 'Button7');
set(buttons7, 'Visible', 'Off', 'Value', 0)
h.h = findobj('Tag', 'h');
set(h.h, 'Visible', 'Off')
end

function [] = resetPushed(~,~)
global h
intButt = findobj('Tag', 'intButt');
extButt = findobj('Tag','extButt');
set(intButt, 'Value', 0)
set(extButt, 'Value', 0)
buttons2 = findobj('Tag', 'Button2');
set(buttons2, 'Visible', 'Off', 'Value', 0)
buttons3 = findobj('Tag', 'Button3');
set(buttons3, 'Visible', 'Off', 'Value', 0)
buttons4 = findobj('Tag', 'Button4');
set(buttons4, 'Visible', 'Off', 'Value', 0)
buttons5 = findobj('Tag', 'Button5');
set(buttons5, 'Visible', 'Off', 'Value', 0)
buttons6 = findobj('Tag', 'Button6');
set(buttons6, 'Visible', 'Off', 'Value', 0)
buttons7 = findobj('Tag', 'Button7');
set(buttons7, 'Visible', 'Off', 'Value', 0)
h.h = findobj('Tag', 'h');
set(h.h, 'Visible', 'Off')
end

function [] = reset2Pushed(~,~)
global h
buttons3 = findobj('Tag', 'Button3');
set(buttons3, 'Visible', 'Off', 'Value', 0)
buttons4 = findobj('Tag', 'Button4');
set(buttons4, 'Visible', 'Off', 'Value', 0)
buttons5 = findobj('Tag', 'Button5');
set(buttons5, 'Visible', 'Off', 'Value', 0)
buttons6 = findobj('Tag', 'Button6');
set(buttons6, 'Visible', 'Off', 'Value', 0)
buttons7 = findobj('Tag', 'Button7');
set(buttons7, 'Visible', 'Off', 'Value', 0)
h.h = findobj('Tag', 'h');
set(h.h, 'Visible', 'Off')
end

function [] = reset3Pushed(~,~)
global h
buttons4 = findobj('Tag', 'Button4');
set(buttons4, 'Visible', 'Off', 'Value', 0)
buttons5 = findobj('Tag', 'Button5');
set(buttons5, 'Visible', 'Off', 'Value', 0)
buttons6 = findobj('Tag', 'Button6');
set(buttons6, 'Visible', 'Off', 'Value', 0)
buttons7 = findobj('Tag', 'Button7');
set(buttons7, 'Visible', 'Off', 'Value', 0)
h.h = findobj('Tag', 'h');
set(h.h, 'Visible', 'Off')
end

function [] = reset4Pushed(~,~)
global h
buttons5 = findobj('Tag', 'Button5');
set(buttons5, 'Visible', 'Off', 'Value', 0)
buttons6 = findobj('Tag', 'Button6');
set(buttons6, 'Visible', 'Off', 'Value', 0)
buttons7 = findobj('Tag', 'Button7');
set(buttons7, 'Visible', 'Off', 'Value', 0)
h.h = findobj('Tag', 'h');
set(h.h, 'Visible', 'Off')
end


function [] = reset5Pushed(~,~)
global h
buttons6 = findobj('Tag', 'Button6');
set(buttons6, 'Visible', 'Off', 'Value', 0)
buttons7 = findobj('Tag', 'Button7');
set(buttons7, 'Visible', 'Off', 'Value', 0)
h.h = findobj('Tag', 'h');
set(h.h, 'Visible', 'Off')
end

function [] = reset6Pushed(~,~)
global h
buttons7 = findobj('Tag', 'Button7');
set(buttons7, 'Visible', 'Off', 'Value', 0)
h.h = findobj('Tag', 'h');
set(h.h, 'Visible', 'Off')
end

function [] = resethPushed(~,~)
global h
h.hTxt = findobj('Tag', 'h');
set(h.hTxt, 'Visible', 'Off')
end

function [] = explode(~,~)
clf
explosion = imread('explode.jpg');
imshow(explosion)
web('https://bit.ly/IqT6zt', '-browser')
end
%% Callback for parameters

%mumus
function [] = val_mumus(varargin)
global h
h.mumusVal = varargin{[1,3]};
h.mumus = str2double(h.mumusVal.String);
end

%Pr
function [] = val_Pr(varargin)
global h
h.PrVal = varargin{[1,3]};
h.Pr = str2double(h.PrVal.String);
end

%Re
function [] = val_Re(varargin)
global h
h.ReVal = varargin{[1,3]};
h.Re = str2double(h.ReVal.String);
end

%Rexc
function [] = val_Rexc(varargin)
global h
h.RexcVal = varargin{[1,3]};
h.Rexc = str2double(h.RexcVal.String);
end

%D
function [] = slider_D(varargin)
global h
D = varargin{[1,3]};
val_D = D.Value;
set(h.DTxt,'String',['D = ' num2str(round(val_D,3)) ' m']);
h.D = val_D;
end

%L
function [] = slider_L(varargin)
global h
L = varargin{[1,3]};
val_L = L.Value;
set(h.LTxt,'String',['L = ' num2str(round(val_L,2)) ' m']);
h.L = val_L;
end

%k
function [] = slider_k(varargin)
global h
k = varargin{[1,3]};
val_k = k.Value;
set(h.kTxt,'String',['k = ' num2str(round(val_k,3)) ' W/(m·K)']);
h.k = val_k;
end
function [] = slider_k2(varargin)
global h
k = varargin{[1,3]};
val_k = k.Value;
set(h.kTxt,'String',['k = ' num2str(round(val_k,3)) ' W/(m·K)']);
h.k = val_k;
end

%x
function [] = slider_x(varargin)
global h
x = varargin{[1,3]};
val_x = x.Value;
set(h.xTxt,'String',['x = ' num2str(round(val_x,2)) ' m']);
h.x = val_x;
end