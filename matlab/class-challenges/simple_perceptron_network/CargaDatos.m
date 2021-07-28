%Carga datos red PERCEPTRON


%% lIMPIAMOS EL ESPACIO DE TRABAJO
clear; close all; clc

% Cargamos la base de datos
fprintf("Cargando base de datos....");
load("AND.mat");

%% Agregamos el BIAS
entradas = [ones(1,size(entradas,2)); entradas];

%% Analisamos la base de datos
nd = size(entradas,2);
ne = size(entradas,1);
ns = size(deseados,1);

%% Mostramos la info al usuario 
fprintf("Los datos tienen:\n");
fprintf("\t - Numero de entradas = %d\n",ne);
fprintf("\t - Numero de salidas = %d\n",ns);
fprintf("\t - Numero de datos = %d\n",nd);

%% Preguntamos datos al usuario
alfa = input("Ingrese alfa: \n");
fprintf("OK...\n");

%% Pedimos numero de iteraciones
nit = input("Ingrese numero de iteraciones: \n");
fprintf("OK...\n");

% Creamos matriz de pesos neuronales
w = 2.*rand(ns,ne)-1;

%% Creamos el vector de salida
Yk = zeros(ns,nd);

%% Creamos matriz de error cuadratico medio 
ecm = zeros(ns,nit);

%% Entrenamos la red neuronal
fprintf("Entrenando....\n");
for i = 1:nit
    [Yk, ecm(:,i), w] = feedForwardPerceptron(alfa, entradas, deseados, w, 1);
    fprintf("ECM iteracion %d",i);
    disp(ecm(:,i));
    fprintf('\n');
end

plot(ecm);

fprintf("w entrenado es: \n");
disp(w);
