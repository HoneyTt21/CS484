%This feature representation is described in the handout, lecture
%materials, and Szeliski chapter 14.

function image_feats = get_bags_of_words(image_paths)
% image_paths is an N x 1 cell array of strings where each string is an
% image path on the file system.

% This function assumes that 'vocab.mat' exists and contains an N x feature vector length
% matrix 'vocab' where each row is a kmeans centroid or visual word. This
% matrix is saved to disk rather than passed in a parameter to avoid
% recomputing the vocabulary every run.

% image_feats is an N x d matrix, where d is the dimensionality of the
% feature representation. In this case, d will equal the number of clusters
% or equivalently the number of entries in each image's histogram
% ('vocab_size') below.

% You will want to construct feature descriptors here in the same way you
% did in build_vocabulary.m (except for possibly changing the sampling
% rate) and then assign each local feature to its nearest cluster center
% and build a histogram indicating how many times each cluster was used.
% Don't forget to normalize the histogram, or else a larger image with more
% feature descriptors will look very different from a smaller version of the same
% image.

% parameter
cell_size = 16;
img_size = 360;
point_num = 20;

% setting
load('vocab.mat')
vocab_size = size(vocab, 1);
[N, ~] = size(image_paths);
image_feats = zeros(N, vocab_size);

x = 1:img_size/point_num:img_size;
[X, Y] = meshgrid(x, x);
points=zeros(point_num*point_num, 2);
for i = 1:point_num
    for j = 1:point_num
        points(20*i+j, 1) = X(i, j);
        points(20*i+j, 2) = Y(i, j);
    end
end

for i = 1:N
    disp(i);
    image = im2single(imread(image_paths{i}));
    image = imresize(image, [img_size img_size]);
    [vector, ~] = extractHOGFeatures(image, points, "cellsize", [cell_size cell_size]);
    ind = knnsearch(vocab, vector);
    his = [];
    his = histcounts(ind(:,1)', vocab_size)';
    his = his/norm(his);
    image_feats(i, :) = his';
end





