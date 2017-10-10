function [all_theta] = oneVsAll(X, y, num_labels, lambda)
%ONEVSALL trains multiple logistic regression classifiers and returns all
%the classifiers in a matrix all_theta, where the i-th row of all_theta 
%corresponds to the classifier for label i
%   [all_theta] = ONEVSALL(X, y, num_labels, lambda) trains num_labels
%   logistic regression classifiers and returns each of these classifiers
%   in a matrix all_theta, where the i-th row of all_theta corresponds 
%   to the classifier for label i

% Some useful variables
m = size(X, 1);
n = size(X, 2);
num_iters = 100;
initial_theta = zeros(n, 1);

% You need to return the following variables correctly 
all_theta = zeros(num_labels, n);

%% Set options for fminunc
options = optimset('GradObj', 'on', 'MaxIter', num_iters);

%% ONE vs ALL logit regression
%% Run fmincg to obtain the optimal theta
%% This function will return theta and the cost 

for label = 1:num_labels
  fprintf('Label: %f\n', label);
  costFunc = @(t)(costFunction(t, X, (y == label), lambda));
  [theta] = fmincg(costFunc, initial_theta, options);
  all_theta = [all_theta; theta'];
  
  % do the numerical gradients check
  [J grad] = costFunc(theta);

  numericalGradients = computeNumericalGradient(costFunc, theta);
  disp([numericalGradients grad]);
    
  diff = norm(numericalGradients - grad)/norm(numericalGradients + grad);
  fprintf('Relative Difference: %g\n', diff);
  fprintf('Program paused. Press enter to continue.\n');
  pause;
end

end
