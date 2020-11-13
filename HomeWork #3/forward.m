function [a1 a2 a3] = forward(Theta1, Theta2, X, i)
  a1 = X(i,:)';
  a1 = [1;a1]; % bias + neuronas de la capa 1
  z2 = Theta1 * a1;
  a2 = sigmoid(z2);
  a2 = [1;a2]; % bias + neuronas de la capa 2
  z3 = Theta2 * a2;
  a3 = sigmoid(z3); % Salida de la capa 3
endfunction