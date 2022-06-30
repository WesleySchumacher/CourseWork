Num = 20
Den = conv([1 2 2], [1 10])
G = tf(Num,Den)
zpk(G)
roots([1 2 2])
pole(G)
%yes this can be approximated as a 2nd order system
G2 = tf(20, [1 2 2])
figure(1)
step(G,G2)
G2 = tf((20/10), [1 2 2])
figure(2)
step(G,G2)