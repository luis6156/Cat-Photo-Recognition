function [sol] = rgbHistogram(path_to_image, count_bins)
  img = imread(path_to_image);
  
  % Create interval array
  val = 256 / count_bins;
  idx = 0:count_bins - 1;
  edges(idx + 1) = idx*val;
  edges(count_bins + 1) = 256;
  
  % RGB array
  redVector = img(:, :, 1);
  greenVector = img(:, :, 2);
  blueVector = img(:, :, 3);
  redVector = redVector(:)';
  greenVector = greenVector(:)';
  blueVector = blueVector(:)';
  
  % Binning
  solR = histc(redVector, edges);
  solG = histc(greenVector, edges);
  solB = histc(blueVector, edges);
  
  % Delete last element "0" from arrays
  solR(count_bins + 1) = [];
  solG(count_bins + 1) = [];
  solB(count_bins + 1) = [];
  
  sol = [solR, solG, solB];
end