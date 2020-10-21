function plotData(xTrain, yTrain, theta)
  figure(2);
  plot(xTrain, yTrain, 'rx');
  h = theta(1) + (theta(2)*xTrain);
  hold on;
  plot(xTrain, h, 'b');
endfunction
