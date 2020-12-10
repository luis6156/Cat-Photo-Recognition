function [X, y] = preprocess(path_to_dataset, histogram, count_bins)
  cats = strcat(path_to_dataset, 'cats/');
  not_cats = strcat(path_to_dataset, 'not_cats/');
  
  % Formez matricele cu calea catre fisiere
  catsMatrix = strcat(cats, getImgNames(cats));
  notCatsMatrix = strcat(not_cats, getImgNames(not_cats));
  
  [sizeCats aux] = size(catsMatrix);
  [sizeNotCats aux] = size(notCatsMatrix);
  
  % Initializez X si Y
  X = zeros(sizeCats + sizeNotCats, 3 * count_bins);
  y(1:sizeCats) = 1;
  y(sizeCats + 1:sizeCats + sizeNotCats) = -1;
  y = y';
  
  % Populez matricea X cu histogramele potrivite
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