function thetasNorm = normalEqn (X, y)

  thetasNorm = pinv((X' * X)) * X' * y; 

endfunction
