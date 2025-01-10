%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Title: 2D Animation
% Description: This function is designed to provide a 2D visual animation
% of how the disease spreads through the population with time. We use red
% to show the infected, green for recovered, and blue for susceptible
% individuals so the pixels will start as blue, turn red, and eventually
% change to green as the population recovers.
% Name: Kian Mohseni 
% UID: 505084983
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function animate(X)

% animate: a function that shows the change in the ratio of susceptible,
% infected, and recovered individuals in the grid as an image.
% Inputs:
% X: an M*N*3*length(t) matrix, where each point in the M*N space
% corresponds to a single grid with 3 numbers between 0 and 1 showing
% the SIR result. this 3D matrix is repeated for each time step
% making it a 4D matrix.
%
% Output: this function does not output anything.

% Retrieve the size array of the input matrix and assign its first element
% to M and its second element to N.
S = size(X);
M = S(1);
N = S(2);

% Initialize a 4D color matrix whose dimensions match up with the input
% matrix X.
color = zeros(M,N,3,size(X,4));

% Set the first "page" or "layer" of the 4D input matrix to represent the
% susceptible population, the second layer to represent the infected
% population, and the third layer to represent the recovered population.
St = X(:,:,1,:);
It = X(:,:,2,:); 
Rt = X(:,:,3,:);

color(:,:,3,:) = St;  % Set the susceptible individuals to display as blue color
color(:,:,1,:) = It;  % Set the infected individuals to display as red color
color(:,:,2,:) = Rt;  % Set the recovered individuals to display as green color

% Call the figure function to generate a new figure each time the animate
% function is run.
a = figure(2);


% Run a for loop to iterate through the color matrix a total of
% (length(t))/10 times. This is used along with the t*10 inside the for
% loop to ensure we are only displaying the image at every 10th step.
for t = 1:size(X,4)/10
    
    % Use the image command to generate an image for every iteration and
    % use the squeeze command to eliminate any single dimensions in the
    % color matrix. For the fourth dimension of the color matrix, multiply
    % the time value by 10 so that we're only displaying the image at every
    % 10th step and thus only having 60 frames instead of 601.
    image(squeeze(color(:,:,:,t*10)));
    
    % Use a pause of 0.1 seconds before changing to the next image. Because
    % the animation has 60 frames, the animation takes a total of about 6
    % seconds to complete.
    pause(0.1);
    
    
    % Save a few png image files of the figure produced at the 10 second,
    % 300 second, and finally 600 second mark of the animation. Use these
    % images in our report to visualize how the state of the grid evolves.
    if t == 1
        saveas(a, 'animate10.png');
    end
    
    if t == 15
        saveas(a, 'animate150.png');
    end
    
    if t == 30
        saveas(a, 'animate300.png');
    end
    
    if t == 45
        saveas(a, 'animate450.png');
    end
    
    if t == 60
        saveas(a, 'animate600.png');
    end
    
    
end


end