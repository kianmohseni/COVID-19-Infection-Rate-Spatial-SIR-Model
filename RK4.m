%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Title: Implementing the Fourth-Order Runge-Kutta Algorithm
% Description: This function is designed to solve differential equations
% using the Fourth-Order Runge-Kutta Algorithm with a fixed time step
% size equal to 0.1 seconds. It is a stand alone ODE solver, similar to
% MATLAB's built-in ode45 function.
% Name: Kian Mohseni 
% UID: 505084983
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [t, y] = RK4(f, tspan, y0)

% RK4 Numerically solves the differential equation using the fourth-order Runge-Kutta algorithm
% Inputs:
% f: function handle of f(t, y)
% tspan: the time period for simulation (should be a 1x2 array contain start time and end time)
% y0: the initial conditions for the differential equation
% Outputs:
% t: corresponding time sequence as a T x 1 vector
% y: the solution of the differential equation as a T x n matrix, where T is the number of time steps and n is the dimension of y0


h = 0.1;  % Time step size

t = tspan(1):h:tspan(2);  % Create a time vector that spans from the start time (first element of tspan) to the end time (second element of tspan) and increases by h each step.

t = transpose(t);   % Take the transpose of t to make it a column vector

y = zeros(length(t), length(y0));   % Preallocate a Txn matrix y to represent the solution of the differential equation

y(1,:) = y0;  % Make the first row of the output y equal to the initial condition y0

y_n = y0;    % Store the initial condition y0 to be the first value of y_n used in the for loop 

nSteps = length(t) - 1;   % Determine the number of steps to be 1 smaller than the length of the time vector.

% Run a for loop with the number of iterations equal to the number of steps to update t(k) and y(k) with the initial conditions t(1)=tspan(1) and y(1)=y_n.
for k=1:nSteps
    
     t_n = t(k);  % Update t_n for each iteration to represent the next value in the time vector
     
     % Implement the Fourth Order Runge-Kutta Method using the appropriate slope equations
     k1 = f(t_n, y_n);
     k2 = f(t_n+(h/2),y_n+(h*k1/2));
     k3 = f(t_n+(h/2),y_n+(h*k2/2));
     k4 = f(t_n+h,y_n+(h*k3));
     
     y_nplus1 = y_n + h*((k1+(2*k2)+(2*k3)+k4)/6);   % Use an intermediate variable called y_nplus1 to store the new value of y_n
     y(k+1,:) = y_nplus1;  % For every kth iteration, store the value of y_nplus1 into the k+1 row of the y matrix. Essentially calculating one row of y during each iteration of the loop, where each row represents the state of the system at a particular instance of time.
     y_n = y_nplus1;    % Place the value of y_nplus1 back into y_n for it to be used in the next iteration of the loop.
    
       
end


end
