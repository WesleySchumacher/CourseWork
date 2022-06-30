%% Wesley Schumacher
% ME ID:627-566
% MCEN 3022 Heat Transfer
% Fall 2020
% Homework #2


t = 0:10:200;
changeT = 2;
k = 0.25;
r1= 0.010;
h = 10;

q = changeT ./ ( (log(t/r1)./ 2* pi * k) + 1./( h * 2 * pi *t));

plot(t, q)
xlabel("t")
ylabel("q")