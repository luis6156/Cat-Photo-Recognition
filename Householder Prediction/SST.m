function [x] = SST(A, b)
  [rows columns] = size(A);
  
  % Pun ultima valoare a lui "x"
  x(columns) = b(columns) / A(columns, columns);
  x = x';
  
  % Plec de jos in sus si aflu restul componentelor lui "x"
  for i = columns-1:-1:1
   x(i) = (b(i) - sum(A(i,(i + 1):columns) * x((i + 1):columns))) ./ A(i, i);
  endfor
end
    