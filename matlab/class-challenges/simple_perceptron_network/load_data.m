%{
    This is a simple script to load the data set for the perceptron 
    neural network.
    This program analyzes a data set and makes the perceptron neural
    network learn, in order to get a good model at the end.

    @ Elkin Javier Guerra Galenao - EIA University
%}

% Clean up the Matlab workspace
clear; close all; clc;

% Load the database
fprintf("Loading database....");
load("mat-files/AND.mat");

% Add the BIAS
inputs = [ones(1,size(inputs,2)); inputs];

% Analyze the database
nd = size(inputs,2);
ne = size(inputs,1);
ns = size(desired,1);

% Show the info to the user 
fprintf("The data set has:\n");
fprintf("\t - Number of inputs = %d\n",ne);
fprintf("\t - Number of outputs = %d\n",ns);
fprintf("\t - Number of datas = %d\n",nd);

% Ask alpha to the user
alpha = input("Enter alpha: \n");
fprintf("OK...\n");

% Ask the number of iterations to the user
nit = input("Enter the number of iterations: \n");
fprintf("OK...\n");

% Create the neural weight's matrix
W = 2.*rand(ns,ne)-1;

% Create output vector
Yk = zeros(ns,nd);

% Create the mean square error's matrix 
ecm = zeros(ns,nit);

% The network training begin
fprintf("Training....\n");
for i = 1:nit
    [Yk, ecm(:,i), W] = feedForwardPerceptron(alpha, inputs, desired, W, 1);
    fprintf("ECM iteration %d",i);
    disp(ecm(:,i));
    fprintf('\n');
end

plot(ecm, "LineWidth", 2);
title("PERCEPTRON NEURAL NETWORK TRAINING");
xlabel("Iterations (k)"); ylabel("Mean Square Error (ecm(k))"); grid on;

fprintf("Trained W is: \n");
disp(W);