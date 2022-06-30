%--------------------
% MCEN 3030
% Spring 2020
% L02 in class
% BackSubs
%--------------------
function[x]=backsubs(A,b)
% inputs 
%   A  upper triang (n x n)
%   b  column vector (n x 1);
% output
%   x  solution to Ax = b
%----------------------------

% determine n
n = length(b);

% check system

% initialize x
x = zeros(n,1);

% initial value
x(n) = b(n)/A(n,n);

% loop to find other values

% % (a) 
% for i = n-1:1       -1 ISNT THERE
%     
% % (b) 
% for i = n:-1:1    NOT A GOOD CHOICE 
% 
% % (c) 
for i = n-1:-1:1    %THE RIGHT CHOICE
    
%     
% % (d) 
% for i = n:-1:1      SAME AS OF B

    % store summation in tmp
    tmp = 0;
    for j=i+1:n
        tmp = tmp + A(i,j)*x(j);
    end
    
    x(i) = ( b(i) - tmp ) / A(i,i);

end



end