%Drum Cymbals as a Spring mass Damper
G = tf(1, [1 0.1 1])
%smaller damping
figure(1)
impulse(G)
G2 = tf(1, [1 0.5 1])
figure(2)
impulse(G, G2)
G3 = tf(1, [1 0.5 1])
figure(3)
impulse(G, G2, G3)