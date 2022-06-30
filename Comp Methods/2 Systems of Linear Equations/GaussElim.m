%--------------------
% MCEN 3030
% Spring 2020
% L02 in class
% Gauss Elimination
%--------------------
function[Am,bm] = GaussElim(A,b)
% The function solve a system of linear equations [a][x]=[b] using the Gauss
% elimination method.
% Input variables:
% a  The matrix of coefficients.
% b  A column vector of constants.
% Output variable:
% A  Upper triangular matrix A
% b  Modified vector of constants b

AB = [A,b];
[r, c] = size(AB);
for j = 1:r-1
    for i = j+1:r
        AB(i,j:c) = AB(i,j:c)-AB(i,j)/AB(j,j)*AB(j,j:c);
    end
end
Am = AB(:,1:c-1);
bm = AB(:,c);

end
