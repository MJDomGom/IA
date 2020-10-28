%%HOMEWORK DE REGRESI�N LOG�STICA
%%MANUEL JES�S DOM�NGUEZ G�MEZ
%%NEREA M�RQUEZ EGEA

clear ; close all; clc;

display("\n***********1. CARGA Y VISUALIZACI�N***********\n");
data = load ('dataset_2.csv');
X = data(:, 2:size(data, 2));
y = data(:, 1);
num_iter = 200; 
alpha = 0.000015;
##Grafica de valores en el dataset
plotData(X,y);


display("\n***********2. REGRESI�N LOG�STICA***********\n");
theta = zeros(size(X,2) + 1,1);
X = [ones(length(X),1) X];
[cost grad] = costFunction(theta, X, y);
fprintf("Funci�n coste paranum_iter=%d y alfa=%f:\n");
fprintf("Cost at initial theta (zeros): %f\n", cost);
fprintf("Gradient at initial theta (zeros):\n %f \n %f \n %f \n",grad);
fprintf("Funci�n descenso del gradiente para num_iter=%d y alfa=%f\n", num_iter, alpha);
[theta,J_history] = gradientDescent(X,y ,theta, alpha,num_iter);
display("\n***********2. REGRESI�N LOG�STICA  PREDICCION***********\n");
[prediccion sumaP] = predict(X,theta);
tasaAcierto = (sum(y) - sumaP)/100;
fprintf("La tasa de acierto seria de %f\n",tasaAcierto);
#Grafica regresion logistica y grafica con la frontera de decision
figure(2)
plot(1:num_iter, J_history, "-b", "LineWidth", 2);
title("Descenso del gradiente completo");
xlabel("Iteraciones");
ylabel("Coste");
plotDecisionBoundary(theta,X,y);

display("\n***********3. REGRESI�N LOG�STICA A�ADIENDO COLUMNAS A X***********\n");


