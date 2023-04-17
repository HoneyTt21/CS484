%% HW3-a
% Generate the rgb image from the bayer pattern image using linear and
% bicubic interpolation.
function rgb_img = bayer_to_rgb_bicubic(bayer_img)
    
    img_doub = im2double(bayer_img);
    [m,n] = size(img_doub);
    
    %Bilinear Interpolation from here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rgb_img = zeros(m,n,3);
    
    % 4 specific points
    rgb_img(1,1,1)=img_doub(1,1);
    rgb_img(1,1,2)=(img_doub(1,2)+img_doub(2,1))/2;
    rgb_img(1,1,3)=img_doub(2,2);
    
    rgb_img(m,1,1)=img_doub(m-1,1);
    rgb_img(m,1,2)=img_doub(m,1);
    rgb_img(m,1,3)=img_doub(m,2);
    
    rgb_img(1,n,1)=img_doub(1,n-1);
    rgb_img(1,n,2)=img_doub(1,n);
    rgb_img(1,n,3)=img_doub(2,n);
    
    rgb_img(m,n,1)=img_doub(m-1,n-1);
    rgb_img(m,n,2)=(img_doub(m-1,n)+img_doub(m,n-1))/2;
    rgb_img(m,n,3)=img_doub(m,n);
    
    % 4 edges
    for i=2:m-1
        if mod(i,2)==1
            rgb_img(i,1,1)=img_doub(i,1);
            rgb_img(i,1,2)=(img_doub(i-1,1)+img_doub(i+1,n)+img_doub(i,2))/3;
            rgb_img(i,1,3)=(img_doub(i-1,2)+img_doub(i+1,2))/2;
        
            rgb_img(i,n,1)=img_doub(i,n-1);
            rgb_img(i,n,2)=img_doub(i,n);
            rgb_img(i,n,3)=(img_doub(i-1,n)+img_doub(i+1,n))/2;
        end
        if mod(i,2)==0
            rgb_img(i,1,1)=(img_doub(i-1,1)+img_doub(i+1,1))/2;
            rgb_img(i,1,2)=img_doub(i,1);
            rgb_img(i,1,3)=img_doub(i,2);
        
            rgb_img(i,n,1)=(img_doub(i-1,n-1)+img_doub(i+1,n-1))/2;
            rgb_img(i,n,2)=(img_doub(i,n-1)+img_doub(i-1,n)+img_doub(i+1,n))/3;
            rgb_img(i,n,3)=img_doub(i,n);
        end
    end
    
    for j=2:n-1
        if mod(j,2)==1
            rgb_img(1,j,1)=img_doub(1,j);
            rgb_img(1,j,2)=(img_doub(1,j-1)+img_doub(1,j+1)+img_doub(2,j))/3;
            rgb_img(1,j,3)=(img_doub(2,j-1)+img_doub(2,j+1))/2;

            rgb_img(m,j,1)=img_doub(m-1,j);
            rgb_img(m,j,2)=img_doub(m,j);
            rgb_img(m,j,3)=(img_doub(m,j-1)+img_doub(m,j+1))/2;
        end
        if mod(j,2)==0
            rgb_img(1,j,1)=(img_doub(1,j-1)+img_doub(1,j+1))/2;
            rgb_img(1,j,2)=img_doub(1,j);
            rgb_img(1,j,3)=img_doub(2,j);

            rgb_img(m,j,1)=(img_doub(m-1,j-1)+img_doub(m-1,j+1))/2;
            rgb_img(m,j,2)=(img_doub(m-1,j)+img_doub(m,j-1)+img_doub(m,j+1))/3;
            rgb_img(m,j,3)=img_doub(m,n);
        end
    end
    
    % In the middle part
    for i=2:m-1
        if mod(i,2)==1
            for j=2:n-1
                if mod(j,2)==1
                    rgb_img(i,j,1) = img_doub(i,j);
                    rgb_img(i,j,2) = (img_doub(i-1,j)+img_doub(i+1,j)+img_doub(i,j-1)+img_doub(i,j+1))/4;
                    rgb_img(i,j,3) = (img_doub(i-1,j-1)+img_doub(i-1,j+1)+img_doub(i+1,j-1)+img_doub(i+1,j+1))/4;
                end
                if mod(j,2)==0
                    rgb_img(i,j,1) = (img_doub(i,j-1)+img_doub(i,j+1))/2;
                    rgb_img(i,j,2) = img_doub(i,j);
                    rgb_img(i,j,3) = (img_doub(i-1,j)+img_doub(i+1,j))/2;
                end
            end
        end
        if mod(i,2)==0
            for j=2:n-1
                if mod(j,2)==1
                    rgb_img(i,j,1) = (img_doub(i-1,j)+img_doub(i+1,j))/2;
                    rgb_img(i,j,2) = img_doub(i,j);
                    rgb_img(i,j,3) = (img_doub(i,j-1)+img_doub(i,j+1))/2;
                end
                if mod(j,2)==0
                    rgb_img(i,j,1) = (img_doub(i-1,j-1)+img_doub(i+1,j-1)+img_doub(i-1,j-1)+img_doub(i+1,j+1))/4;
                    rgb_img(i,j,2) = (img_doub(i-1,j)+img_doub(i+1,j)+img_doub(i,j-1)+img_doub(i,j+1))/4;
                    rgb_img(i,j,3) = img_doub(i,j);
                end
            end
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     
%     %Bicubic Interpolation from here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     rgb_img = zeros(m,n,3);
%     padarray(img, [4, 4], 'replicate');
%     
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
