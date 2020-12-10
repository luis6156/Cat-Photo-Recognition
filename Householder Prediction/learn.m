function [w] = learn(X, y)
  [rows columns] = size(X);

  % Bias
  X(:, columns + 1) = 1;
  
  % Aflu QR din Householder
  [Q R] = Householder(X);
  
  % Formez Ax=b <=> Rx=Q'b
  y_new = Q' * y;
  
  % Fac SST pe noua ecuatie
  w = SST(R, y_new);
end
