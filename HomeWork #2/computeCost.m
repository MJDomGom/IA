function J = computeCost (theta, X, y)

  m = length(X);
  h = sigmoid(X* theta);
  J = -1/m * (sum(y.*log(h) + (1-y).*log(1-h)));

endfunction
