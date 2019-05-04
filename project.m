str = input('Enter image filename: ', 's');
img = imread(str);
img = imresize(img, 0.5);
img = imsharpen(img);
figure;
imshow(img);
title('Original image');
red = img(:, :, 1);
green = img(:, :, 2);
blue = img(:, :, 3);
br = edge(red,'canny');
bg = edge(green, 'canny');
bb = edge(blue, 'canny');
figure;
subplot(3, 3, 1);
imshow(red);
title('Red component');
subplot(3, 3, 2);
imshow(green);
title('Green component');
subplot(3, 3, 3);
imshow(blue);
title('Blue component');
subplot(3, 3, 4);
imshow(br);
title('Edges of red component');
subplot(3, 3, 5);
imshow(bg);
title('Edges of green component');
subplot(3, 3, 6);
imshow(bb);
title('Edges of blue component');
res = cat(3, br, bg, bb);
l = length(res(:, 1, 1));
b = length(res(1, :, 1));
for i = 1:l
    for j = 1:b
        if (or(res(i, j, 1), or(res(i, j, 2), res(i, j, 3))) == 1)
            res(i, j, 1) = 1;
            res(i, j, 2) = 1;
            res(i, j, 3) = 1;
        end
    end
end
    
figure;
imshow(im2uint8(res));
title('Thresholded image');
fin = img;
for i = 1:l
    for j = 1:b
        if (or(res(i, j, 1), or(res(i, j, 2), res(i, j, 3))) == 1)
            fin(i, j, 1) = 0;
            fin(i, j, 3) = 0;
            fin(i, j, 2) = 255;
        end
    end
end
figure;
imshow(fin);
title('Final wireframed image');