clc, clear
%����ͼ��book_cover.jpg��������ȡ��ͼ��ĳߴ�
img = imread('book_cover.jpg');
[Height, Width] = size(img);

%(-1)^(x+y)����ͼ��������ı任
for i = 1:Height
    for j = 1:Width
       f(i,j) = double(img(i,j))*(-1)^(i+j);
    end
end

%����fft2������f���п��ٸ���Ҷ�任
F = fft2(f);

%����ģ���˲���
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

%�����и���Ҷ�任���ͼ��͵�ͨ�˲���H��ˣ��õ����е�ͨ�˲����Ƶ��ͼ��
G = F .* H;

%������õ���ͼ��G������Ҷ��任��ȡʵ��
g = real(ifft2(G));

%��(-1)^(x+y)���з����Ļ�����
for i = 1:Height
    for j = 1:Width
       g(i,j) = g(i,j)*((-1)^(i+j));
    end
end

%��һ������
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
