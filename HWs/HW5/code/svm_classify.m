function predicted_categories = svm_classify(train_image_feats, train_labels, test_image_feats)
% image_feats is an N x d matrix, where d is the dimensionality of the
%  feature representation.
% train_labels is an N x 1 cell array, where each entry is a string
%  indicating the ground truth category for each training image.
% test_image_feats is an M x d matrix, where d is the dimensionality of the
%  feature representation. You can assume M = N unless you've modified the
%  starter code.
% predicted_categories is an M x 1 cell array, where each entry is a string
%  indicating the predicted category for each test image.

% This function should train a linear SVM for every category (i.e., one vs all)
% and then use the learned linear classifiers to predict the category of
% every test image. Every test feature will be evaluated with all 15 SVMs
% and the most confident SVM will "win".
% 
% Confidence, or distance from the margin, is W*X + B:
% The learned hyperplane is represented as:
% - W, a row vector
% - B, a scalar bias or offset
% X is a column vector representing the feature, and
% * is the inner or dot product.

%
% A Strategy
% 
% - Use fitclinear() to train a 'one vs. all' linear SVM classifier.
% - Observe the returned model - it defines a hyperplane with weights 'Beta' and 'Bias'.
% - For a test feature point, manually compute the distance form the hyperplane using the model parameters.
% - Store the confidence.
% - Once you have a confidence for every category, assign the most confident category.
% 

% unique() is used to get the category list from the observed training category list. 
% 'categories' will not be in the same order as unique() sorts them. This shouldn't really matter, though.

% parameters
lambda = 0.0003;

% settings
categories = unique(train_labels);
num_categories = length(categories);
[N, ~] = size(test_image_feats);
scores = zeros(N, num_categories);
predicted_categories = cell([N 1]);

for i = 1:num_categories
    % get models from train feats
    labels = zeros(1, N);
    for j = 1:N
        if(strcmp(train_labels{j}, categories{i}))
            labels(1, j) = 1;
        else
            labels(1, j) = -1;
        end
    end
    mdl = fitclinear(train_image_feats, labels, "Lambda", lambda);
    % test images with model
    [~,score] = predict(mdl, test_image_feats);
    scores(:, i) = score(:, 2);
end

for i = 1:N
    [~, index] = max(scores(i,:));
    predicted_categories(i) = categories(index);
end

end

