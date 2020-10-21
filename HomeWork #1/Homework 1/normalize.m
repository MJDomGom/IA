function pred = normalize(pred)
  media = mean(pred);
  des = std(pred);
  pred = (pred -  media)./des;
endfunction
