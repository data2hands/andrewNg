function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

choice_C = [0.01 0.03 0.1 0.3 1 3 10 30];
choice_sigma = [0.01 0.03 0.1 0.3 1 3 10 30];
len = length(choice_C);
error = zeros(len,len);
min_error = 10^5;
min_C_index = 0;
min_sigma_index = 0;
for i=1:len
  C = choice_C(i);
  for j=1:len
    sigma = choice_sigma(j);
    model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
    pred = svmPredict(model, Xval);
    error(i,j) = mean(double(pred ~= yval));
    if error(i,j) <min_error
      min_error = error(i,j);
      min_C_index = i;
      min_sigma_index = j;
    endif
  endfor
endfor

C = choice_C(min_C_index)
sigma = choice_sigma(min_sigma_index)

% =========================================================================

end
