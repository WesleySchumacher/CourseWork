A1 = [3, -0.1, -0.2;0.1,7,-0.3;0.3,-0.2,10]
for i = 1:length(A1)
    %Grapbing a row of the matrix 
    row = A1(i,:)
%     if abs(A(i,i)) < sum(abs(row))-abs(A(i,i)) 
%         out = 1;
%         warning('A is NOT diagonally dominant.')
%         break;
%     end
end