close all; clc; clear all

% domain
L = 1;
d = L/100;
n = L/d + 1;

% constants
b = 1;
a = 1;
q = 50;
g = b*d^2/a;

% allocate solution array
kmax = 20000;

% T(x,y,iteration)
T = zeros(n,n,kmax);

% Dirichlet BC's
T(:,:,1) = 298;  % initial guess to help things converge faster
T(:,1,:) = 298;  % bottom
T(1,:,:) = 298;  % left
T(:,n,:) = 298;  % top


% use Liebmann method
for k = 1:kmax-1
    
    for i = 2:n
        for j = 2:n-1
            
            % Derivative boundary condition at right side (i=n)
            if i == n
                
                T(i,j,k+1) = 1/4*(2*T(i-1,j,k)-2*q*d/a+T(i,j-1,k)+T(i,j+1,k) + g*(i-1));
                
            % interior nodes
            else
                
                T(i,j,k+1) = 1/4*(T(i-1,j,k)+T(i+1,j,k)+T(i,j-1,k)+T(i,j+1,k) + g*(i-1));
                
            end
            
        end
    end
    
    err = norm(T(:,:,k+1)-T(:,:,k));
    
    % note: for problems with small dx, it can take many many iterations 
    if err < 1d-3
        display('converged!')
        break
        
    end
end

% make 3D plot - take transpose so oriented correctly
[X,Y] = meshgrid(0:d:L,0:d:L);
surf(X,Y,T(:,:,k+1)')
xlabel('x')
ylabel('y')
zlabel('T')