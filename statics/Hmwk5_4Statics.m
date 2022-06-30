%%
% MCEN 2023 Statics & Structures
% Homework #5 (Chapter 5)
% Question #
% MEID: 627-566

theta = [0:90];
P=(69.64096774 * sind(theta));
plot(theta,P);
xlabel('Theta(degrees)')
ylabel('Force at P (Newtons)')
title('P due to varable theta')
legend({'The change in P while lifting the hand truck '},'Location','southwest')