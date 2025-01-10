%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Title: Time Series Plotting
% Description: This function is designed to visualize a particular local
% SIR model by specifying its spacial coordinates and displaying how the
% ratio of infected, recovered, and susceptible individuals change over
% time at that location on the grid. The function uses subplots to place
% all three plots on the same figure.
% Name: Kian Mohseni 
% UID: 505084983
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function plotTimeSeries(t, X, x, y)

% plotTimeSeries: a function that plots and saves the local S.I.R distribution at spatial coordianate (x, y).
% Inputs:
% t: a vector of time steps
% X: an M*N*3*length(t) matrix, where each point in the M*N space
% corresponds to a local S.I.R. model with states whose values are between 0 and 1. This 3D matrix is repeated for each time step, making it a 4D matrix.
% x: the spatial x-coordinate on the grid
% y: the spatial y-coordinate on the grid
% Outputs:
% This function has no outputs

% Call the figure function to generate a new figure each time the
% plotTimeSeries function is run and store it in the variable h.
h = figure(1);

% Initialize column vectors to store the ratios of the susceptible,
% infected, and recovered individuals.
S = zeros(size(t,1));
I = zeros(size(t,1));
R = zeros(size(t,1));

% Run a for loop and iterate through the length of t to populate each group
% at the given grid coordinates specified in the plotTimeSeries input. 
for k=1:size(t)
    
    S(k) = X(x,y,1,k);   % Determine the ratio of susceptible individuals at the given grid coordinates at each time step by using the first layer of the X matrix.
    I(k) = X(x,y,2,k);   % Determine the ratio of infected individuals at the given grid coordinates at each time step by using the second layer of the X matrix.
    R(k) = X(x,y,3,k);   % Determine the ratio of recovered individuals at the given grid coordinates at each time step by using the third layer of the X matrix.
 
end
    

% Use the subplot command to create a 3x1 array of plots in the figure.
% Also use the sprintf command to include the specific grid coordinates
% (x,y) in the title string for each plot. Also set the appropriate axis
% limits as we know the ratio of each category can never exceed 1 and
% therefore ranges from 0 to 1. From top to bottom, we have the ratio of
% susceptible individuals vs time, then the ratio of infected individuals vs time,
% and finally the ratio of recovered individuals vs time.

subplot(3,1,1);
plot(t, S, 'b');
ylim([0 1]);
xlabel('t(seconds)');
ylabel('S(t)');
a = sprintf('Ratio of Susceptible Individuals in Cell With Coordinates x = %d, y = %d', x, y);
title(a);


subplot(3,1,2);
plot(t, I, 'b');
ylim([0 1]);
xlabel('t(seconds)');
ylabel('I(t)');
a = sprintf('Ratio of Infected Individuals in Cell With Coordinates x = %d, y = %d', x, y);
title(a);


subplot(3,1,3);
plot(t, R, 'b');
ylim([0 1]);
xlabel('t(seconds)');
ylabel('R(t)');
a = sprintf('Ratio of Recovered Individuals in Cell With Coordinates x = %d, y = %d', x, y);
title(a);


% Save the figure of plots as a png file with the specific grid coordinates
% (x,y) programatically included in the file name.
filename = sprintf('time_series_%d_%d.png', x, y);
saveas(h,filename);

end