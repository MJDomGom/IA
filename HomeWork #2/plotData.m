function plotData(X, y)
  figure(1);
  pos = find(y==1);
  neg = find(y==0);
  plot(X(pos,1), X(pos, 2), 'b+');
  hold on;
  plot(X(neg, 1), X(neg,2), 'r+');
endfunction
