function [sol] = hsvHistogram(path_to_image, count_bins)
  img = imread(path_to_image);
  
  % Creez vectorul de intervale
  val = 1.01 / count_bins;
  idx = 0:count_bins - 1;
  edges(idx + 1) = idx*val;
  edges(count_bins + 1) = 1.01;
  
  % Creez vectori cu pixelii RGB
  redVector = img(:, :, 1);
  greenVector = img(:, :, 2);
  blueVector = img(:, :, 3);
  redVector = redVector(:)';
  greenVector = greenVector(:)';
  blueVector = blueVector(:)';
  
  % RGBHSV cu normalizare
  redVector = (double)(redVector)./255;
  greenVector = (double)(greenVector)./255;
  blueVector = (double)(blueVector)./255;
  
  C_max = max(redVector, greenVector);
  C_max = max(C_max, blueVector);
  C_min = min(redVector, greenVector);
  C_min = min(C_min, blueVector);
  
  delta = C_max - C_min;
  idxNull = find(delta == 0);
  
  idxRed = find(C_max == redVector & delta != 0);
  idxGreen = find(C_max == greenVector & delta != 0);
  idxBlue = find(C_max == blueVector & delta != 0);
  hueVector(idxNull) = 0;
  hueVector(idxRed) = 60 * (mod((greenVector(idxRed) - blueVector(idxRed)) ...
                         ./ delta(idxRed), 6));
  hueVector(idxGreen) = 60 * ((blueVector(idxGreen) - redVector(idxGreen)) ...
                         ./ delta(idxGreen) + 2);
  hueVector(idxBlue) = 60 * ((redVector(idxBlue) - greenVector(idxBlue)) ...
                         ./ delta(idxBlue) + 4);
                         
  hueVector = hueVector ./ 360; % Vectorul Hue
  
  saturationVector(idxNull) = 0;
  saturationVector = delta./C_max; % Vectorul Saturation
  
  valueVector = C_max; % Vectorul de Value
  
  % Binning
  solH = histc(hueVector, edges);
  solS = histc(saturationVector, edges);
  solV = histc(valueVector, edges);
  
  % Sterg ultimul element "0" din vectori
  solH(count_bins + 1) = [];
  solS(count_bins + 1) = [];
  solV(count_bins + 1) = [];
  
  sol = [solH, solS, solV];
end