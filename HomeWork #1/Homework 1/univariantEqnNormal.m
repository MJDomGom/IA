function [bestAtrib,bestTheta] = univariantEqnNormal (y,columnas,data,names,isTest);
  
  errores = [1];  
  thetasTot = [];
  
  if(isTest == true)
    nSamples = columnas(1) * 0.7;
    dataR = data(randperm(size(data,1)),:);
    XTrain = dataR(1:round(nSamples),1:size(dataR,2));
    yTrain = XTrain(:,columnas(2));
    XTest = dataR(round(nSamples) + 1:end, 1:size(dataR,2));
    yTest = XTest(:,columnas(2));
    %XTrain = [ones(length(XTrain),1),XTrain];
    XTrain(:,columnas(2)) = [];
    %XTest = [ones(length(XTest),1),XTest];
    XTest(:,columnas(2)) = [];    
    predicts = ones(length(yTest),length(names)-1);
    
    for i = 1:columnas(2)-1

    X = XTrain(:,i);
    X = [ones(length(X),1),X];
    XT = XTest(:,i);
    XT = [ones(length(XT),1),XT];
    
    theta = zeros(2,1);
    % Avegurar valor de theta usando la ecuacion normal
    theta = normalEqn(X,yTrain);
    [error,predict] = runPredictions(XT,theta,names{i},yTest);
    errores = [errores ; error];  
    predicts(:,i) = predicts(:,i) .* predict;
    thetasTot = [thetasTot theta];
  endfor
    thetasTot = thetasTot';
    errores(1) = [];
    fprintf("Ranking con todos las variables\n");
    plotRanking(data,y,thetasTot,predicts,names,errores,length(names)-1,false)
    fprintf("\n\nRanking con los mejores 5\n");
    cantidad = 5;
    [bestAtrib,bestTheta] = plotRanking(data,y,thetasTot,predicts,names,errores,cantidad,true);
    
  else
    
    predicts = ones(length(y),length(names)-1);
    for i = 1:columnas(2)-1

    X = data(:,i);
    theta = zeros(2,1);
    % Anada una columna con todos sus elementos a 1 a la matriz X como primera columna, e inicializar los parametros theta a 0
    X = [ones(length(X),1), X];
    % Avegurar valor de theta usando la ecuacion normal
    theta = normalEqn(X,y);
    [error,predict] = runPredictions(X,theta,names{i},y);
    errores = [errores ; error];  
    predicts(:,i) = predicts(:,i) .* predict;
    thetasTot = [thetasTot theta];
  
endfor
    thetasTot = thetasTot';
    errores(1) = [];
    fprintf("Ranking con todos las variables\n");
    plotRanking(data,y,thetasTot,predicts,names,errores,length(names)-1,false)
    fprintf("\n\nRanking con los mejores 5\n");
    cantidad = 5;
    plotRanking(data,y,thetasTot,predicts,names,errores,cantidad,true)

  endif
    
endfunction
