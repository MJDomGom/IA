%%HOMEWORK DE REGRESIÓN LOGÍSTICA
%%MANUEL JESÚS DOMÍNGUEZ GÓMEZ
%%NEREA MÁRQUEZ EGEA

clear ; close all; clc;

display("\n***********1. CARGA Y VISUALIZACIÓN***********\n");
data = load ('dataset_2.csv');
X = data(:, 2:size(data, 2));
y = data(:, 1);
num_iter = 100; 
alpha = 0.000015;
plotData(X,y);

display("\n***********2. REGRESIÓN LOGÍSTICA***********\n");
theta = zeros(size(X,2) + 1,1);
X = [ones(length(X),1) X];
[cost grad] = costFunction(theta, X, y);
fprintf("Función coste paranum_iter=%d y alfa=%f:\n");
fprintf("Cost at initial theta (zeros): %f\n", cost);

fprintf("Gradient at initial theta (zeros):\n %f \n %f \n %f \n",grad);
fprintf("Función descenso del gradiente para num_iter=%d y alfa=%f\n", num_iter, alpha);
[theta,J_history] = gradientDescent(X,y ,theta, alpha,num_iter);

display("\n***********2. REGRESIÓN LOGÍSTICA PREDICCION***********\n");
prediccion = predict(X,theta);
tasaAcierto = calculateSuccess(prediccion,y);
fprintf("Tras %d iteraciones con alpha de %f, la tasa de acierto seria de %f%%\n",num_iter, alpha, tasaAcierto);

plotDecisionBoundary(theta,X,y);
title(sprintf("Tasa Acierto: %.2f%%", tasaAcierto));

figure(2);
plot(1:num_iter, J_history, "-b", "LineWidth", 2);
title('Descenso del gradiente de la regresión logística');
xlabel("Iteraciones");
ylabel("Coste");

display("\n***********3. REGRESIÓN LOGÍSTICA OPTIMIZADA***********");
iter = 5000;
XExp = mapFeature(X(:,2),X(:,3));
theta_initial = zeros(size(XExp,2),1);

options = optimset('GradObj','on','MaxIter',iter);
[theta_initial cost] = fmincg(@(t)(costFunction(t,XExp,y)),theta_initial,options);

predictionExp = predict(XExp,theta_initial);
tasaAciertoExp = calculateSuccess(predictionExp,y);
fprintf("Tras %d de interaciones, la tasa de acierto seria de %f%%\n",iter, tasaAciertoExp);

plotDecisionBoundary(theta_initial,XExp,y);
title(sprintf("Tasa Acierto: %.2f%%", tasaAciertoExp));
