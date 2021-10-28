%% BASE RADIAL
% Red neuronal de base radial
% Limpio el workspace, cierro las figuras y limpio la pantalla.
clear ; close all; clc

%% Parte 1: Carga de datos de entrada y deseados.

fprintf('Cargando datos de entrada y deseados ...\n')
load('mat-files/data_iris.mat'); %alfa 0.04, 14 no, 500 iteracones para aprox 80% de
%acierto

% Obtengo el número de datos, número de entradas y número de salidas.
nd = size(entradas,2);
ne = size(entradas,1);
ns = size(deseados,1);


% Imprimo en pantalla las variables obtenidas.
fprintf('Los datos cargados tienen:\n');
fprintf('\t- Número de entradas = %d\n',ne);
fprintf('\t- Número de salidas = %d\n',ns);
fprintf('\t- Número de datos = %d\n\n',nd);


fprintf('Programa pausado. Presione enter para continuar.\n');
pause;

%% Parte 2: Configuración e inicialización de la red.

% Solicito alfa, el número de neuronas ocultas y el número de iteraciones.
alfa = input('Ingrese el alfa de entrenamiento de la red.\n');
no = input('Ingrese el número de neuronas ocultas.\n');
nit = input('Ingrese el número de iteraciones del algoritmo.\n');
% Inicializo los centros Cij.
c = 2*rand(ne,no)-1;
% Inicializo las distacias Dj.
d = rand(no,1)./1;
% Inicializo los pesos Wjk.
w = 2.*rand(no+1,ns) - 1;
% Configuro la salida y el error cuadrático medio.
Yk = zeros(ns,nd);

ecm = zeros(ns,nit);

% fprintf('Se comenzará el entrenamiento de la red neuronal ...\n')
% fprintf('Programa pausado. Presione enter para continuar.\n');
% pause;

%% Parte 3: Cálculo hacia adelante de la red.
fprintf('Entrenando la red neuronal ...\n')
for m = 1:nit
   [Yk, ecm(:,m), c, w, d] = feed_forward_base_radial_network(entradas,ne,no,c,d,w,deseados,alfa,ns,nd,1);
   
   if (mod(m,50)==0)
        fprintf('Iteración %d ...\n',m);
   end
end
%[yrkT, ecmTest] = feedForwardBRN(tEntradas,ne,no,c,d,w,tDeseados,alfa,ns,ndt,0);  
fprintf('Graficando errores cuadráticos medio ...\n')
for i = 1:ns
    figure;
    plot(1:nit,ecm(i,:),'b');
    xlabel('iteración');
    ylabel('ecm');
    legend('ecm Entrenamiento')
    title(strcat('Salida ', num2str(i)));
end
figure;
fprintf('Graficando Matriz de confusión para datos de entrenamiento...\n')
%yrkTn = round(yrkTn);
plotconfusion(deseados,Yk,'Entrenamiento');

% figure;
% fprintf('Graficando Matriz de confusión para datos de validación...\n')
% %yrkV = round(yrkV);
% plotconfusion(vDeseados,yrkV,'Validación');
%
%fprintf('El error cuadrático medio para la salida %d de los datos de prueba es: %f \n',[(1:length(ecmTest)); ecmTest'])
%
%figure;

%fprintf('Graficando Matriz de confusión para datos de prueba...\n')
%yrkT = round(yrkT);
%plotconfusion(tDeseados,yrkT,'Prueba');
