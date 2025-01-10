%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Title: Implementing the Fourth-Order Runge-Kutta Algorithm
% Description: This function is designed to solve differential equations
% using the Fourth-Order Runge-Kutta Algorithm with a fixed time step
% size equal to 0.1 seconds.
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
% y: the solution of the differential equation as a T x n matrix, where T is the number of time steps and n is the dimension of y


h = 0.1;  % Time step size

t = tspan(1):h:tspan(2);

t = transpose(t);

y = zeros(length(t), length(y0));

y(1,:) = y0;

% nSteps = (tspan(2)/h) + 1;  % Number of steps
% 
% t = zeros(nSteps, 1);   % Initialize a time column vector
% 
% % Preallocate y to be a Txn matrix and assign the first row of y to be y0
% y = zeros(nSteps, length(y0));
% y(1,:) = y0;  % Make the first row of the output y equal to the initial condition y0

y_n = y0;

nSteps = length(t)-1;

% Run a for loop to update t(k) and y(k) with the initial conditions t(1) and y(1)
for k=1:nSteps
    
     t_n = t(k);
     
     k1 = f(t_n, y_n);
     k2 = f(t_n+(h/2),y_n+(h*k1/2));
     k3 = f(t_n+(h/2),y_n+(h*k2/2));
     k4 = f(t_n+h,y_n+(h*k3));
     
     y_nplus1 = y_n + h*((k1+(2*k2)+(2*k3)+k4)/6);
     y(k+1,:) = y_nplus1;
     y_n = y_nplus1;
    
      
    
%     % Implement the four slope formulas of the fourth order Runge-Kutta method
%     k1 = h*(f(t(k),y(k,:)));
%     k2 = h*(f(t(k)+(h/2),y(k,:)+(k1/2)));
%     k3 = h*(f(t(k)+(h/2),y(k,:)+(k2/2)));
%     k4 = h*(f(t(k)+h,y(k,:)+k3));
%     
%     % Store t(k) and y(k) in t and y respectively
%     t(k) = t(k) + h;
%     y(k,:) = y(k,:) + ((k1+(2*k2)+(2*k3)+k4)/6);  % Update each row of y for each iteration which represents the state of the system at a particular instance of time
%       
end


end
