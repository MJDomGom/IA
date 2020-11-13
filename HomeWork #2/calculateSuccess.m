function tasaAcierto = calculateSuccess (p, y)
  
  Paciertos = 0;
  Pfallos = 0;
  
  for i=1:length(p)
    if(p(i) == y(i))
      Paciertos = Paciertos + 1;
    else
      Pfallos = Pfallos + 1;
    endif        
  endfor

  tasaAcierto = (Paciertos / (Paciertos + Pfallos))*100;
  
endfunction
