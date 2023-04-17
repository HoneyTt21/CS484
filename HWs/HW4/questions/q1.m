function [cor] = q1()
    c1 = imread('./Chase1.jpg');
    c2 = imread('./Chase2.jpg');
    lo1 = imread('./LaddObservatory1.jpg');
    lo2 = imread('./LaddObservatory2.jpg');
    rl1 = imread('./RISHLibrary1.jpg');
    rl2 = imread('./RISHLibrary2.jpg');
    
    image = rl2;
    image_double = im2double(image);
    h = imshow(image, 'Border', 'tight');
    hold on;
    cor = corner(image_double(:,:,1), 1000);
    
    for i=1:size(cor)
        plot(cor(i,1),cor(i,2), 'o', 'LineWidth',2, 'MarkerEdgeColor',rand(3,1),...
                           'MarkerFaceColor', [1 0 0], 'MarkerSize',10);
    end
    hold off;
    saveas( h, "RL2.png" );
end