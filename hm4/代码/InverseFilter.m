clc, clear
%读入图像，并获取该图像的尺寸
g1 = imread('BlurringFilterResult.png');
g2 = imread('GaussianNoiseResult.png');
[Height, Width] = size(g1);

%(-1)^(x+y)乘以图像进行中心变换
for i = 1:Height
    for j = 1:Width
       g1(i,j) = double(g1(i,j))*(-1)^(i+j);
       g2(i,j) = double(g2(i,j))*(-1)^(i+j);
    end
end

%调用fft2函数对g进行快速傅里叶变换
G1 = fft2(g1);
G2 = fft2(g2);

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
        if c==0
            H(u,v) = T;
        else
            H(u,v) = T/c*sin(c)*exp(-j*c);
        end
    end
end
H(abs(H)<0.1)=1;
invH = H.^(-1);

%得到原始图像的傅里叶变换估计
F1 = G1 .* invH;
F2 = G2 .* invH;

%将上面得到的图像F作傅里叶逆变换后取实部
f1 = real(ifft2(F1));
f2 = real(ifft2(F2));

%用(-1)^(x+y)进行反中心化处理
for i = 1:Height
    for j = 1:Width
       f1(i,j) = f1(i,j)*((-1)^(i+j));
       f2(i,j) = f2(i,j)*((-1)^(i+j));
    end
end

%归一化处理
max_f1 = max(f1(:));
max_f2 = max(f2(:));
min_f1 = min(f1(:));
min_f2 = min(f2(:));
range1 = max_f1 - min_f1;
range2 = max_f2 - min_f2;
for i = 1 : Height
    for j = 1 : Width
        f1(i,j) = uint8(255*(f1(i,j)-min_f1)/range1);
        f2(i,j) = uint8(255*(f2(i,j)-min_f1)/range2);
    end
end

f1 = uint8(f1);
f2 = uint8(f2);
imwrite(f1, 'InverseBlurringFilterResult.png');
imwrite(f2, 'InverseGaussianNoiseResult.png');
