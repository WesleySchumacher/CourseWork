close all; clc; clear all

% domain 
L = 1;
d = L/100;
n = L/d + 1;

% constants
b = 1;
a = 1;
q = 50;
g = b*d/a;

%allocate a solution array
kmax = 1000;
T = zeros(n,n,kmax);


%define Dirichlet Bcs
T(:,1,:) = 298; % bottom hand edge
T(1,:,:) = 298; % left hand side 
T(:,n,:) = 298; % top side

%initial guess
T(:,:,:) = 298; % top side

%iterate using liebmann method
for k = 1:kmax-1
    
    %loop over nodes where Tij is unknown
    for i = 2:n
        for j = 2:n-1
            %handle derivative DC
            if i == n
                T(i,j,k+1) = 1/4*( 2 *T(i-1,j,k) -2*q*d/a + T(i,j-1,k) + T(i,j+1,k) + g*(i-1));
                
            
            else
                
             T(i,j,k+1) = 1/4*( T(i-1,j,k) + T(i+1,j,k) + T(i,j-1,k) + T(i,j+1,k) + g*(i-1));
            end
        end
    end
    
    err = norm( T(:,:,k) - T(:,:,k+1));
    
    if err < 1e-03
        break
    end
    
    
end





% make 3D plot - take transpose so oriented correctly
[X,Y] = meshgrid(0:d:L,0:d:L);
surf(X,Y,T(:,:,k+1)')
xlabel('x')
ylabel('y')
zlabel('T')