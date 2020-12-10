function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  cats = strcat(path_to_testset, 'cats/');
  not_cats = strcat(path_to_testset, 'not_cats/');
  
  % Formez matricele cu calea catre fisiere
  catsMatrix = strcat(cats, getImgNames(cats));
  notCatsMatrix = strcat(not_cats, getImgNames(not_cats));
  
  [sizeCats aux] = size(catsMatrix);
  [sizeNotCats aux] = size(notCatsMatrix);
  
  % Initializez X, numarul de coloane si numarul total de poze
  columns = 3 * count_bins;
  total = sizeCats + sizeNotCats;
  X = zeros(total, columns);
  
  % Populez matricea X cu histogramele potrivite si verific output-ul
  if strcmp(histogram, 'HSV')
    for i = 1:sizeCats
      X(i, :) = hsvHistogram(catsMatrix(i, :), count_bins);
    endfor
    for i = 1:sizeNotCats
      X(sizeCats + i, :) = hsvHistogram(notCatsMatrix(i, :), count_bins);
    endfor
    % Bias
    X(:, columns + 1) = 1;
    % Verificarea output-ului
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
    % Verificarea output-ului
    y = w' * X';
    ok = sum(y(1:sizeCats) >= 0);
    ok += sum(y(sizeCats + 1:total) < 0);
  endif
  
  % Calculez procentajul
  percentage = ok / total
endfunction