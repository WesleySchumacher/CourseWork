%--------------------
% MCEN 3030
% Spring 2020
% Example with 3D surface plots
%--------------------
clear all
clc
close all

% generate a grid of coordinates to evaluate
[X,Y]=meshgrid([-5:.1:5],[-10:.1:10]);

[n m]=size(X);

for i = 1:n
    for j = 1:m
        
        % vertical function Z is equation of 
        % a sphere over (2,3).
        Z(i,j) = (X(i,j) - 2).^2 + (Y(i,j) +3)^2;
         
    end
end

meshc(X,Y,Z)