%% HW3-d
% Generate the disparity map from two rectified images. Use NCC for the
% mathing cost function.
function d = calculate_disparity_map(img_left, img_right, window_size, max_disparity)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Your code here
    %% Using NCC
    [m,n] = size(img_left);
    cost_vol = zeros(m,n,max_disparity);
    for p=1-ceil(-window_size/2):m-ceil(window_size/2)
        for q=1-ceil(-window_size/2):n-ceil(window_size/2)
            %win_l
            win_l = zeros(window_size, window_size);
            mean_l = 0;
            for i=ceil(-window_size/2):ceil(window_size/2)
                for j=ceil(-window_size/2):ceil(window_size/2)
                    win_l(i+1-ceil(-window_size/2), j+1-ceil(-window_size/2))= img_left(p+i, q+j);
                    mean_l = mean_l + img_left(p+i, q+j);
                end
            end
            mean_l=mean_l/(window_size*window_size);
            %win_r
            for d = 1:max_disparity
                win_r = zeros(window_size, window_size);
                mean_r = 0;
                if p+i+d <= m
                    for i=ceil(-window_size/2):ceil(window_size/2)
                        for j=ceil(-window_size/2):ceil(window_size/2)
                            win_l(i+1-ceil(-window_size/2), j+1-ceil(-window_size/2))= img_right(p+i+d, q+j);
                            mean_r = mean_r + img_left(p+i+d, q+j);
                        end
                    end
                    mean_r=mean_r/(window_size*window_size);
                    % subtract mean
                    for i=1:window_size
                        for j=1:window_size
                            win_l(i,j)=win_l(i,j)-mean_l;
                            win_r(i,j)=win_r(i,j)-mean_r;
                        end
                    end
                    % calculate ncc
                    abvec = 0;
                    a2vec = 0;
                    b2vec = 0;
                    for i=1:window_size
                        for j=1:window_size
                            abvec = abvec + win_l(i,j)*win_r(i,j);
                            a2vec = a2vec + win_l(i,j)*win_l(i,j);
                            b2vec = b2vec + win_r(i,j)*win_r(i,j);
                        end
                    end
                    ncc = abvec/(sqrt(a2vec)*sqrt(b2vec));
                else ncc=0;
                end
                cost_vol(p,q,d) = ncc;
            end
        end
    end
    % for edges
    for p=1:-ceil(-window_size/2)
        for q=1:-ceil(-window_size/2)
            for d = 1:max_disparity
                cost_vol(p,q,d) = cost_vol(1-ceil(-window_size/2),1-ceil(-window_size/2),d);
            end
        end
        for q=n-ceil(window_size/2)+1:n
            for d = 1:max_disparity
                cost_vol(p,q,d) = cost_vol(1-ceil(-window_size/2),n-ceil(window_size/2),d);
            end
        end
        for q=1-ceil(-window_size/2):n-ceil(window_size/2)
            for d = 1:max_disparity
                cost_vol(p,q,d) = cost_vol(1-ceil(-window_size/2),q,d);
            end
        end
    end
    for p=m-ceil(window_size/2)+1:m
        for q=1:-ceil(-window_size/2)
            for d = 1:max_disparity
                cost_vol(p,q,d) = cost_vol(m-ceil(window_size/2),1-ceil(-window_size/2),d);
            end
        end
        for q=n-ceil(window_size/2)+1:n
            for d = 1:max_disparity
                cost_vol(p,q,d) = cost_vol(m-ceil(window_size/2),n-ceil(window_size/2),d);
            end
        end
        for q=1-ceil(-window_size/2):n-ceil(window_size/2)
            for d = 1:max_disparity
                cost_vol(p,q,d) = cost_vol(m-ceil(window_size/2),q,d);
            end
        end
    end
    for q=1:-ceil(-window_size/2)
        for p=1-ceil(-window_size/2):m-ceil(window_size/2)
            for d = 1:max_disparity
                cost_vol(p,q,d) = cost_vol(p,1-ceil(-window_size/2),d);
            end
        end
    end
    for q=n-ceil(window_size/2)+1:n
        for p=1-ceil(-window_size/2):m-ceil(window_size/2)
            for d = 1:max_disparity
                cost_vol(p,q,d) = cost_vol(p,n-ceil(window_size/2),d);
            end
        end
    end
%     % naive filter
%     for i=1:max_disparity
%         cost_vol(:,:,i) = imfilter(cost_vol(:,:,i), [1 1 1; 1 1 1; 1 1 1]/9);
%     end
    % Gaussian Filter
    for i=1:max_disparity
        f=fspecial('gaussian',3);
        cost_vol(:,:,i) = imfilter(cost_vol(:,:,i), f);
    end
    % winner takes all
    [min_val,d] = max(cost_vol,[],3);
    
end
