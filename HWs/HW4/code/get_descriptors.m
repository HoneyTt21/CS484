% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% Returns a set of feature descriptors for a given set of interest points. 

% 'image' can be grayscale or color, your choice.
% 'x' and 'y' are nx1 vectors of x and y coordinates of interest points.
%   The local features should be centered at x and y.
% 'descriptor_window_image_width', in pixels, is the local feature descriptor width. 
%   You can assume that descriptor_window_image_width will be a multiple of 4 
%   (i.e., every cell of your local SIFT-like feature will have an integer width and height).
% If you want to detect and describe features at multiple scales or
% particular orientations, then you can add input arguments.

% 'features' is the array of computed features. It should have the
%   following size: [length(x) x feature dimensionality] (e.g. 128 for
%   standard SIFT)

function [features] = get_features(image, x, y, descriptor_window_image_width)

% To start with, you might want to simply use normalized patches as your
% local feature. This is very simple to code and works OK. However, to get
% full credit you will need to implement the more effective SIFT descriptor
% (See Szeliski 4.1.2 or the original publications at
% http://www.cs.ubc.ca/~lowe/keypoints/)

% Your implementation does not need to exactly match the SIFT reference.
% Here are the key properties your (baseline) descriptor should have:
%  (1) a 4x4 grid of cells, each descriptor_window_image_width/4. 'cell' in this context
%    nothing to do with the Matlab data structue of cell(). It is simply
%    the terminology used in the feature literature to describe the spatial
%    bins where gradient distributions will be described.
%  (2) each cell should have a histogram of the local distribution of
%    gradients in 8 orientations. Appending these histograms together will
%    give you 4x4 x 8 = 128 dimensions.
%  (3) Each feature should be normalized to unit length
%
% You do not need to perform the interpolation in which each gradient
% measurement contributes to multiple orientation bins in multiple cells
% As described in Szeliski, a single gradient measurement creates a
% weighted contribution to the 4 nearest cells and the 2 nearest
% orientation bins within each cell, for 8 total contributions. This type
% of interpolation probably will help, though.

% You do not have to explicitly compute the gradient orientation at each
% pixel (although you are free to do so). You can instead filter with
% oriented filters (e.g. a filter that responds to edges with a specific
% orientation). All of your SIFT-like feature can be constructed entirely
% from filtering fairly quickly in this way.

% You do not need to do the normalize -> threshold -> normalize again
% operation as detailed in Szeliski and the SIFT paper. It can help, though.

% Another simple trick which can help is to raise each element of the final
% feature vector to some power that is less than one.

%Placeholder that you can delete. Empty features.
% features = zeros(size(x,1), 128, 'single')

% variables
half_width = descriptor_window_image_width/2;
quar_width = descriptor_window_image_width/4;
points_num = size(x);
image_size = size(image); 
image_rows = image_size(1);
image_cols = image_size(2);
features = zeros(points_num(1),128);

% Use sobel filter to rotate image in certain direction and calculate gradient  
filter = [];
m = fspecial('sobel'); 
filter(:,:,1) = m;
for i=2:8 
    % rotating sobel filter 45 degrees from former one
    m = [m(4) m(7) m(8); m(1) m(5) m(9); m(2) m(3) m(6)];
    filter(:,:,i) = m;
end

% new_image is an image containing 8 copies of images filtered by 8 sober
% filters
new_image = zeros(image_size(1),image_size(2),8); 
for i=1:8 
    new_image(:,:,i) = imfilter(image,filter(:,:,i)); 
end

% filter with gaussian, sigma = half_width
gauss_filter = fspecial('gaussian', [half_width, half_width], half_width);
new_image = imfilter(new_image, gauss_filter);

% for all points
for i=1:points_num(1)
    ith_x = uint16(x(i));
    ith_y = uint16(y(i));     
    x_left = ith_x-half_width;
    x_right = ith_x+half_width-1;
    y_top = ith_y-half_width;
    y_bottom= ith_y+half_width-1;
    bins = zeros(1,128);
    
    % if the point is in the middle
    if x_left >= 1 & x_right <= image_cols-half_width & y_top >=1 & y_bottom <= image_rows-half_width  
        
        % for all directions
        for j=1:8
        	image = new_image(:,:,j); 
            patch = image(y_top:y_bottom, x_left:x_right);
            
            % divide to 16 cells
            small_square = mat2cell(patch,[quar_width,quar_width,quar_width,quar_width], [quar_width,quar_width,quar_width,quar_width]);
            
            % 1~8 is for first cell, 9~16 for second cell, ... , 8n-7 ~ 8n
            % for nth cell -> save in bin
            c = j;
            for row=1:4 
                for col=1:4
                    cell = cell2mat(small_square(row,col));
                    val = sum(cell(:));
                    bins(:,c) = val;
                    c = c+8;
                end
            end
        end
        
        % normalize and save
        bins = bins./norm(bins);
        features(i,:) = bins(1,:); 
    end
end 
end











