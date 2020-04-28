clc, clear;
img1 = imread('blobz1.png');
img2 = imread('blobz2.png');
resimg1 = findThreshold(img1);
resimg2 = findThreshold(img2);
imwrite(resimg1, 'blobz1Result.png');
imwrite(resimg2, 'blobz2Result.png');

[Height, Width] = size(img2);
x = int32((0:4) * (Height/4) + 1);
y = int32((0:4) * (Width/4) + 1);
resimg4x4 = zeros(Height, Width);
for i = 1:4
  for j = 1:4
    range_x = x(i):x(i+1)-1;
    range_y = y(j):y(j+1)-1;
    resimg4x4(range_x, range_y) = findThreshold(img2(range_x, range_y));
  end
end
imwrite(resimg4x4, 'blobz2Result4x4.png');