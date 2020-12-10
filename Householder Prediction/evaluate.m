function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  cats = strcat(path_to_testset, 'cats/');
  not_cats = strcat(path_to_testset, 'not_cats/');
  
  % Create matrix with the path of the files
  catsMatrix = strcat(cats, getImgNames(cats));
  notCatsMatrix = strcat(not_cats, getImgNames(not_cats));
  
  [sizeCats aux] = size(catsMatrix);
  [sizeNotCats aux] = size(notCatsMatrix);
  
  % Initialize X, number of columns and total number of photos
  columns = 3 * count_bins;
  total = sizeCats + sizeNotCats;
  X = zeros(total, columns);
  
  % Populate matrix X with the right histograms and verify output
  if strcmp(histogram, 'HSV')
    for i = 1:sizeCats
      X(i, :) = hsvHistogram(catsMatrix(i, :), count_bins);
    endfor
    for i = 1:sizeNotCats
      X(sizeCats + i, :) = hsvHistogram(notCatsMatrix(i, :), count_bins);
    endfor
    % Bias
    X(:, columns + 1) = 1;
    % Verify output
    y = w' * X';
    ok = sum(y(1:sizeCats) >= 0);
    ok += sum(y(sizeCats + 1:total) < 0);
  else
    for i = 1:sizeCats
      X(i, :) = rgbHistogram(catsMatrix(i, :), count_bins);
    endfor
    for i = 1:sizeNotCats
      X(sizeCats + i, :) = rgbHistogram(notCatsMatrix(i, :), count_bins);
    endfor
    % Bias
    X(:, columns + 1) = 1;
    % Verify output
    y = w' * X';
    ok = sum(y(1:sizeCats) >= 0);
    ok += sum(y(sizeCats + 1:total) < 0);
  endif
  
  % Calculate the percentage
  disp("Accuracy: ")
  percentage = ok / total
  
endfunction