function [p sumaP] = predict (X, theta)
  
  h = X*theta;
  p = round(sigmoid(h));
  sumaP = sum(p);

endfunction
