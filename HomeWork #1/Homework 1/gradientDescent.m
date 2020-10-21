function [theta, JHistory] = gradientDescent(X, y, theta,alpha, iterations)
   JHistory = zeros(iterations,1);
   m = length(y);
   for i = 1:iterations
    theta = theta - (alpha * (1/m) * (X' * (X * theta - y)));
    JHistory(i) = computeCost(X, y, theta);;
   endfor
endfunction
