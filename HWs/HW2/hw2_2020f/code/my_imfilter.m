function output = my_imfilter(image, filter)
% % This function is intended to behave like the built in function imfilter()
% % when operating in convolution mode. See 'help imfilter'. 
% % While "correlation" and "convolution" are both called filtering, 
% % there is a difference. From 'help filter2':
% %    2-D correlation is related to 2-D convolution by a 180 degree rotation
% %    of the filter matrix.
% 
% % Your function should meet the requirements laid out on the project webpage.
% 
% % Boundary handling can be tricky as the filter can't be centered on pixels
% % at the image boundary without parts of the filter being out of bounds. If
% % we look at 'help imfilter', we see that there are several options to deal 
% % with boundaries. 
% % Please recreate the default behavior of imfilter:
% % to pad the input image with zeros, and return a filtered image which matches 
% % the input image resolution. 
% % A better approach is to mirror or reflect the image content in the padding.
% 
% Uncomment to call imfilter to see the desired behavior.
% output = imfilter(image, filter, 'conv');
% 
% %%%%%%%%%%%%%%%%
% % Your code here
% %%%%%%%%%%%%%%%%
filter = rot90(filter,2);

[imgRows,imgCols, RGB] = size(image);
[filRows,filCols] = size(filter);

if rem(filRows,2) == 0 || rem(filCols,2) == 0 
    errorMsg = 'Error occurred; Output Undefined.';
    output = errorMsg;
    return
end

if(RGB == 3) 
    
    output = zeros([imgRows imgCols 3]);
        
    for k = 1:3
        padImage = padarray(image(:,:,k),[fix(filRows/2) fix(filCols/2)]);
        for i = 1:imgRows
            for j = 1:imgCols
                Temp = padImage(i:i-1+filRows,j:j-1+filCols).*filter;
                output(i,j,k) = sum(Temp(:));
            end
        end
    end
        
else
    padImage = padarray(image,[fix(filRows/2) fix(filCols/2)]);
    output = zeros([imgRows imgCols]);
        
    for i = 1:imgRows
        for j = 1:imgCols
            Temp = padImage(i:i-1+filRows,j:j-1+filCols).*filter;
            output(i,j) = sum(Temp(:));
        end
    end
end


    




