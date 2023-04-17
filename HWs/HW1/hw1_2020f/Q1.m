I = double( imread('gigi.jpg') );
I = I - 20;
imshow( I );

[m1, n1] = size(I);
for i=1:m1
    for j=1:n1
        if I(i,j) > 0
            if I(i, j) < 1
                disp(I(i,j));
            end
        end
    end
end 