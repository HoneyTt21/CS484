%This function will predict the category for every test image by finding
%the training image with most similar features. Instead of 1 nearest
%neighbor, you can vote based on k nearest neighbors which will increase
%performance (although you need to pick a reasonable value for k).

function predicted_categories = nearest_neighbor_classify(train_image_feats, train_labels, test_image_feats)
% train_image_feats is an N x d matrix, where d is the dimensionality of the
%  feature representation.
% train_labels is an N x 1 cell array, where each entry is a string
%  indicating the ground truth category for each training image.
% test_image_feats is an M x d matrix, where d is the dimensionality of the
%  feature representation. You can assume M = N unless you've modified the
%  starter code.
% predicted_categories is an M x 1 cell array, where each entry is a string
%  indicating the predicted category for each test image.

% Useful functions:
%  matching_indices = strcmp(string, cell_array_of_strings)
%    This can tell you which indices in train_labels match a particular
%    category. Not necessary for simple one nearest neighbor classifier.
 
%   [Y,I] = MIN(X) if you're only doing 1 nearest neighbor, or
%   [Y,I] = SORT(X) if you're going to be reasoning about many nearest
%   neighbors 

% let Metric as L2
N = size(train_image_feats, 1);
X = test_image_feats';
Y = train_image_feats';
for i = 1:N 
    for j = 1:N
        D(i,j) = sum((X(:,i) - Y(:,j)).*(X(:,i) - Y(:,j)));
    end
end

% k value here
predicted_categories = cell(N, 1);
k = 1;

for i = 1:N
    % sort D by rows 
    [~, ind] = sort(D(:, i));
    ind = ind(1:k);
    
    % mode of labels
    temp = cell(k,1);
    for j = 1:k
        temp{j,1} = train_labels{ind(j),1};
    end
    y = unique(temp);
    n = zeros(length(y), 1);
    for iy = 1:length(y)
      n(iy) = length(find(strcmp(y{iy}, temp)));
    end
    [~, itemp] = max(n);
    predicted_categories{i,1} = y{itemp};
end

end 
