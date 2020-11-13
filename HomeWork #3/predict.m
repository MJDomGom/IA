function p = predict(Theta1, Theta2, X)
   m = size(X, 1);
   h1 = [ones(m,1) X] * Theta1';
   h1 = sigmoid(h1);
   h2 = [ones(m,1) h1] *  Theta2';
   h2 = sigmoid(h2);
   p =  round(h2);
endfunction
