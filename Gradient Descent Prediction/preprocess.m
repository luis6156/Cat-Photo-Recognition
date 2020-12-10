function [X, y] = preprocess(path_to_dataset, histogram, count_bins)
  cats = strcat(path_to_dataset, 'cats/');
  not_cats = strcat(path_to_dataset, 'not_cats/');
  
  % Create matrix with the path of the files
  catsMatrix = strcat(cats, getImgNames(cats));
  notCatsMatrix = strcat(not_cats, getImgNames(not_cats));
  
  [sizeCats aux] = size(catsMatrix);
  [sizeNotCats aux] = size(notCatsMatrix);
  
  % Initialize X and Y
  X = zeros(sizeCats + sizeNotCats, 3 * count_bins);
  y(1:sizeCats) = 1;
  y(sizeCats + 1:sizeCats + sizeNotCats) = -1;
  y = y';
  
  % Populate matrix X with the right histograms
  if strcmp(histogram, 'HSV')
    for i = 1:sizeCats
      X(i, :) = hsvHistogram(catsMatrix(i, :), count_bins);
    endfor
    for i = 1:sizeNotCats
      X(sizeCats + i, :) = hsvHistogram(notCatsMatrix(i, :), count_bins);
    endfor
  else
    for i = 1:sizeCats
      X(i, :) = rgbHistogram(catsMatrix(i, :), count_bins);
    endfor
    for i = 1:sizeNotCats
      X(sizeCats + i, :) = rgbHistogram(notCatsMatrix(i, :), count_bins);
    endfor
  endif
endfunction