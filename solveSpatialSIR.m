%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Title: Solving the Dynamics Model
% Description: This function is designed to solve the spatial SIR model
% using an ODE solver function handle passed in as an argument and the
% output will be a 4D matrix x that represents the state vs time of the
% data.
% Name: Kian Mohseni 
% UID: 505084983
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [t, x] = solveSpatialSIR(tFinal, initialCondition, alpha, beta, gamma, odeSolver)

% solveSpatialSIR Solve the spatial SIR model
% Inputs:
% tFinal: end time for the simulation (assuming start is t=0)
% initialCondition: a MxNx3 matrix that sums to 1 in third dimension
% alpha, beta, gamma: model parameters
% odeSolver: a function handle for an ode45-compatible solver
% Outputs:
% t: a vector of the time-steps
% x: MxNx3xlength(t) matrix representing the state vs. time


% Infer size of grid from initial conditions
S = size(initialCondition);

% S is an array of dimensions of the initialCondition matrix, where the
% first dimension represents M and the second dimension represents N
M = S(1);
N = S(2);

y0 = initialCondition(:);   % Vectorize the initialCondition matrix so that it's compatible with the RK4 and ode45 solver functions

tspan = [0 tFinal];   % Define the array tspan that will be used as an input of the odeSolver function

% Wrap the function in our dynamicsSIR function. The output of the
% dynamicsSIR function is used as an input for the odeSolver with the
% appropriate handle notation. In the case of RK4, the output of
% dynamicsSIR would be the input f. The output of odeSolver is t (a vector of
% the time-steps) and out a 2D Txn matrix.
[t, out] = odeSolver(@(t,x)dynamicsSIR(x, M, N, alpha, beta, gamma), tspan, y0);

% Initialize the MxNx3xlength(t) matrix that will be output to represent
% the state of the grid vs time.
x = zeros(M, N, 3, numel(t));

% Reshape out into a 4D matrix x that represents the state of the grid vs
% time. For every iteration of the time-steps vector, reshape the
% corresponding row of out to an MxNx3 matrix representing the state. Store
% this state in the first three dimensions of x for every time-step.
for i = 1:numel(t)
    x(:,:,:,i) = reshape(out(i,:),[M,N,3]);
end

end