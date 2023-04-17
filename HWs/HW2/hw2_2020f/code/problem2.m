function problem2()
image = im2single(imread('../data/cat.bmp'));
low_filter =  [0,0,0,0,0; 0,0,0,0,0; 0,0,1,0,0; 0,0,0,0,0; 0,0,0,0,0];
high_filter = 1/24*[1,1,1,1,1; 1,1,1,1,1; 1,1,0,1,1; 1,1,1,1,1; 1,1,1,1,1]

imgLow = imfilter(image, low_filter);
imgHigh = imfilter(image, high_filter);

figure(1) ; imshow(imgLow);
figure(2) ; imshow(imgHigh);

end

