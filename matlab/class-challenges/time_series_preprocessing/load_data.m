%{
    This is a simple script to load the data set for the adaline 
    neural network.
    This program analyzes a data set and makes the adaline neural
    network learn, in order to get a good model at the end.

    @ Elkin Javier Guerra Galenao - EIA University
%}

% Clean up the Matlab workspace
% clear; close all; clc;

% Load the database
fprintf("Loading database....");
% load("mat-files/DINAMICA_COMPLETA_MASA_RESORTE.mat");

% Normalize the dataset
maxdesired = max(max(abs(desired)));
inputs = inputs/max(max(abs(inputs)));
desired = desired/maxdesired;

% Analyze the database
nd = size(inputs,2);
ne = size(inputs,1);
ns = size(desired,1);

% Show the info to the user 
fprintf("The data set has:\n");
fprintf("\t - Number of inputs = %d\n",ne);
fprintf("\t - Number of outputs = %d\n",ns);
fprintf("\t - Number of datas = %d\n",nd);

% Ask the number of hidden to the user
no = input("Enter the number of hidden: \n");
fprintf("OK...");

% Ask alpha to the user
alpha = input("Enter alpha: \n");
fprintf("OK...\n");

% Ask the number of iterations to the user
nit = input("Enter the number of iterations: \n");
fprintf("OK...\n");

% Create the neural weight's matrix
W = 2.*rand(no,ne)-1;
C = 2.*rand(ns,no+1)-1;

% Create output vector
Yk = zeros(ns,nd);

% Create the mean square error's matrix 
mse = zeros(ns,nit);

% The network training begin
fprintf("Training....\n");
for i = 1:nit
    [Yk, mse(:,i), C, W] = feed_forward_madaline(alpha, inputs, desired, W, C, 1);
    fprintf("ECM iteration %d",i);
    disp(mse(:,i));
    fprintf('\n');
end

% Unnormalize the Yk
Yk = Yk.*maxdesired;

plot(mse, "LineWidth", 2);
title("MADALINE NEURAL NETWORK TRAINING");
xlabel("Iterations (k)"); ylabel("Mean Square Error (mse(k))"); grid on;

fprintf("Trained W is: \n");
disp(W);

