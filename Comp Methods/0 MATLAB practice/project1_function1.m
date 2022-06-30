function [A,b] = createMat(n,m)
%inputs N, M
%outputs A, b
% 
A = magic(n) + eye(n) * m;
%create a matix

b = zeros(1,n);
%create a vector
for i = 1:n
    b(i) = 1/i;
end

end