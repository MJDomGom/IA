%% EPD 8: Machine Learning â€“ Redes Neuronales

%% Initialization
clear ; close all; clc

%% Setup the parameters you will use for this exercise
input_layer_size  = 2;    % 20x20 Input Images of Digits
hidden_layer_size = 10;   % 1,2,3,4,5,10
##num_labels = 1;        % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)

% Load Training Data
fprintf('Loading Data ...\n')
load('data.mat');

XTotal = [X ; Xval];
yTotal = [y ; yval];

fprintf('\nRealizar PlotData de los datos ...\n');
##figure(1);
##title("Datos totales");
##plotData(XTotal,yTotal);


##m = size(X, 1);

##fprintf('\nLoading Saved Neural Network Parameters ...\n')

##% Load the weights into variables Theta1 and Theta2
##load('ex4weights.mat');
##
##% Theta Iniciales
    initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size)
    initial_Theta2 = randInitializeWeights(hidden_layer_size, 1)
##    initial_Theta1 = [0.0837 -0.0081 0.0312;-0.1078 -0.0418 -0.0647]
##    initial_Theta2 = [0.0192 0.0248 0.0240]
    Thetavec = [initial_Theta1(:) ; initial_Theta2(:)];
        
     
#
##%% ================ EJ1. Compute Cost (Feedforward) ================
##
##fprintf('\nFeedforward Using Neural Network ...\n')
##
#EJERCICIO 1: SABER EL VALOR DE J CON FORWARD

  [J grad] = nnCostFunction(Thetavec, input_layer_size, hidden_layer_size, XTotal, yTotal);
  fprintf(['Cost at parameters (loaded from data.mat): %f \n\n'], J);
  grad    

  fprintf("Optimizacion de las thetas utilizando el descenso del gradiente con 150 iteraciones\n");
  options = optimset("GradObj", 'on', "MaxIter", 150);
  coste = @(p) nnCostFunction(p,input_layer_size, hidden_layer_size, XTotal, yTotal);
  [nn_params, cost] = fminunc(coste, Thetavec, options)
 
  
  #Reshape de las thetas
  Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)),hidden_layer_size, (input_layer_size + 1));
  Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end),1, (hidden_layer_size + 1));
  
  fprintf("Prediccion y tasa de acierto\n");
  p = predict(Theta1,Theta2,XTotal);
  pTotal = mean((p-yTotal) == 0)*100
  fprintf("Tasa de acierto con %i neuronas en la capa oculta = %f",hidden_layer_size,pTotal);
  
  #Recta de regresion o plot decision boundary
  plot_decision_boundary(Theta1,Theta2, XTotal, yTotal);
  
####% Weight regularization parameter (we set this to 0 here).
##lambda = 0;
##checkNNGradients(lambda);
##
##fprintf('\nProgram paused. Press enter to continue.\n');
##pause;
##
##
##%% =============== EJ2. Implement Backpropagation ===============
##%  You should proceed to implement the
##%  backpropagation algorithm for the neural network. You should add to the
##%  code you've written in nnCostFunction.m to return the partial
##%  derivatives of the parameters.
##%
##fprintf('\nChecking Backpropagation... \n');
##
##%  Check gradients by running checkNNGradients
##checkNNGradients;
##
##fprintf('\nProgram paused. Press enter to continue.\n');
##pause;
##
##
##%% ================ EJ3. Initializing Parameters ================
##%  In this part of the exercise, you will be starting to implement a two
##%  layer neural network that classifies digits. You will start by
##%  implementing a function to initialize the weights of the neural network
##%  (randInitializeWeights.m)
##
##fprintf('\nInitializing Neural Network Parameters ...\n')
##
##initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
##initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
##
##% Unroll parameters
##initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];
##
##
##%% =================== EJ4. Training NN ===================
##%  You have now implemented all the code necessary to train a neural 
##%  network. To train your neural network, we will now use "fmincg", which
##%  is a function which works similarly to "fminunc". Recall that these
##%  advanced optimizers are able to train our cost functions efficiently as
##%  long as we provide them with the gradient computations.
##%
##fprintf('\nTraining Neural Network... \n')
##
##%  After you have completed the assignment, change the MaxIter to a larger
##%  value to see how more training helps.
##options = optimset("GradObj", 'on', "MaxIter", 50);
##
##% Create "short hand" for the cost function to be minimized
##
##% Now, costFunction is a function that takes in only one argument (the
##% neural network parameters)
##
##coste = @(p) nnCostFunction(p, ...
##    X, y, num_labels, ...
##    hidden_layer_size, input_layer_size);
##
##[nn_params, cost] = fmincg(coste, initial_nn_params, options);
##
##% Obtain Theta1 and Theta2 back from nn_params
##
## Theta1 = reshape(nn_params(1:hidden_layer_size*(input_layer_size+1)), ...
##            hidden_layer_size, (input_layer_size+1));
## Theta2 = reshape(nn_params(hidden_layer_size*(input_layer_size+1)+1:end),...
##            num_labels, hidden_layer_size+1);
##
##
##fprintf('Program paused. Press enter to continue.\n');
##pause;
##
##
##%% ================= EJ5. Implement Predict =================
##%  After training the neural network, we would like to use it to predict
##%  the labels. You will now implement the "predict" function to use the
##%  neural network to predict the labels of the training set. This lets
##%  you compute the training set accuracy.
##
##%Devuelve todas las predicciones de toda la matriz
##%AL ESTAR "PREDICT" VECTORIZADO, ES LO MAS ÓPTIMO
##p1 = predict(X, Theta1, Theta2);
##%CON FORWARD
##for i=1:size(X,1)
##  [a1 a2 a3] = forward(Theta1, Theta2, X, i);
##  [value index] = max(a3);
##  p(i) = index;
##endfor
##
##pTotal = mean(double(p1 == y))*100;
##%pTotal = mean(double(p == y))*100;
##fprintf("Exactitud: %f\n", pTotal);

