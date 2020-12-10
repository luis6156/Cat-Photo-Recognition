function [x] = SST(A, b)
  [rows columns] = size(A);
  
  % Add the last value of "x"
  x(columns) = b(columns) / A(columns, columns);
  x = x';
  
  % Start from the bottom to the top to get all components of "x"
  for i = columns-1:-1:1
   x(i) = (b(i) - sum(A(i,(i + 1):columns) * x((i + 1):columns))) ./ A(i, i);
  endfor
end
    