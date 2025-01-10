%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Title: Implementing the PCA Algorithm
% Description: This function is designed to realize Principle Component
% Analysis, a widely used method in modern machine learning. The function is
% able to analyze complex datasets by reducing its dimensions and therefore
% projecting it onto a few main (most relevant) bases or components.
% Name: Kian Mohseni 
% UID: 505084983
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [coeffOrth,pcaData] = myPCA(data)

% myPCA analyzes the principal components of given COVID-19 statistical data from multiple countries - covid_countries.csv
% Inputs:
% data: A nxp matrix representing only the numerical parts of the dataset
% Outputs:
% coeffOrth: a pxp matrix whose columns are the eigenvectors corresponding to the sorted eigenvalues
% pcaData: a nxp matrix representing the data projected onto the principal components


% Determine the size of the data matrix
[rows, columns] = size(data);

% Initialize the average (mean) and standard deviation vectors (p-dimensional) and the
% normal matrix (nxp) to be found.
average = zeros(columns);   
deviation = zeros(columns);  
normal = zeros(rows, columns);  % nxp

% Initialize all other matrices that are to be used in the function.
% C = zeros(columns, columns);  % pxp
% eigVec = zeros(columns, columns); % pxp
% eigVal = zeros(columns, columns); % pxp
% A = zeros(columns, columns); % pxp
% 
% B = zeros(columns, 1);  % px1
% index = zeros(columns, 1); % px1
% 
% coeffOrth = zeros(columns, columns); % pxp
% pcaData = zeros(rows, columns); % nxp


for i = 1:columns
    average(i) = mean(data(:,i));   % Find the means and standard deviations of each column vector of data
    deviation(i) = std(data(:,i));
end


for i = 1:columns
    for k = 1:rows
        normal(k, i) = (data(k, i) - average(i))/(deviation(i));  % Find the normalized data matrix (nxp) by looping through each data point or cell
    end
end


C = cov(normal);  % The square covariance matrix C (pxp) is taken from the normalized data


[eigVec, eigVal] = eig(C);   % Diagonal matrix eigVal of eigenvalues and full matrix eigVec whose columns are the corresponding eigenvectors

% Take the absolute values of every element in the matrix of eigenvalues
A = abs(eigVal); 

% Only take the (nonzero) diagonal values of the matrix as they represent
% all the eigenvalues and store them in a p-dimensional vector B
B = diag(A);

% We want to sort the eigenvalues in descending order, but don't actually
% need the sorted vector. We only need the indices that will tell us the
% order of the eigenvectors because eigVal is a square matrix (pxp).
[~,index] = sort(B, 'descend');

% Sort the eigenvectors in the eigenvector matrix based on the absolute
% values of their eigenvalues. The index determined above tells us the
% order in descending values of absolute values of eigenvalues. This is
% stored in coeffOrth, a pxp matrix.
coeffOrth = eigVec(:,index);

% Mulitply the nxp normalized matrix by the pxp sorted matrix to get
% pcaData, a nxp matrix that is the original data projected onto the 2 main
% components and therefore it is now reduced to 2D instead of p-dimensional
% and will be easier to interpret.
pcaData = (normal)*(coeffOrth);

end