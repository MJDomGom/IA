function p = predict (X, theta)
  
  h = X*theta;
  p = round(sigmoid(h));

endfunction
