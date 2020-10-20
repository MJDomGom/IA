function multivariantEqnNormal(y,columnas,data,names,isTest)
  
   if(isTest == true)
    nSamples = columnas(1) * 0.7;
    dataR = data(randperm(size(data,1)),:);
    X = dataR(1:round(nSamples),1:size(dataR,2));
    y = X(:,columnas(2));
    XTest = dataR(round(nSamples) + 1:end, 1:size(dataR,2));
    yTest = XTest(:,columnas(2));
    X(:,columnas(2)) = [];
    X = [ones(length(X),1),X];
    XTest(:,columnas(2)) = [];
    XTest = [ones(length(XTest),1),XTest];
    
   else
    X = data(:,1:columnas(2) - 1);
    X = [ones(length(X),1),X];
  endif
  
  theta = zeros(length(names),1);
  %thetas optimas dadas por la ecuacion normalEqn
  theta = normalEqn(X,y);
 
if (isTest == true)
  predictionsT = XTest * theta;
else 
  predictions = X * theta;
endif  

fprintf("Vector de theta: ");
theta'

if (isTest == true)
  error = sum(abs(yTest .- predictionsT)/length(XTest));
else 
  error = sum(abs(y .- predictions)/length(X));
endif  

fprintf("Error absoluto medio = %f\n\n",error);

endfunction
