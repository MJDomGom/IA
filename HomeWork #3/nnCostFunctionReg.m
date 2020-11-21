function [J grad] = nnCostFunctionReg (nn_params, input_layer_size, hidden_layer_size, X, y,lambda)

    % Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
    % for our 3 layer neural network
    Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)),hidden_layer_size, (input_layer_size + 1));

    Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end),1, (hidden_layer_size + 1));

    % Setup some useful variables
    m = size(X, 1);

    % You need to return the following variables correctly 
    J = 0;
    Theta1_grad = zeros(size(Theta1));
    Theta2_grad = zeros(size(Theta2));

    DELTA1= zeros(hidden_layer_size,input_layer_size+1);
    DELTA2 = zeros(1,hidden_layer_size+1);

    suma = 0;

    for i=1:m
        [a1 a2 a3] = forward(Theta1, Theta2, X, i);
        delta3 = a3 - y(i);
        delta2 = (Theta2'* delta3) .* ((1-a2).*a2);
        delta2 = delta2(2:end);
        DELTA1 = DELTA1 + delta2 * a1';
        DELTA2 = DELTA2 + delta3 * a2';
        h = a3;
        aux1 = log(h);
        aux2 = log(1 - h);
        suma = suma + y(i) * aux1 + (1-y(i)) * aux2;
    end

    %Compute cost
    J = (-1/m)*suma;
    %Calculate reg
    reg = (lambda/(2*m)) * (sum(sum(Theta1.^2))+sum(sum(Theta2.^2)));
    J = J+reg; 
    %Compute the gradients
    Theta1_grad(:,1:end) = (1/m) * (DELTA1(:,1:end) + (lambda*Theta1));
    Theta2_grad(:,1:end) = (1/m) * (DELTA2(:,1:end)+ (lambda*Theta2));

    % Unroll gradients
    grad = [Theta1_grad(:) ; Theta2_grad(:)];
endfunction
