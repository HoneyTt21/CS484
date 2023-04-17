% Local Feature Stencil Code
% Written by James Hays for CS 143 @ Brown / CS 4476/6476 @ Georgia Tech

% Returns a set of interest points for the input image

% 'image' can be grayscale or color, your choice.
% 'descriptor_window_image_width', in pixels.
%   This is the local feature descriptor width. It might be useful in this function to 
%   (a) suppress boundary interest points (where a feature wouldn't fit entirely in the image, anyway), or
%   (b) scale the image filters being used. 
% Or you can ignore it.

% 'x' and 'y' are nx1 vectors of x and y coordinates of interest points.
% 'confidence' is an nx1 vector indicating the strength of the interest
%   point. You might use this later or not.
% 'scale' and 'orientation' are nx1 vectors indicating the scale and
%   orientation of each interest point. These are OPTIONAL. By default you
%   do not need to make scale and orientation invariant local features.
function [x, y, confidence, scale, orientation] = get_interest_points(image, descriptor_window_image_width)

% Implement the Harris corner detector (See Szeliski 4.1.1) to start with.
% You can create additional interest point detector functions (e.g. MSER)
% for extra credit.

% If you're finding spurious interest point detections near the boundaries,
% it is safe to simply suppress the gradients / corners near the edges of
% the image.

% The lecture slides and textbook are a bit vague on how to do the
% non-maximum suppression once you've thresholded the cornerness score.
% You are free to experiment. Here are some helpful functions:
%  BWLABEL and the newer BWCONNCOMP will find connected components in 
% thresholded binary image. You could, for instance, take the maximum value
% within each component.
%  COLFILT can be used to run a max() operator on each sliding window. You
% could use this to ensure that every interest point is at a local maximum
% of cornerness.

% % Placeholder that you can delete -- random points
% x = ceil(rand(500,1) * size(image,2));
% y = ceil(rand(500,1) * size(image,1));

% small, large gaussian filter -> sigma 2, 1 for each large, small filter
large_gaussian = fspecial('gaussian',9,2);
small_gaussian = fspecial('gaussian',3,1);

% parameters -> alpha is 0.06 as recommended by Szleski 
s = size(image); 
alpha = 0.06;

% gradient values of small-gaussian-filtered image
new_image = imfilter(image,small_gaussian);
image_db=im2double(new_image);
sobely= [1 ,0 ,-1; 2,0,-2; 1, 0 ,-1];
sobelx= [1,2,1; 0,0, 0; -1, -2 ,-1];
x_grad = conv2(image_db,sobelx,'same');
y_grad = conv2(image_db,sobely,'same');

% calculate grads : filter with large gaussian filter 
xy_grad = y_grad .* x_grad;
xy_grad = imfilter(xy_grad, large_gaussian); 
xx_grad = x_grad .* x_grad; 
xx_grad = imfilter(xx_grad, large_gaussian); 
yy_grad = y_grad .* y_grad;
yy_grad = imfilter(yy_grad, large_gaussian); 

% calculating harris value
% h = Ixx*Iyy - Ixy^2 - alpha * (Ixx + Iyy) ^2;
h = xx_grad .* yy_grad - xy_grad .^ 2 - alpha .* (xx_grad + yy_grad) .^ 2;

% getting rid of border
bor = zeros(s);
bor(descriptor_window_image_width+1 : end - descriptor_window_image_width, descriptor_window_image_width +1: end - descriptor_window_image_width) = 1;
h = h .* bor;

% if h value is larger than t, it is meaningful
t = .0005;
h = h.*(h>t);

%Non-Maximum Suppression : slide the given area as the maximum value, return max for only maximum values 
B = colfilt(h,[descriptor_window_image_width/2, descriptor_window_image_width/2], 'sliding', @max);
max = (h == B);
h = max.*h;

%V is confidence y is rows and x is columns
[y, x, confidence] = find(h);


% After computing interest points, here's roughly how many we return
% For each of the three image pairs
% - Notre Dame: ~1300 and ~1700
% - Mount Rushmore: ~3500 and ~4500
% - Episcopal Gaudi: ~1000 and ~9000

end

