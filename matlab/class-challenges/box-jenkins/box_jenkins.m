% Clean up the Matlab workspace
clear; close all; clc;

% Load the database
fprintf("Loading database....\n");
load("mat-files/BASEDATOS_SIMULINK.mat");

yd = ST(:,2); % System response from Simulink
u = ST(:,1); % System setpoint from Simulink 

k = 1:1:size(yd);

subplot(4,1,1);
plot(k,u,'r',k,yd,'b');
hold on 

% Autocorrelation plots
subplot(4,1,2);
autocorr(yd,size(yd,1) - 1);
subplot(4,1,3);
parcorr(yd,100);

% Autoregressive Model
data = iddata(yd,u,0.01); % Simulation matrix
yarx = arx(data,[100,1,0]); % [na nb nk] na: Windows of the system response
ys1 = idsim(u,yarx); % Simulate the arx system
subplot(4,1,4);
plot(k,yd,'r',k,ys1,'b');
fprintf("Done!");



