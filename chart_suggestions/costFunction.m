function [J, grad] = costFunction(theta, X, y, lambda)
%LRCOSTFUNCTION Compute cost and gradient for logistic regression with 
%regularization
%   J = LRCOSTFUNCTION(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples
grad = zeros(size(theta));

J = (1 / m ) * (-y' * log(sigmoid(X * theta)) - (1 - y)' * log(1 - sigmoid(X * theta)));

grad = (1 / m) * (X' * (sigmoid(X * theta) - y));

grad = grad(:);

end
