%{
    This is a simple script to load the data set for the base radial 
    neural network.
    This program analyzes a data set and makes the base radial neural
    network learn, in order to get a good model at the end.

    @ Elkin Javier Guerra Galenao - EIA University
%}

% Clean up the Matlab workspace
clear ; close all; clc

% Load the database
fprintf('Cargando datos de entrada y desired ...\n')
load('mat-files/data_iris.mat');

% Normalize the dataset
maxdesired = max(max(abs(desired)));
inputs = inputs/max(max(abs(inputs)));
desired = desired/maxdesired;

% Analyze the database
nd = size(inputs,2);
ne = size(inputs,1);
ns = size(desired,1);

% Show the info to the user 
fprintf('The features of the loaded dataset are:\n');
fprintf('\t- Number of inputs = %d\n',ne);
fprintf('\t- Number of outputs = %d\n',ns);
fprintf('\t- Number of samples = %d\n\n',nd);


% Ask the number of hidden to the user
no = input("Enter the number of classes: \n");
fprintf("OK...\n");

% Ask alpha to the user
alpha = input("Enter alpha: \n");
fprintf("OK...\n");

% Ask the number of iterations to the user
nit = input("Enter the number of iterations: \n");
fprintf("OK...\n");

% Define the centers of the Gaussian Bells Cji
C = 2*rand(ne,no)-1;

% Define the diameters of the Gaussian Bells Dj.
D = rand(no,1)./1;

% Define the weights of the output layer
W = 2.*rand(no+1,ns) - 1;

% Create output vector
Yk = zeros(ns,nd);

% Create the mean square error's matrix 
ecm = zeros(ns,nit);

% The network training begin
fprintf('Training...\n')
for m = 1:nit
   [Yk, ecm(:,m), C, W, D] = feed_forward_base_radial_network(inputs,ne,no,C,D,W,desired,alpha,ns,nd,1);
   
   if (mod(m,50)==0)
        fprintf('Iteration %d ...\n',m);
   end
end

% Unnormalize the Yk
Yk = Yk.*maxdesired;
  
fprintf('Plots of the Mean Square Error...\n')
for i = 1:ns
    figure;
    plot(1:nit,ecm(i,:),'b');
    xlabel('Iteration');
    ylabel('mse');
    legend('mse trained')
    title(strcat('Output ', num2str(i)));
end

figure; 
fprintf('Plot of the confution matrix for the trained data...\n')
plotconfusion(desired,Yk,'Training');
