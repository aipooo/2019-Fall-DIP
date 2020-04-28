%读入图像EightAM.png和LENA.png
imgR = imread('C:\Users\Administrator\Desktop\数字图像处理\DIP_HW1\EightAM.png');
imgZ = imread('C:\Users\Administrator\Desktop\数字图像处理\DIP_HW1\LENA.png');
%获取图像信息imgR_info和imgZ_info
imgR_info = imfinfo('C:\Users\Administrator\Desktop\数字图像处理\DIP_HW1\EightAM.png');
imgZ_info = imfinfo('C:\Users\Administrator\Desktop\数字图像处理\DIP_HW1\LENA.png');

%计算imgR灰度值直方图
histR = zeros(1, 256);
for i = 1:imgR_info.Height
   for j = 1:imgR_info.Width
       histR(imgR(i, j)+1) = histR(imgR(i, j)+1) + 1;
   end
end
saveas(bar(histR), 'EightAM_hist.png');

%计算imgZ灰度值直方图
histZ = zeros(1, 256);
for i = 1:imgZ_info.Height
   for j = 1:imgZ_info.Width
       histZ(imgZ(i, j)+1) = histZ(imgZ(i, j)+1) + 1;
   end
end
saveas(bar(histZ), 'LENA_hist.png');

%归一化处理得到概率密度分布函数
histR = histR./(imgR_info.Width*imgR_info.Height);
histZ = histZ./(imgZ_info.Width*imgZ_info.Height);

%计算灰度值概率密度累计分布cdf
cdfR = zeros(1, 256);
cdfZ = zeros(1, 256);
cdfR(1) = histR(1);
cdfZ(1) = histZ(1);
for i = 2:256
    cdfR(i) = cdfR(i-1)+histR(i);
    cdfZ(i) = cdfZ(i-1)+histZ(i);
end

%将cdf的取值范围扩展至0-255，同时取整
cdfR = round(cdfR.*255);
cdfZ = round(cdfZ.*255);

%构建映射表
map = zeros(1,256);
for i = 1:256
    min_diff = cdfR(i)-cdfZ(1);
    min_j = 1;
    for j = 2:256
        diff = abs(cdfR(i)-cdfZ(j));
        if diff<min_diff
            min_diff = diff;
            min_j = j;
        end
    end
    map(i) = min_j;
end

%对imgR的每一个像素进行映射，得到新的img
img = imgR;
for i = 1:imgR_info.Height
    for j = 1:imgR_info.Width
        img(i, j) = map(imgR(i, j) + 1) - 1;
    end
end

imwrite(uint8(img), 'my_processed_EightAM.png', 'png');
my_processed_hist = imhist(img);
saveas(bar(my_processed_hist), 'my_processed_EightAM_hist.png');

%调用histeq函数实现直方图匹配
histeq_img = histeq(imgR, histZ);
imwrite(histeq_img, 'histeq_EightAM.png', 'png');
histeq_hist = imhist(histeq_img);
saveas(bar(histeq_hist), 'histeq_EightAM_hist.png');