function error = calculateError(XTest, theta, yTest)
  error = sum(abs(XTest*theta-yTest))/length(yTest);
##  m = length(yTest);
##  error = (1/(2*m)) * ((XTest * theta - yTest)' * (XTest * theta - yTest));
endfunction
