%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Title: Implementing the Dynamics Model
% Description: This function is designed to vectorize all the states used
% in our system to be compatible with the ODE solvers (RK4 and ode45). This
% will allow us to compute the rate of change of the model and simulate the
% system using both solvers.
% Name: Kian Mohseni 
% UID: 505084983
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dxdt = dynamicsSIR(x, M, N, alpha, beta, gamma)

% dynamicsSIR Compute the rate of change of the model
% Inputs:
% x: vectorized state
% M, N: size of the grid
% alpha, beta, gamma: model parameters
% Output:
% dxdt: vectorized time derivative of state

% Initialize the output vector
% dxdt = zeros(3*M*N, 1);


% Begin by devectorizing x and reshaping it into a 3D MxNx3 matrix.
devectorized = reshape(x, [M,N,3]);

S = devectorized(:,:,1);   % The data for susceptible individuals in the grid is in the first layer of the devectorized matrix.

I = devectorized(:,:,2);   % The data for infected individuals in the grid is in the second layer of the devectorized matrix.

W = zeros(M,N);   % Initialize a 2D matrix W that will store the summation of the weighting function multiplied by the number of surrounding infected individuals at each coordinate in the 2D grid. 


% Run through each coordinate in the grid to calculate W(i,j) at that
% location and store the values in the matrix W. Account for special cases
% like corners and edges of the grid where there will be less than 8
% surrounding neighbors. The value of the weighting function at the coordinate is 0. 
% The value of the weighting function for left, right, up, and down neighbors is 1 so 
% for each neighbor multiply their value of I by 1. The value of the weighting function 
% for upleft, upright, downleft, and downright neighbors is 1/sqrt(2) so for each neighbor
% divide their value of I by sqrt(2).
for i = 1:M
    for j = 1:N
        
        if i==1 && j==1      % Bottom Left Corner
            
            up = I(i,j+1);
            right = I(i+1,j);
            upright = (I(i+1,j+1))/sqrt(2);
            W(i,j) = up + right + upright;
            
        elseif i==1 && j==N    % Top Left Corner
            
            down = I(i,j-1);
            right = I(i+1,j);
            downright = (I(i+1,j-1))/sqrt(2);
            W(i,j) = down + right + downright;
            
        elseif i==M && j==1     % Bottom Right Corner
            
            up = I(i,j+1);
            left = I(i-1,j);
            upleft = (I(i-1,j+1))/sqrt(2);
            W(i,j) = up + left + upleft;
            
        elseif i==M && j==N   % Top Right Corner
            
            down = I(i,j-1);
            left = I(i-1,j);
            downleft = (I(i-1,j-1))/sqrt(2);
            W(i,j) = down + left + downleft;
            
        elseif i==1 && j~=1 && j~=N   % Left Edge
            
            up = I(i,j+1);
            down = I(i,j-1);
            right = I(i+1,j);
            upright = (I(i+1,j+1))/sqrt(2);
            downright = (I(i+1,j-1))/sqrt(2);
            W(i,j) = up + down + right + upright + downright;
            
        elseif i==M && j~=1 && j~=N    % Right Edge
            
            up = I(i,j+1);
            down = I(i,j-1);
            left = I(i-1,j);
            upleft = (I(i-1,j+1))/sqrt(2);
            downleft = (I(i-1,j-1))/sqrt(2);
            W(i,j) = up + down + left + upleft + downleft;
            
        elseif j==1 && i~=1 && i~=M    % Bottom Edge
            
            up = I(i,j+1);
            left = I(i-1,j);
            right = I(i+1,j);
            upleft = (I(i-1,j+1))/sqrt(2);
            upright = (I(i+1,j+1))/sqrt(2);
            W(i,j) = up + left + right + upleft + upright;
            
        elseif j==N && i~=1 && i~=M    % Top Edge
            
            down = I(i,j-1);
            left = I(i-1,j);
            right = I(i+1,j);
            downleft = (I(i-1,j-1))/sqrt(2);
            downright = (I(i+1,j-1))/sqrt(2);
            W(i,j) = down + left + right + downleft + downright;
           
        else    % Any other case where the coordinates are somewhere in the middle of the grid not at the boundaries and therefore they have 8 surrounding neighbors.
            
            up = I(i,j+1);
            down = I(i,j-1);
            left = I(i-1,j);
            right = I(i+1,j);
            upleft = (I(i-1,j+1))/sqrt(2);
            upright = (I(i+1,j+1))/sqrt(2);
            downleft = (I(i-1,j-1))/sqrt(2);
            downright = (I(i+1,j-1))/sqrt(2);
            W(i,j) = up + down + left + right + upleft + upright + downleft + downright;
          
        end
    end
end


% Initialize a 3D matrix to represent the state of the system in terms of
% its dynamics.
derivatives = zeros(M, N, 3);

% Implement the SIR dynamics given in Equations 4-6 of the problem
% statement to calculate the dynamics by running through all the
% coordinates in the grid. Apply the correct equation to each "layer" of
% the grid with the first layer corresponding to the susceptible
% individuals, the second layer corresponding to the infected individuals
% and the third layer corresponding to the recovered individuals.
for i = 1:M
    for j = 1:N
        derivatives(i,j,1) = -(beta * I(i,j) + alpha * W(i,j)) * S(i,j);
        derivatives(i,j,2) = ((beta * I(i,j) + alpha * W(i,j)) * S(i,j)) - (gamma * I(i,j));
        derivatives(i,j,3) = gamma * I(i,j);
    end
end

% Vectorize derivatives so that it is compatible with the ODE solvers RK4
% and ode45. In RK4, dynamicsSIR will be used as the input function handle f.
dxdt = derivatives(:);

end