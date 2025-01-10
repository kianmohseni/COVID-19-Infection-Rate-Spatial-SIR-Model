%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Title: Problem 2 Main Script
% Description: This script is designed to solve a Spatial SIR system on a
% grid of size 50 x 75 using our solveSpatialSIR function and comparing the
% performance of solving using our RK4 implementation compared to MATLAB's
% built-in ode45 solver. We'll also visualize the data using the
% plotTimeSeries and animate functions.
% Name: Kian Mohseni 
% UID: 505084983
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% This is to make sure the command window, all variables, and figures are 
% cleared so nothing but the script results are displayed.
clear all
close all
clc

%% Load Data

load('initialValues.mat');


% Define the initial conditions and parameters of the problem
alpha = 0.1;
beta = 0.05;
gamma = 0.1;
tFinal = 60;

% After loading initialValues.mat, a 3D matrix called initialConditions
% will be stored in our Workspace. We want M and N to be the first and
% second dimensions of this matrix, respectively. They'll be called in the
% dynamicsSIR function.
[M, N] = size(initialConditions, [1,2]);



%% Solve Spatial SIR Model

% Run the solveSpatialSIR function on both our RK4 solver and MATLAB's built-in ode45 solver 
% and then use the tic and toc commands to benchmark the runtime using both
% solvers. Then print the results into the output window using the fprintf command to compare their
% performances.


tic;

[t_RK4,x_RK4] = solveSpatialSIR(tFinal, initialConditions, alpha, beta, gamma, @RK4);

myRuntime_RK4 = toc;  % Store the runtime as a double


tic;

[t_ode45,x_ode45] = solveSpatialSIR(tFinal, initialConditions, alpha, beta, gamma, @ode45);

myRuntime_ode45 = toc;   % Store the runtime as a double


fprintf('The runtime results when using the RK4 solver are %.4f seconds.\n', myRuntime_RK4);
fprintf('The runtime results when using the ode45 solver are %.4f seconds.\n', myRuntime_ode45);


%% Plot Data

% Call the plotTimeSeries function on the system solved with my RK4 solver
% at three different grid coordinates.

plotTimeSeries(t_RK4, x_RK4, 1, 1);
plotTimeSeries(t_RK4, x_RK4, 5, 18);
plotTimeSeries(t_RK4, x_RK4, 30, 70);


%% 2D Animation 

animate(x_RK4);  % Generate a 2D visual animation of the system solved using RK4

