%读入图像river.jpg
img = imread('C:\Users\Administrator\Desktop\数字图像处理\DIP_HW1\river.jpg');
%获取图像信息img_info
img_info = imfinfo('C:\Users\Administrator\Desktop\数字图像处理\DIP_HW1\river.jpg');

%计算灰度值直方图
hist = zeros(1, 256);
for i = 1:img_info.Height
   for j = 1:img_info.Width
       hist(img(i, j)+1) = hist(img(i, j)+1) + 1;
   end
end
saveas(bar(hist), 'histogram.png');

%将上面得到的灰度值直方图归一化处理，即计算灰度值概率密度pdf
pdf = zeros(1, 256);
for i = 1:256
    pdf(i) = hist(i)/(img_info.Width*img_info.Height);
end

%计算灰度值概率密度累计分布cdf
cdf = zeros(1, 256);
cdf(1) = pdf(1);
for i = 2:256
    cdf(i) = cdf(i-1)+pdf(i);
end

%将cdf的取值范围扩展至0-255，同时取整
cdf = round(cdf.*255);

%对灰度值进行映射，作均衡化处理
my_processed_img = zeros(size(img));
for i = 1:img_info.Height
    for j = 1:img_info.Width
        my_processed_img(i,j) = cdf(img(i,j)+1);
    end
end
imwrite(uint8(my_processed_img), 'my_processed_river.jpg', 'jpg');

%计算直方图均衡化后的灰度值直方图
my_processed_hist = zeros(1, 256);
for i = 1:img_info.Height
   for j = 1:img_info.Width
       my_processed_hist(my_processed_img(i, j)+1) = my_processed_hist(my_processed_img(i, j)+1) + 1;
   end
end
saveas(bar(my_processed_hist), 'my_histogram.png');

%调用histeq库函数进行直方图均衡化
histeq_img = histeq(img);
imwrite(histeq_img, 'histeq_river.jpg', 'jpg');
histeq_hist = imhist(histeq_img);
saveas(bar(histeq_hist), 'histeq_histogram.png');