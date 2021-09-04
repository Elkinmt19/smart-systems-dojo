%{
    This is a simple sample that concatenates a complete 
    inputs matrix for a neural network
%}

% Create the dataset for the neural network
load("mat-files/TEMPERATURE_PLANT_PI_CONTROLLER.mat")

% Datas took from the output of the dynamic system
[inputs, desired] = time_series_preprocessing(DATA_FULL(:,3)',1,500);

% Datas took from the setpoint of the dynamic system
[inputs1, ~] = time_series_preprocessing(DATA_FULL(:,4)',1,500);

% Concatenates the matrices in one
inputs = [inputs ; inputs1];

% Deletes the aditional variable
clear inputs1;