%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Title: Problem 1 Main Script
% Description: This script is designed to implement the myPCA function we
% created and to demonstrate its effectiveness when considering the
% Covid-19 data from 27 countries. It will project the data onto the 2
% most relevant components and plot the results to visualize the
% relationships between the 6 variables.
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

% Use the readtable command to load the Covid-19 data from the csv file
data = readtable('covid_countries.csv', 'PreserveVariableNames', true);

% Create a cell array called categories that stores all the 6 variable names
categories = {'Infections', 'Deaths', 'Cures', 'Mortality rate(%)', 'Cure rate(%)', 'Infection rate(%)'};

% Use the table2array command to only take the columns that include
% numerical values and avoid the dates and names of countries
data1 = table2array(data(:, 3:end));

%% Run PCA Model

[coeffOrth1, pcaData1] = myPCA(data1);  % Call the myPCA function to run the model on the parsed Covid-19 csv data and store the outputs in two variables

%% Plot Data

% Use the biplot command to visualize the first two principle component
% eigenvectors and the projected data onto the 2D space. The categories
% cell array established earlier will be used to label the plot. We only use the first
% two columns of both the coeffOrth1 and pcaData1 matrices.
a = figure(1);
biplot(coeffOrth1(:, 1:2), 'Scores', pcaData1(:, 1:2), 'Varlabels', categories);
title('My PCA Covid Countries');

% Allows us to better visualize the plot
box on;

% Save the figure as a png file
saveas(a,'PCA.png');
