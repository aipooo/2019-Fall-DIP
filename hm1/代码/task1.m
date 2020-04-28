%����ͼ��river.jpg
img = imread('C:\Users\Administrator\Desktop\����ͼ����\DIP_HW1\river.jpg');
%��ȡͼ����Ϣimg_info
img_info = imfinfo('C:\Users\Administrator\Desktop\����ͼ����\DIP_HW1\river.jpg');

%����Ҷ�ֱֵ��ͼ
hist = zeros(1, 256);
for i = 1:img_info.Height
   for j = 1:img_info.Width
       hist(img(i, j)+1) = hist(img(i, j)+1) + 1;
   end
end
saveas(bar(hist), 'histogram.png');

%������õ��ĻҶ�ֱֵ��ͼ��һ������������Ҷ�ֵ�����ܶ�pdf
pdf = zeros(1, 256);
for i = 1:256
    pdf(i) = hist(i)/(img_info.Width*img_info.Height);
end

%����Ҷ�ֵ�����ܶ��ۼƷֲ�cdf
cdf = zeros(1, 256);
cdf(1) = pdf(1);
for i = 2:256
    cdf(i) = cdf(i-1)+pdf(i);
end

%��cdf��ȡֵ��Χ��չ��0-255��ͬʱȡ��
cdf = round(cdf.*255);

%�ԻҶ�ֵ����ӳ�䣬�����⻯����
my_processed_img = zeros(size(img));
for i = 1:img_info.Height
    for j = 1:img_info.Width
        my_processed_img(i,j) = cdf(img(i,j)+1);
    end
end
imwrite(uint8(my_processed_img), 'my_processed_river.jpg', 'jpg');

%����ֱ��ͼ���⻯��ĻҶ�ֱֵ��ͼ
my_processed_hist = zeros(1, 256);
for i = 1:img_info.Height
   for j = 1:img_info.Width
       my_processed_hist(my_processed_img(i, j)+1) = my_processed_hist(my_processed_img(i, j)+1) + 1;
   end
end
saveas(bar(my_processed_hist), 'my_histogram.png');

%����histeq�⺯������ֱ��ͼ���⻯
histeq_img = histeq(img);
imwrite(histeq_img, 'histeq_river.jpg', 'jpg');
histeq_hist = imhist(histeq_img);
saveas(bar(histeq_hist), 'histeq_histogram.png');