Cat Photo Recognizer - Copyright Micu Florian-Luis 2020

To run the algorithms, simply choose one of the folders
and run the file “checker_x” where x is the method name. The
standard homework checker was altered by me to print the 
correct prediction percentage as well as the execution time.

Important: I recommend using Octave on Linux as MATLAB runs
into some problems with the “test” function.

I added the original tasks information for reference (in romanian). Moreover,
I will explain the contents of each folder.

1. Householder Prediction:

Preprocess: I am creating a matrix of strings for the relative path of all the
photos after which I initiate the column vector "y" with "1" for the number of
photos with cats and "-1" for the number of photos without cats in this order.
After that, I populate the matrix "X" with the histograms of every photo 
(RGB/HSV).

Householder: utilizes the standard algorithm to "break" into more components
the matrix "A".

SST: I start by attributing the last element of the column vector “b” the last 
Value of “A”, after which I start ascending into the next line to get the next
Element of “b”. Moreover, since the matrix “A” is triangular superior, the 
solutions can be found very fast.

rgbHistogram: this algorithm heavily utilizes vectorizations as we need to
do per pixel calculations. I used the function “histc” in order to create a
frequency vector and I transformed the 3D matrix into three RGB vectors.
The distance vector was created by normalizing the values in the interval
[i * 256/count_bins; i * 256/count_bins + 256/count_bins). The last element
is deleted since it is garbage.

hsvHistogram: uses the same principle as RGB, however I transformed every
RGB coordinate into HSV with my implementation of “RGB2HSV”.
Learn: I take the matrix returned by “preprocess” and I add to it a new column 
“Bias”, after which I apply Householder. Furthermore, from the result I use 
the equivalence Ax = b  Rx = Q’b. SST returns the column vector “w”.

Evaluate: generates just like preprocess a matrix of histograms after which I
add the “Bias” and apply the equation y = w’ * X’. I verify if the “y” value is
positive for the cat pictures and negative for the non-cat pictures and I count
the correct number of predictions. The percentage is calculated by calculating
number of correct predictions divided by the number of total pictures.

2. Gradient Descent Prediction:

The functions “preprocess”, “hsvHistogram” and “rgbHistogram” are identical
to the ones used before.

Learn: I start by preparing the columns of the matrix using the formula
col = (col – mean(col)) / std(col) and I add the “Bias”. I choose random
values between [-0.1; 0.1] for the “w” that I use as argument for the
algorithm “mini batch gradient descending”.

Evaluate: is identical to the one used in Householder except I have to
prepare the column before.
