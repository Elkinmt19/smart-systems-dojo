%% BASE RADIAL
% Red neuronal de base radial
% Limpio el workspace, cierro las figuras y limpio la pantalla.
clear ; close all; clc

%% Parte 1: Carga de datos de entrada y deseados.

fprintf('Cargando datos de entrada y deseados ...\n')
load('mat-files/data_iris.mat'); %alfa 0.04, 14 no, 500 iteracones para aprox 80% de
%acierto

% Obtengo el n�mero de datos, n�mero de entradas y n�mero de salidas.
nd = size(entradas,2);
ne = size(entradas,1);
ns = size(deseados,1);


% Imprimo en pantalla las variables obtenidas.
fprintf('Los datos cargados tienen:\n');
fprintf('\t- N�mero de entradas = %d\n',ne);
fprintf('\t- N�mero de salidas = %d\n',ns);
fprintf('\t- N�mero de datos = %d\n\n',nd);


fprintf('Programa pausado. Presione enter para continuar.\n');
pause;

%% Parte 2: Configuraci�n e inicializaci�n de la red.

% Solicito alfa, el n�mero de neuronas ocultas y el n�mero de iteraciones.
alfa = input('Ingrese el alfa de entrenamiento de la red.\n');
no = input('Ingrese el n�mero de neuronas ocultas.\n');
nit = input('Ingrese el n�mero de iteraciones del algoritmo.\n');
% Inicializo los centros Cij.
c = 2*rand(ne,no)-1;
% Inicializo las distacias Dj.
d = rand(no,1)./1;
% Inicializo los pesos Wjk.
w = 2.*rand(no+1,ns) - 1;
% Configuro la salida y el error cuadr�tico medio.
Yk = zeros(ns,nd);

ecm = zeros(ns,nit);

% fprintf('Se comenzar� el entrenamiento de la red neuronal ...\n')
% fprintf('Programa pausado. Presione enter para continuar.\n');
% pause;

%% Parte 3: C�lculo hacia adelante de la red.
fprintf('Entrenando la red neuronal ...\n')
for m = 1:nit
   [Yk, ecm(:,m), c, w, d] = feed_forward_base_radial_network(entradas,ne,no,c,d,w,deseados,alfa,ns,nd,1);
   
   if (mod(m,50)==0)
        fprintf('Iteraci�n %d ...\n',m);
   end
end
%[yrkT, ecmTest] = feedForwardBRN(tEntradas,ne,no,c,d,w,tDeseados,alfa,ns,ndt,0);  
fprintf('Graficando errores cuadr�ticos medio ...\n')
for i = 1:ns
    figure;
    plot(1:nit,ecm(i,:),'b');
    xlabel('iteraci�n');
    ylabel('ecm');
    legend('ecm Entrenamiento')
    title(strcat('Salida ', num2str(i)));
end
figure;
fprintf('Graficando Matriz de confusi�n para datos de entrenamiento...\n')
%yrkTn = round(yrkTn);
plotconfusion(deseados,Yk,'Entrenamiento');

% figure;
% fprintf('Graficando Matriz de confusi�n para datos de validaci�n...\n')
% %yrkV = round(yrkV);
% plotconfusion(vDeseados,yrkV,'Validaci�n');
%
%fprintf('El error cuadr�tico medio para la salida %d de los datos de prueba es: %f \n',[(1:length(ecmTest)); ecmTest'])
%
%figure;

%fprintf('Graficando Matriz de confusi�n para datos de prueba...\n')
%yrkT = round(yrkT);
%plotconfusion(tDeseados,yrkT,'Prueba');
