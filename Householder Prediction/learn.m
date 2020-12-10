function [w] = learn(X, y)
  [rows columns] = size(X);

  % Bias
  X(:, columns + 1) = 1;
  
  % Get QR from Householder
  [Q R] = Householder(X);
  
  % Form Ax=b <=> Rx=Q'b
  y_new = Q' * y;
  
  % Get "w" by using SSY on the new equation
  w = SST(R, y_new);
end
