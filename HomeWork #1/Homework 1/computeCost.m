function J = computeCost(X, y, theta)
  J = (1/(2*length(y)))*((X*theta-y)' *(X*theta - y));
endfunction
