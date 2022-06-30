pi.^2/6
s = 0;
p = 10000000;
for v = 1.0:p
   s = s +( (1/(v.^2)));
end
disp(s)

s2 =0;
for n = p:-1:1
   s2 = s2 + ( (1/(n.^2)));
end
disp(s2)

s-s2

