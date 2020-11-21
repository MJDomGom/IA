function plot_decision_boundary(Theta1,Theta2, X, y, i)
    % Set min and max values and give it some padding
    x_min = min(min(X(1, :)),-0.6);
    x_max = min(max(X(1, :)),0.3);
    y_min = min(min(X(2, :)),-0.8);
    y_max = max(max(X(2, :)),0.6);
    h = 0.001;

    % Generate a grid of points with distance h between them
    xx = [x_min:h:x_max];
    yy = [y_min:h:y_max];
    
    % Predict the function value for the whole grid
    [X1,Y1] = meshgrid(xx,yy);
    v=[X1(:) Y1(:)];
    Z = predict(Theta1, Theta2, v);
    Z = reshape(Z,size(X1));
    
    % Plot the contour and examples
    figure(i); % open a new figure window
    contour(X1,Y1,Z,'LineColor','b');
    hold on;
    ylabel('x2');
    xlabel('x1');
    plotData(X,y);
end
