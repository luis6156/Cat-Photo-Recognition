function [Q, R] = Householder(A)
  [rows columns] = size(A);
  
  % Initializari
  I = eye(rows);
  A_prime = A;
  Q = 1;
  
  % Algoritmul Householder
  for i = 1:columns
    vector = A_prime(:, i);
  
    vector(i > 1 & 1:i-1) = 0;
    
    sigma = sign(vector(i)) * norm(vector);
    vector(i) += sigma;
    numerator = vector * vector';
    denominator = vector' * vector;
    
    H = I - 2 * numerator / denominator;
    A_prime = H * A_prime;
    
    Q *= transpose(H);
  endfor 
  
  R = A_prime;
endfunction