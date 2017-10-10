%% Initialization
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Data
trainingDataSet = load('training.txt');
% validationDataSet = load('validation.txt');
% testDataSet = load('test.txt');
%% n = num of features
%% m = num of instances
%% num_labels = num of chart types (25)
num_labels = 25;
[m, numOfCols] = size(trainingDataSet);
n = numOfCols - 1;

[X_normalized, mu, sigma] = featureNormalize(trainingDataSet);
X_train = [ones(m, 1), X_normalized(:, 1:n)];
y_train = trainingDataSet(:, n + 1);

% initial_theta = zeros(n + 1, 1);
% costFunc = @(p) costFunction(p, X_train, y_train, 0);
% [J grad] = costFunc(initial_theta);                         
% numericalGradients = computeNumericalGradient(costFunc, initial_theta);
% disp([numericalGradients grad]);

lambda = 0;
[all_theta] = oneVsAll(X_train, y_train, num_labels, lambda);


fprintf('Done');