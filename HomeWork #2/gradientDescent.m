function [theta J_history] = gradientDescent (X, y, theta,alpha, num_iter)    
    J_history = zeros(num_iter,1);
    m = length(X);
    for i = 1:num_iter
      h = sigmoid(X*theta);
      grad = (1/m) * (X'*(h-y));
      theta = theta - alpha * grad ;
      J_history(i) = computeCost(theta,X,y);
      fprintf("Theta at iteration %d: %f %f %f\n", i, theta);
    endfor
endfunction
