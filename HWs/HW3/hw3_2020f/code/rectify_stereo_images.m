%% HW3-c
% Given two homography matrices for two images, generate the rectified
% image pair.
function [rectified1, rectified2] = rectify_stereo_images(img1, img2, h1, h2)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Your code here
    temp1 = imwarp(img1, projective2d(h1));
    temp2 = imwarp(img2, projective2d(h2));
    
    [m1,n1] = size(temp1);
    [m2,n2] = size(temp2);
    
    m = max([m1,m2]);
    n = max([n1,n2]);
    
    data_path = '../data/scene/';
    feature_point = importdata([data_path, 'feature_points.txt']);
    pts1 = feature_point(1:8,1:2);
    pts2 = feature_point(1:8,3:4);
    
    x1 = pts1(1:8,1);
    y1 = pts1(1:8,2);
    x2 = pts2(1:8,1);
    y2 = pts2(1:8,2);
    
    x=42;
    y=18;
%     for i=1:8
%         [p,q] = transformPointsForward(projective2d(h1),x1(i),y1(i));
%         [r,s] = transformPointsForward(projective2d(h2),x2(i),y2(i));
%         x = x + p-r;
%         y = y + q-s;
%     end
%     x=ceil(x/8)
%     y=ceil(y/8)
    rectified1 = zeros(m+x,(n/3)+y,3);
    rectified2 = zeros(m+x,(n/3)+y,3);
    
    for i=1:m1
        for j=1:n1/3
            for k=1:3
                rectified1(i,j,k) = temp1(i,j,k);
            end
        end
    end
    for i=1:m2
        for j=1:n2/3
            for k=1:3
                rectified2(i+x,j+y,k) = temp2(i,j,k);
            end
        end
    end

    
    % Hint: Note that you should care about alignment of two images.
    % In order to superpose two rectified images, you need to create
    % certain amount of margin.
%     [rectified1, rectified2]=rectifyStereoImages(img1,img2,h1,h2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
