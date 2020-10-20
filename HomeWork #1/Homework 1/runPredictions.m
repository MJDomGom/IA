function [errorAbs,predictions] = runPredictions (X, thetas,name,y);
  error = 0;
  X(:,1) = [];
  predict = [1]; 

  for i = 1:length(X)
    val = [1,X(i)];
    predicc = val * thetas;
    predict = [predict ; val*thetas];
    error = error + abs(y(i)-predicc);
  endfor

  predict(1) = [];
  predictions = predict;
  errorAbs = error/length(X);


endfunction
