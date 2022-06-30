m = 1;
b = 0.1;
k = 1;
Num = 1;
Dem = [m b k]
roots(Dem)
G = tf(Num,Dem)

zpk(G)
Num = [m 5 k]
G = tf(Num,Dem)
zpk(G)
step(G)