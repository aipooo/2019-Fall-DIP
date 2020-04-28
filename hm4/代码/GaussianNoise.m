clc, clear
%����ģ���˲��������ͼ��BlurringFilterResult.png��
img = imread('BlurringFilterResult.png');
[Height, Width] = size(img);

mean = 0;
var = 500;
noise = norminv(rand(Height, Width), mean, sqrt(var));
result = noise + double(img);
result = uint8(result);

imshow(result);
imwrite(result, 'GaussianNoiseResult.png');
