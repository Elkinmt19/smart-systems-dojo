%{
    This is a simple script that performs an analysis of a time series, using
    the autocorrelational and the partial autocorrelational plots to find the
    best model (ARX, MAX, ARMAX) of the box-jenkins methodology, in order to 
    make a parametric identification of the system.

    @ Elkin Javier Guerra Galenao - EIA University
    @ Santiago Garcia Arango - EIA University
%}

% Clean up the Matlab workspace
clear; close all; clc;

% Load the database
fprintf('Loading database....\n');
load('mat-files/motor_identification.mat');

% Define the variables of the system
yd = ST(:,2); % System response from Simulink
u = ST(:,1); % System setpoint from Simulink 

% Define the iteration vector
k = 1:1:size(yd);

% Plot the input and the time response of the system
figure
plot(k,u,'r',k,yd,'b','linewidth',2);
legend("Reference", "Time response")
ylabel("Amplitud")
xlabel("Iteraciones [k] - (Ts = 0.01s)")
prettygraph("Identificación del sistema dinámico","plot")

% Autocorrelation and partial autocorrelation plots
figure
autocorr(yd,size(yd,1) - 1); % Autocorrelation plot
prettygraph("Sample Autocorrelation Function","plot")
figure
parcorr(yd,100); % Partial autocorrelation plot
prettygraph("Sample Partial Autocorrelation Function","plot")

% Calculate the simulation matrix
data = iddata(yd,u,0.01); % iddata([out_sys],[in_sys],[Time_period])

%{ Autoregressive combined with movile mean model (ARMAX model) with
% exogenous input.
yarmax = armax(data,[2,1,2,0]) % [[out_sys_delays] [in_sys_delays] [error_delays] [delays_sys]]
ys1 = idsim(u,yarmax); % Simulate the armax system
figure
plot(k,yd,'b',k,ys1,'r','linewidth',2);
legend("Real system", "armax model")
ylabel("Amplitud")
xlabel("Iteraciones [k] - (Ts = 0.01s)")
prettygraph("Comparación entre la planta y el modelo paramétrico","plot")
fprintf('ARMAX model done!\n');







