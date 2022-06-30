%%
% MCEN 2023 Statics & Structures
% Homework #4 (Chapter 4)
% Question #3
% MEID: 627-566

theta = [14:70];
Ft=(0.292617*400*cosd(theta))/(0.065*cosd(5));
plot(theta,Ft);
xlabel('Theta(degrees)')
ylabel('Force T (Newtons)')
title('Ft due to varable theta')
legend({'Ft=(0.292617m*400N*cosd(theta))/(0.065m*cosd(5))'},'Location','southwest')