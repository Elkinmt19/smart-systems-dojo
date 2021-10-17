%{
    This is a simple script that performs an analysis of a time series, using
    the autocorrelational and the partial autocorrelational plots to find the
    best model (ARX, MAX, ARMAX) of the box-jenkins methodology, in order to 
    make a parametric identification of the system.

    @ Elkin Javier Guerra Galenao - EIA University
%}

% Clean up the Matlab workspace
clear; close all; clc;

% Load the database
fprintf('Loading database....\n');
load('mat-files/dynamic_system_data.mat');

% Define the variables of the system
yd = ST(:,2); % System response from Simulink
u = ST(:,1); % System setpoint from Simulink 

% Define the iteration vector
k = 1:1:size(yd);

% Plot the input and the time response of the system
subplot(4,1,1);
plot(k,u,'r',k,yd,'b');
legend("Reference", "Time response")
hold on 

% Autocorrelation and partial autocorrelation plots
subplot(4,1,2);
autocorr(yd,size(yd,1) - 1); % Autocorrelation plot
subplot(4,1,3);
parcorr(yd,100); % Partial autocorrelation plot

% Calculate the simulation matrix
data = iddata(yd,u,0.01); % iddata([out_sys],[in_sys],[Time_period])

% Define variable to control the model that is going to be used
model = "armax";

switch (model)
    case ("arx")
        % Autoregressive Model with exogenous input (ARX)
        yarx = arx(data,[100,1,0]) % [[out_sys_delays] [in_sys_delays] [error_delays]]
        ys1 = idsim(u,yarx); % Simulate the arx system
        subplot(4,1,4);
        plot(k,yd,'r',k,ys1,'b');
        legend("Real system", "arx model")
        fprintf('ARX model done!\n');
    case ("max")
        % Movile mean model with exogenous input (MAX)
        ymax = armax(data,[0,1,4,0]) % [[out_sys_delays] [in_sys_delays] [error_delays] [delays_sys]]
        ys1 = idsim(u,ymax);
        subplot(4,1,4);
        plot(k,yd,'r',k,ys1,'b');
        legend("Real system", "max model")
        fprintf('MAX model done!\n');
    case ("armax")
        %{ Autoregressive combined with movile mean model (ARMAX model) with
        % exogenous input.
        yarmax = armax(data,[5,1,5,0]) % [[out_sys_delays] [in_sys_delays] [error_delays] [delays_sys]]
        ys1 = idsim(u,yarmax); % Simulate the armax system
        subplot(4,1,4);
        plot(k,yd,'b',k,ys1,'r');
        legend("Real system", "armax model")
        fprintf('ARMAX model done!\n');
end







