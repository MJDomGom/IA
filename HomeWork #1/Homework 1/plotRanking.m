function [bestAtrib,bestTheta] = plotRanking (X,y,theta,predictions,names,errores,cant,isTest);
    X(:,length(names)) = [];
    mejoresX = [];
   for i = 1 : cant
     
     %PONER COMENTARIO CONSOLA COMANDOS NO MUESTRA TODO
     
      [M,index] = min(errores);
      fprintf("Datos para la variable %s\n\n",names{index});
      mejoresX = [X(:,index) mejoresX];
      
      %Dibujar recta de regresion
      if(i == 1)      
      bestAtrib = index;
      bestTheta =  [theta(i,1) theta(i,2)];     
      endif
    
      fprintf("Theta0 = %f\tTheta1 = %f\n",theta(i,1),theta(i,2));
      fprintf("Error absoluto medio = %f\n\n",errores(index));
      X(:,index) = [];
      errores(index) = [];
      predictions(:,index) = [];
      names(:,index) = [];
   endfor
  
   
   if (isTest == true)
   names = ones(1,cant);
   mejoresX = [mejoresX y];
   columnas = size(mejoresX);
   fprintf("\n\nRegresion lineal multivariable utilizando las mejores 5 variables del ranking donde train = test\n\n");
   multivariantEqnNormal(y,columnas,mejoresX,names,false);
   fprintf("\n\nRegresion lineal multivariable utilizando las mejores 5 variables del ranking donde 70train 30test\n\n");
   multivariantEqnNormal(y,columnas,mejoresX,names,isTest);
   endif
  
endfunction
