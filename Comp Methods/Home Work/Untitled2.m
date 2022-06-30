    
    h = 0.05;
    tol = 0.01;
    x = [0:h:Lx];
    y = [0:h:Ly];
    
    nx = length(x);
    ny = length(y);
    
    T(:,1) = Tb;
    T(end,:) = Tc;
    T(:,end) = Td;
%     T(end,end) = (Td+Tc)/2;
%     T(end,1) = (Tb+Tc)/2;
    
    T(1:nx,1:ny) = 1/3*(Tb+Tc+Td);
    
    
    error = 1000;
    while error > tol
        for i= 1:nx-1
            for j = 2:ny-1
                
                if (i-1) == 0
                     T(i,j) = 1/4*( T(2,j) - 2*h*q + T(i+1,j) + T(i,j-1) + T(i,j+1));
                    
                else
                   T(i,j) = 1/4*( T(i-1,j) + T(i+1,j) + T(i,j-1) + T(i,j+1));
                end
                
                
            end           
        end
        error = norm( T(:,:));
    end

    %To make another graph, figure
    if (Ly > 1)
        figure(2);
    end
    
    %make 3D plot - take transpose so oriented correctly
    [X,Y] = meshgrid(0:dx:Lx,0:dy:Ly);
    surf(X,Y,T(:,:)')
    xlabel('x')
    ylabel('y')
    zlabel('T')
    
    out = mean(mean(T(:,:)));
    
    
    
    
    
    
    
    %%%%%Problem 3 plot forloop
    % for i = 1:length(y)
%     if mod(i,10) == 0
%         hold on
%         plot(x3,[y(i,:) Tb3])
%     end
% end
