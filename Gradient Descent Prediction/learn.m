function [w] = learn(X, y, lr, epochs)
  [rows columns] = size(X);
  batch_size = 64;
  
  % Prepare columns
  X(:, 1:columns) = (X(:, 1:columns) - mean(X(:, 1:columns))) ...
                    ./ std(X(:, 1:columns));
   
  % Bias 
  X(:, columns + 1) = 1;
  
  % W intialy random
  wMin = -0.1;
  wMax = 0.1;
  w = wMin + (wMax - wMin).*rand(columns + 1, 1);
  
  % Learn algorithm
  theta = lr / rows;
  for epoch = 1:epochs
    idx = randperm(rows);
    
    X_batch = X(idx(1:batch_size), :);
    y_batch = y(idx(1:batch_size));
    
    phi = sum((X_batch(1:batch_size, :) * w - y_batch(1:batch_size)) ...
          .* X_batch(1:batch_size, 1:columns + 1));
      
    w(1:columns + 1) = w(1:columns + 1) - theta * phi(:); 
  endfor
endfunction
