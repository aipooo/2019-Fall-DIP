clc, clear
%读入图像‘book_cover.jpg’，并获取该图像的尺寸
img = imread('book_cover.jpg');
[Height, Width] = size(img);

%(-1)^(x+y)乘以图像进行中心变换
for i = 1:Height
    for j = 1:Width
       f(i,j) = double(img(i,j))*(-1)^(i+j);
    end
end

%调用fft2函数对f进行快速傅里叶变换
F = fft2(f);

%构造模糊滤波器
a = 0.1;
b = 0.1;
T = 1;
H = zeros(Height, Width);
j = complex(0,1);
for u = 1:Height
    for v = 1:Width
        x = u-Height/2;
        y = v-Width/2;
        c = pi*(x*a+y*b);
        if(c==0)
            H(u,v) = T;
        else
            H(u,v) = T/c*sin(c)*exp(-j*c);
        end
    end
end

%将进行傅里叶变换后的图像和低通滤波器H相乘，得到进行低通滤波后的频域图像
G = F .* H;

%将上面得到的图像G作傅里叶逆变换后取实部
g = real(ifft2(G));

%用(-1)^(x+y)进行反中心化处理
for i = 1:Height
    for j = 1:Width
       g(i,j) = g(i,j)*((-1)^(i+j));
    end
end

%归一化处理
max_g = max(g(:));
min_g = min(g(:));
range = max_g - min_g;
for i = 1 : Height
    for j = 1 : Width
        g(i,j) = uint8(255*(g(i,j)-min_g)/range);
    end
end
g = uint8(g);
imshow(g);
imwrite(g, 'BlurringFilter.png');
