%% 1. MODELO DE REGRESIÓN SEGÚN LA ECUACIÓN NORMAL
%% Initialización
clear ; close all; clc
data = load('datahw1.csv');
columnas = size(data);
names = {"Densidad determinada por pesaje bajo el agua","Años","Peso en libras","Altura en pulgadas","Circunferencia del cuello (cm)","Circunferencia del pecho (cm)","Circunferencia del abdomen (cm)","Circunferencia de la cadera (cm)","Circunferencia del muslo (cm)","Circunferencia de la rodilla (cm)","Circunferencia del tobillo (cm)","Circunferencia del bíceps extendido (cm)","Circunferencia del antebrazo (cm)","Circunferencia de la muñeca (cm)","Porcentaje de grasa corporal"};
y = data(:, columnas(2));
isTest = false;

%PARA PODER DIVIDIR EL CONJUNTO 70-30
nSamples = length(data)*0.7;

dataR = data(randperm(size(data,1)),:);
dataTrain = dataR(1:round(nSamples),1:size(dataR,2));
dataTest = dataR(round(nSamples)+1:end, 1:size(dataR,2));

display("\n***********1. MODELO DE REGRESIÓN SEGÚN LA ECUACIÓN NORMAL***********\n");
%APARTADO A: Modelar con todo el conjunto de datos

fprintf('***UNIVARIABLE UTILIZANDO TODO EL CONJUNTO DE DATOS***\n');
univariantEqnNormal(y,columnas,data,names,isTest, dataR, nSamples);

fprintf('***MULTIVARIABLE UTILIZANDO TODO EL CONJUNTO DE DATOS***\n');
multivariantEqnNormal(y,columnas,data,names,false, dataR, nSamples);

%APARTADO E: Modelar con conjunto del 70%-30%

display('***UNIVARIABLE UTILIZANDO 70% TRAIN y 30% TEST***\n');
isTest = true;
[bestAtrib,bestTheta] = univariantEqnNormal(y,columnas,data,names,isTest, dataR, nSamples);

display('***MULTIVARIABLE UTILIZANDO 70% TRAIN Y 30% TEST***\n');
multivariantEqnNormal(y,columnas,data,names,isTest, dataR, nSamples);

%%2. DESCENSO DEL GRADIENTE
display("\n***************2. DESCENSO DEL GRADIENTE***************\n");

alpha = 0.02;
iterations = 400;

%Primero normalicemos los datos para el descenso
dataTrain = normalize(dataTrain);
dataTest = normalize(dataTest);

%CONJUNTO COMPLETOS DE DATOS

%Dividir el conjunto de entrenamiento para tener todos las métricas
% y aparte el porcentaje de grasa
XTrain = dataTrain(:,1:size(dataTrain,2)-1);
yTrain = dataTrain(:,size(dataTrain, 2));

XTrain = [ones(length(yTrain), 1) XTrain];
theta = zeros(size(XTrain, 2),1);

%Aplicar el descenso del gradiente
[theta, JHistoryTotal] = gradientDescent(XTrain, yTrain, theta, alpha, iterations);

%Dividirel conjunto de test para tener todos las métricas
% y aparte el porcentaje de grasa
XTest = dataTest(:,1:size(dataTest,2)-1);
yTest = dataTest(:, size(dataTest, 2));
XTest = [ones(length(yTest), 1) XTest];

%Calcular el error cometido
err = calculateError(XTest, theta, yTest);
display(sprintf('Para el conjunto completo de datos, el error cometido es de %f', err));

display("\n-------------------------------------------------------\n");

%5 MEJORES MÉTRICAS

%En "errores" tendrá en la primera columna que métrica corresponde (e.g: 2 es Años)
% y la segunda será el error cometido
errores = zeros(size(XTrain, 2)-1,2);

%Realizar a cada métrica el descenso del gradiente 

for i=2:size(XTrain,2)
  xTrain = XTrain(:,[i]);
  xTest = XTest(:,[i]);
  xTrain = [ones(length(yTrain), 1) xTrain];
  xTest = [ones(length(yTest), 1) xTest];
  
  theta = zeros(size(xTrain, 2),1);

  [theta, JHistory] = gradientDescent(xTrain, yTrain, theta, alpha, iterations);

  errores(i,1) = i-1;
  errores(i,2) = calculateError(xTest, theta, yTest);

endfor

%Ordenar la matriz errores de manera ascendente según el error
errores = sortrows(errores, 2);
errores(1,:) = [];

for i=1:size(errores,1)
  display(sprintf('%s\n%f', names{i}, errores(i,2)));
endfor 

%Obtener las 5 mejores métricas con menor error
metrics = errores(1:5, 1);

%Realizar de nuevo el descenso para estas 5 métricas
XTrain = XTrain(:,[metrics']);
XTest = XTest(:, [metrics']);

theta = zeros(size(XTrain, 2),1);
[theta, JHistory] = gradientDescent(XTrain, yTrain, theta, alpha, iterations);

err = calculateError(XTest, theta, yTest);
display(sprintf('\nPara el conjunto de las mejores metricas, el error cometido es de %f', err));

%%3. VISUALIZAR DATOS
display("\n******************3. VISUALIZAR DATOS******************\n");
espacios = 4;

subplot (2, espacios/2, 1);
hist(y,"b");
title("Porcentaje de grasa corporal");
xlabel("Grasa corporal (%)");
ylabel("Número de instancias");

subplot(2, espacios/2, 2);
name = names{bestAtrib};
plot(data(:,bestAtrib),y,"x");xlabel(name);ylabel("% de grasa");
hold on;
X = data(:,bestAtrib);
X = [ones(length(X),1),X];
regresion = X * bestTheta';
plot(X(:,2),regresion,"r");
legend("Mejor métrica","Recta de regresion");
title("Recta de regresión");

subplot(2, espacios/2, 3);
plot(1:iterations, JHistoryTotal, "-b", "LineWidth", 2);
title("Descenso del gradiente completo");
xlabel("Iteraciones");
ylabel("Coste");

subplot(2, espacios/2, 4);
plot(1:iterations, JHistory, "-b", "LineWidth", 2);
title("Descenso del gradiente de las 5 mejores métricas");
xlabel("Iteraciones");
ylabel("Coste");