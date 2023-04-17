% This function will extract a set of feature descriptors from the training images,
% cluster them into a visual vocabulary with k-means,
% and then return the cluster centers.

% Notes:
% - To save computation time, we might consider sampling from the set of training images.
% - Per image, we could randomly sample descriptors, or densely sample descriptors,
% or even try extracting descriptors at interest points.
% - For dense sampling, we can set a stride or step side, e.g., extract a feature every 20 pixels.
% - Recommended first feature descriptor to try: HOG.

% Function inputs: 
% - 'image_paths': a N x 1 cell array of image paths.
% - 'vocab_size' the size of the vocabulary.

% Function outputs:
% - 'vocab' should be vocab_size x descriptor length. Each row is a cluster centroid / visual word.

function vocab = build_vocabulary( image_paths, vocab_size )

% parameter
cell_size = 16;
img_size = 360;
point_num = 20;

% setting
[N, ~] = size(image_paths);
vectors = [];

x = 1:img_size/point_num:img_size;
[X, Y] = meshgrid(x, x);
points=zeros(point_num*point_num, 2);
for i = 1:point_num
    for j = 1:point_num
        points(20*i+j-20, 1) = X(i, j);
        points(20*i+j-20, 2) = Y(i, j);
    end
end

for i = 1:N
    disp(i);
    image = im2single(imread(image_paths{i}));
    image = imresize(image, [img_size img_size]);
    [vector, ~] = extractHOGFeatures(image, points, "cellsize", [cell_size cell_size]);
    vectors = [vectors; vector];
end
s = size(vectors);
[~, vocab] = kmeans(single(vectors), vocab_size);

end
