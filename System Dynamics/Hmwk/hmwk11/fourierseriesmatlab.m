clear all;clc; close all;
syms x  
pi=3.14; 
sum=0;  
y=exp(x);   %function you want 
a0=(1/pi)*int(y,x,-pi,pi); 
for n=1:3 
        %finding the coefficients 
    an=(1/pi)*int(y*cos(n*x),x,-pi,pi); 
    bn=(1/pi)*int(y*sin(n*x),x,-pi,pi);    
    sum=sum+(an*cos(n*x)+bn*sin(n*x));  
end 
% https://www.instagram.com/koroshkorosh1/
ezplot(x,y,[-pi,pi]); 
grid on;hold on;  
ezplot(x,(sum+a0/2),[-pi,pi]); 
% https://www.instagram.com/koroshkorosh1/

% clear all;clc; 
% syms x  n pi
% % pi=3.14; 
% sum=0;  
% y=x   %function you want 
% a0=(1/pi)*int(y,x,-pi,pi) 
% % for n=1:5 
%         %finding the coefficients 
%     an=(1/pi)*int(y*cos(n*x),x,-pi,pi) 
%     bn=(1/pi)*int(y*sin(n*x),x,-pi,pi)    
%     sum=a0/2+(an*cos(n*x)+bn*sin(n*x)) 
% % end 
% ezplot(x,y,[-pi,pi])
% grid on;hold on;  
% ezplot(x,(sum+a0/2),[-pi,pi])
% % https://www.instagram.com/koroshkorosh1/
% syms x pi
% F =(1/pi) * int(x^2+5*x,'Hold',true)
% bn=(1/pi)*int(y*sin(n*x),x,-pi,pi), G = bn
% Gcalc = release(G)
% Fcalc = int(bn)
% clear all;clc; 
% syms x  pi n
% % pi=3.14; 
% sum=0;  
% y= x + (x^2) ;   %function you want 
% a0=(1/pi)*int(y,x,-pi,pi)  
% % for n=1:3 
%         %finding the coefficients 
%     an=(1/pi)*int(y*cos(n*x),x,-pi,pi)  
%     bn=(1/pi)*int(y*sin(n*x),x,-pi,pi)     
%     sum=sum+(an*cos(n*x)+bn*sin(n*x))   
% % end 
% % https://www.instagram.com/koroshkorosh1/
% ezplot(x,y,[-3.14,3.14]); 
% grid on;hold on;  
% ezplot(x,(sum+a0/2),[-3.14,3.14]) 
% % https://www.instagram.com/koroshkorosh1/