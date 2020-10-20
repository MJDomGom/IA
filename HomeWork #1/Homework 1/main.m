%% EPD 6: Machine Learning Regression

%% Initialization
clear ; close all; clc

%% ======================= Cargar y visualizar =======================
fprintf('Loading Data ...\n')

data = load ('datahw1.csv');

% Plot Data
%Almacenar los valores en X e y
columnas = size(data);
names = {"Densidad determinada por pesaje bajo el agua","Años","Peso en libras","Altura en pulgadas","Circunferencia del cuello (cm)","Circunferencia del pecho (cm)","Circunferencia del abdomen (cm)","Circunferencia de la cadera (cm)","Circunferencia del muslo (cm)","Circunferencia de la rodilla (cm)","Circunferencia del tobillo (cm)","Circunferencia del bíceps extendido (cm)","Circunferencia del antebrazo (cm)","Circunferencia de la muñeca (cm)","Porcentaje de grasa corporal"};
y = data(:, columnas(2));
isTest = false;

fprintf('Regresion lineal univariable utiilzando el cojunto de entrenamiento como conjunto de test y utilzando la ecuacion normal. Press enter to continue.\n');
pause;

univariantEqnNormal(y,columnas,data,names,isTest);

fprintf('Regresion lineal multivariable utiilzando el cojunto de entrenamiento como conjunto de test y utilizanco la ecuacion normal. Press enter to continue.\n');
pause;

multivariantEqnNormal(y,columnas,data,names,isTest);

fprintf('Regresion lineal univariable utiilzando 70 Train , 30 Test y utilizanco la ecuacion normal. Press enter to continue.\n');
pause;
isTest = true;
[bestAtrib,bestTheta] = univariantEqnNormal(y,columnas,data,names,isTest);

fprintf('Regresion lineal multivariable 70train ,30test y utilzando la ecuacion normal. Press enter to continue.\n');
pause;

multivariantEqnNormal(y,columnas,data,names,isTest);

figure;
hist(y,"b");legend("Porcentaje de grasa corporal");
figure
name = names{bestAtrib};
plot(data(:,bestAtrib),y,"x");xlabel(name);ylabel("% de grasa");
hold on;
X = data(:,bestAtrib);
X = [ones(length(X),1),X];
regresion = X * bestTheta';
plot(X(:,2),regresion,"r");
legend(name,"recta de regresion");
fprintf('Program finish.\n');

