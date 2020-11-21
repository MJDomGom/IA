%% HOMEWORK 3: REDES NEURONALES
%% Manuel Jesús Dominguez Gómez
%% Nerea Márquez Egea

%%Initialization
clear ; close all; clc

%% Setup de parametros
input_layer_size  = 2;    % Número de atributos
hidden_layer_size = 1;    % Número de neuronas en la capa oculta:
                          % 1,2,3,4,5,10
iterations = 50;         % Iteraciones para el descenso del gradiente
options = optimset("GradObj", 'on', "MaxIter", iterations);

display("\n***********CARGA Y VISUALIZACIÓN***********\n");
load('data.mat');

XTotal = [X ; Xval];
yTotal = [y ; yval];

figure(1);
plotData(XTotal,yTotal);
title("Conjunto de datos");

display("\n***********IMPLEMENTACIÓN DE REDES NEURONALES***********\n");
display("\n***********SIN REGULARIZACIÓN***********\n");
for i=1:10
  if (i <= 5 || i == 10)
    fprintf("\n-------------%d NEURONA(S) EN LA CAPA OCULTA-------------------\n", i);
    hidden_layer_size = i;
  
    #Formación de Thetas
    initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size)
    initial_Theta2 = randInitializeWeights(hidden_layer_size, 1)
    Thetavec = [initial_Theta1(:) ; initial_Theta2(:)];
  
    #Coste
    [J grad] = nnCostFunction(Thetavec, input_layer_size, hidden_layer_size, XTotal, yTotal);
    fprintf('COSTE: %f \n', J);
    fprintf('DESCENSO DEL GRADIENTE: \n');
    grad
 
    #Optimización
    fprintf("OPTIMIZACIÓN DE LAS THETAS UTILIZANDO EL DESCENSO DEL GRACIENTE CON %i ITERACIONES:\n",iterations);
    coste = @(p) nnCostFunction(p,input_layer_size, hidden_layer_size, XTotal, yTotal);
    [nn_params, cost] = fminunc(coste, Thetavec, options);
    fprintf('COSTE ACTUALIZADO: %f \n', cost);
    fprintf('THETAS ACTUALIZADAS: \n');
    nn_params
  
    #Reshape de las thetas
    Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)),hidden_layer_size, (input_layer_size + 1));
    Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end),1, (hidden_layer_size + 1));

    #Predicción
    p = predict(Theta1,Theta2,XTotal);
    pTotal = mean((p-yTotal) == 0)*100;
    fprintf("TASA DE ACIERTO CON %i NEURONAS EN LA CAPA OCULTA: %f\n",hidden_layer_size,pTotal);
  
    #Recta de regresion o plot decision boundary
    plot_decision_boundary(Theta1,Theta2, XTotal, yTotal, i+1);
    s = sprintf("%i neurona(s)\nTasa de acierto %.2f%% \n", hidden_layer_size, pTotal);
    title(s);
  endif
endfor

display("\n***********IMPLEMENTACIÓN DE REDES NEURONALES***********\n");
display("\n*******************CON REGULARIZACIÓN*******************\n");
display("\n-----------10 NEURONAS EN LA CAPA OCULTA-----------------\n");

k = i+1;    %k sirve para poder dividir los plots
for j=1:3
  lambda1 = realpow(0.1, j);
  lambda3 = lambda1*3;
  
  fprintf("\nxxxxxxxxxxxxxxxxxxxx LAMBDA = % f xxxxxxxxxxxxxxxxxx\n", lambda1);
  
  #Formación de Thetas
  initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size)
  initial_Theta2 = randInitializeWeights(hidden_layer_size, 1)
  Thetavec = [initial_Theta1(:) ; initial_Theta2(:)];
  
  #Coste
  [JReg gradReg] = nnCostFunctionReg(Thetavec, input_layer_size, hidden_layer_size, XTotal, yTotal,lambda1);
  fprintf('COSTE REGULARIZADO: %f \n\n', JReg);
  fprintf('DESCENSO DEL GRADIENTE REGULARIZADO:  \n');
  gradReg  
  
  #Optimización
  fprintf("OPTIMIZACIÓN DE LAS THETAS UTILIZANDO EL DESCENSO DEL GRACIENTE CON %i ITERACIONES\n",iterations);
  costeReg = @(p) nnCostFunctionReg(p,input_layer_size, hidden_layer_size, XTotal, yTotal,lambda1);
  [nn_params_reg, cost_reg] = fminunc(costeReg, Thetavec, options);
  fprintf('COSTE REGULARIZADO Y ACTUALIZADO: %f \n', cost_reg);
  fprintf('THETAS REGULARIZADAS Y ACTUALIZADAS: \n');
  nn_params_reg
  
  #Reshape de las thetas
  Theta1Reg = reshape(nn_params_reg(1:hidden_layer_size * (input_layer_size + 1)),hidden_layer_size, (input_layer_size + 1));
  Theta2Reg = reshape(nn_params_reg((1 + (hidden_layer_size * (input_layer_size + 1))):end),1, (hidden_layer_size + 1));
  
  #Predicción
  pReg = predict(Theta1Reg,Theta2Reg,XTotal);
  pTotalReg = mean((pReg-yTotal) == 0)*100;
  fprintf("TASA DE ACIERTO CON %i NEURONAS EN LA CAPA OCULTA = %f\n",hidden_layer_size,pTotalReg);
  
  #Recta de regresion o plot decision boundary
  plot_decision_boundary(Theta1Reg,Theta2Reg, XTotal, yTotal, k);
  k = k +1;
  s = sprintf("%i neurona(s)\nTasa de acierto %.2f%%\n Lambda = %f\n", hidden_layer_size, pTotalReg, lambda1);
  title(s);
  
  fprintf("\nxxxxxxxxxxxxxxxxxxxx LAMBDA = % f xxxxxxxxxxxxxxxxxx\n", lambda3);
  
  #Formación de Thetas
  initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size)
  initial_Theta2 = randInitializeWeights(hidden_layer_size, 1)
  Thetavec = [initial_Theta1(:) ; initial_Theta2(:)];
  
  #Coste
  [JReg gradReg] = nnCostFunctionReg(Thetavec, input_layer_size, hidden_layer_size, XTotal, yTotal,lambda3);
  fprintf('COSTE REGULARIZADO: %f \n\n', JReg);
  fprintf('DESCENSO DEL GRADIENTE REGULARIZADO:  \n');
  gradReg  
  
  #Optimización
  fprintf("OPTIMIZACIÓN DE LAS THETAS UTILIZANDO EL DESCENSO DEL GRACIENTE REGULARIZADO CON %i ITERACIONES\n",iterations);
  costeReg = @(p) nnCostFunctionReg(p,input_layer_size, hidden_layer_size, XTotal, yTotal,lambda3);
  [nn_params_reg, cost_reg] = fminunc(costeReg, Thetavec, options);
  fprintf('COSTE REGULARIZADO Y ACTUALIZADO: %f \n', cost_reg);
  fprintf('THETAS REGULARIZADAS Y ACTUALIZADAS: \n');
  nn_params_reg
  
  #Reshape de las thetas
  Theta1Reg = reshape(nn_params_reg(1:hidden_layer_size * (input_layer_size + 1)),hidden_layer_size, (input_layer_size + 1));
  Theta2Reg = reshape(nn_params_reg((1 + (hidden_layer_size * (input_layer_size + 1))):end),1, (hidden_layer_size + 1));
  
  #Predicción
  pReg = predict(Theta1Reg,Theta2Reg,XTotal);
  pTotalReg = mean((pReg-yTotal) == 0)*100;
  fprintf("TASA DE ACIERTO CON %i NEURONAS EN LA CAPA OCULTA = %f\n",hidden_layer_size,pTotalReg);
  
  #Recta de regresion o plot decision boundary
  plot_decision_boundary(Theta1Reg,Theta2Reg, XTotal, yTotal, k);
  k = k + 1;
  s = sprintf("%i neurona(s)\nTasa de acierto %.2f%%\n Lambda = %f\n", hidden_layer_size, pTotalReg, lambda3);
  title(s);
  
endfor