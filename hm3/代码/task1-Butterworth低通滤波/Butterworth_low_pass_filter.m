clc, clear
%����ͼ��barb.png��������ȡ��ͼ��ĳߴ�
img = imread('barb.png');
[Height, Width] = size(img);

%��ͼ��0����(-1)^(x+y)����ͼ��������ı任
f = zeros(2*Height, 2*Width);
for i = 1:Height
    for j = 1:Width
       f(i,j) = double(img(i,j))*(-1)^(i+j);
    end
end

%����fft2������f���п��ٸ���Ҷ�任
F = fft2(f);

%����һ��Butterworth��ͨ�˲���(D0�ֱ�Ϊ10��20��40��80)
D0_10 = 10;
D0_20 = 20;
D0_40 = 40;
D0_80 = 80;
H_10 = zeros(2*Height, 2*Width);
H_20 = zeros(2*Height, 2*Width);
H_40 = zeros(2*Height, 2*Width);
H_80 = zeros(2*Height, 2*Width);
for u = 1:2*Height
    for v = 1:2*Width
        H_10(u,v) = 1/(1+((u-Height-1)^2+(v-Width-1)^2)/D0_10^2);
        H_20(u,v) = 1/(1+((u-Height-1)^2+(v-Width-1)^2)/D0_20^2);
        H_40(u,v) = 1/(1+((u-Height-1)^2+(v-Width-1)^2)/D0_40^2);
        H_80(u,v) = 1/(1+((u-Height-1)^2+(v-Width-1)^2)/D0_80^2);
    end
end

%�����и���Ҷ�任���ͼ��͵�ͨ�˲���H��ˣ��õ����е�ͨ�˲����Ƶ��ͼ��
G_10 = F .* H_10;
G_20 = F .* H_20;
G_40 = F .* H_40;
G_80 = F .* H_80;

%������õ���ͼ��G������Ҷ��任��ȡʵ��
G_10 = real(ifft2(G_10));
G_20 = real(ifft2(G_20));
G_40 = real(ifft2(G_40));
G_80 = real(ifft2(G_80));

%��(-1)^(x+y)����5�Ľ�������з����Ļ�����
g_10 = zeros(Height, Width);
g_20 = zeros(Height, Width);
g_40 = zeros(Height, Width);
g_80 = zeros(Height, Width);
for i = 1:Height
    for j = 1:Width
       g_10(i,j) = G_10(i,j)*((-1)^(i+j));
       g_20(i,j) = G_20(i,j)*((-1)^(i+j));
       g_40(i,j) = G_40(i,j)*((-1)^(i+j));
       g_80(i,j) = G_80(i,j)*((-1)^(i+j));
    end
end

g_10 = uint8(g_10);
g_20 = uint8(g_20);
g_40 = uint8(g_40);
g_80 = uint8(g_80);

imwrite(g_10, 'D0_10.png');
imwrite(g_20, 'D0_20.png');
imwrite(g_40, 'D0_40.png');
imwrite(g_80, 'D0_80.png');
