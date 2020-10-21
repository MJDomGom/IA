function [bestAtrib,bestTheta] = plotRanking (X,y,theta,predictions,names,errores,cant,isTest, dataR, nSamples);
    X(:,length(names)) = [];
    mejoresX = [];
   for i = 1 : cant
     
      [M,index] = min(errores);
      fprintf("%s\n\n",names{index});
      mejoresX = [X(:,index) mejoresX];
      
      
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
   dataR = mejoresX;
   display("\n-------------------------------------------------------\n");
   fprintf("\nMULTIVARIABLE 5 MEJORES CON EL CONJUNTO DE DATOS COMPLETO\n");
   multivariantEqnNormal(y,columnas,mejoresX,names,false,dataR,nSamples);
   fprintf("\nMULTIVARIABLE 5 MEJORES CON 70-30\n");
   multivariantEqnNormal(y,columnas,mejoresX,names,isTest,dataR, nSamples);
   display("\n-------------------------------------------------------\n");
   endif
  
endfunction
