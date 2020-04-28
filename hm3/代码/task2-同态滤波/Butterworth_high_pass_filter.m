function[g] = Butterworth_high_pass_filter(img, D0)

[Height, Width] = size(img);

%对图像补0后取对数，用(-1)^(x+y)乘以图像进行中心变换
f = zeros(2*Height, 2*Width);
for i = 1:Height
    for j = 1:Width
       f(i,j) = double(img(i,j))*(-1)^(i+j);
    end
end

%调用fft2函数对f进行快速傅里叶变换
F = fft2(f);

%构造BHPF滤波器
H = zeros(2*Height, 2*Width);
for u = 1:2*Height
    for v = 1:2*Width
        H(u,v) = 1/(1+D0^2/((u-Height-1)^2+(v-Width-1)^2));
    end
end

%将进行傅里叶变换后的图像和低通滤波器H相乘，得到进行低通滤波后的频域图像
G = F .* H;

%将上面得到的图像G作傅里叶逆变换后取实部
G = real(ifft2(G));

%用(-1)^(x+y)乘上5的结果。进行反中心化处理
g = zeros(Height, Width);
for i = 1:Height
    for j = 1:Width
       g(i,j) = G(i,j)*(-1)^(i+j);
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

