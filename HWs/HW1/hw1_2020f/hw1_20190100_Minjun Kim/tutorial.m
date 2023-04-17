% image = imread("gigi.jpg");
% 
% floatImage = im2single(image);
% imshow(floatImage);

% ------- %

% image = zeros (300, 400, 3);
% image(:,1:100,1) = 0.5; % half red
% image(:,101:200,1)= 1; % full red
% 
% image(1:100, :, 2) = rand (100, 400); % green
% 
% imshow(image);

% ------- %

% % Read in original RGB 
% 
rgbImage = im2single(imread ("gigi.jpg"));
[m,n,o] = size(rgbImage);
disp([m,n,o]);

% 
% % Extract color channels
% 
% redChannel = rgbImage(:,:,1);
% greenChannel = rgbImage(:,:,2);
% blueChannel = rgbImage(:,:,3);
% 
% % Create an all black channel
% 
% allBlack = zeros(m, n, "uint8");
% 
% % Create color versions of the individual color channels
% justRed = cat(3, redChannel, allBlack, allBlack);
% justGreen = cat(3, allBlack, greenChannel, allBlack);
% justBlue = cat(3, allBlack, allBlack, blueChannel);
% 
% % Recombine the individual color channels to create original RGB image
% % again
% combinedRGBImage = cat(3, redChannel, greenChannel, blueChannel);
% 
% % Grayscale
% I = rgb2gray(rgbImage);
% 
% imshow(I);

% ------------ %

% % slow but convenient
% 
% for i=1:10
%     A(i) = 5;
% end
% 
% % performance significantly improves by pre-allocation
% B = zeros(1, 10); 
% for i=1:10
%     B(i) = 5;
% end 
% 
% % Vectors as function parameters
% C = zeros(1, 10);
% for i=1:10
%     C(i) = sin(B(i));
% end
% 
% % Upper code is equivalent as below
% 
% B = sin(A);
% 
% % Logical Indexing
% 
% m = 400;
% n = 400;
% A = randi(255, m, n, "uint8");
% for i=1:m
%     for j=1:n
%         if A(i,j) > 100
%             A(i,j) = 255;
%         end
%     end
% end
% imshow (A);
% 
% % double-for loops could be more efficiently wrote as below
% B = A > 100;
% A(B) = 255;
% 
% % Evaluating Performance
% % Elapsed time btw tic and toc is printed to the command window
% tic;
% toc;





