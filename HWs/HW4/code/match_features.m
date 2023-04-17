% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% Please implement the "nearest neighbor distance ratio test", 
% Equation 4.18 in Section 4.1.3 of Szeliski. 
% For extra credit you can implement spatial verification of matches.

%
% Please assign a confidence, else the evaluation function will not work.
%

% This function does not need to be symmetric (e.g., it can produce
% different numbers of matches depending on the order of the arguments).

% Input:
% 'features1' and 'features2' are the n x feature dimensionality matrices.
%
% Output:
% 'matches' is a k x 2 matrix, where k is the number of matches. The first
%   column is an index in features1, the second column is an index in features2. 
%
% 'confidences' is a k x 1 matrix with a real valued confidence for every match.

function [matches, confidences] = match_features(features1, features2)

% % Placeholder random matches and confidences.
% num_features = min(size(features1, 1), size(features2,1));
% matches = zeros(num_features, 2);
% matches(:,1) = randperm(num_features); 
% matches(:,2) = randperm(num_features);
% confidences = rand(num_features,1);

% number of features
num_features = min(size(features1, 1), size(features2,1));
num1 = size(features1, 1);
num2 = size(features2, 1);

% distance
feat1 = sum(features1 .* features1, 2);
feat2 = sum(features2 .* features2, 2);

K = sqrt(ones(num1,1)*feat2' + feat1*ones(1,num2) - 2*features1*features2');

% confidences > 1
[B,I] = sort(K,2);
neighbor1 = B(:,1);
neighbor2 = B(:,2);
confidences = neighbor1 ./ neighbor2;

% use find
i = find(confidences);
s = size(i);
matches = zeros(s(1),2);
matches(:,1) = i; 
matches(:,2) = I(i);

% confidences in correct value
confidences = 1./confidences(i)
[confidences, index] = sort(confidences, 'descend');
matches = matches(index,:); 


end



% Remember that the NNDR test will return a number close to 1 for 
% feature points with similar distances.
% Think about how confidence relates to NNDR.