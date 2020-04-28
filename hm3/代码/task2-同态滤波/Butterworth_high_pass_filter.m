function[g] = Butterworth_high_pass_filter(img, D0)

[Height, Width] = size(img);

%��ͼ��0��ȡ��������(-1)^(x+y)����ͼ��������ı任
f = zeros(2*Height, 2*Width);
for i = 1:Height
    for j = 1:Width
       f(i,j) = double(img(i,j))*(-1)^(i+j);
    end
end

%����fft2������f���п��ٸ���Ҷ�任
F = fft2(f);

%����BHPF�˲���
H = zeros(2*Height, 2*Width);
for u = 1:2*Height
    for v = 1:2*Width
        H(u,v) = 1/(1+D0^2/((u-Height-1)^2+(v-Width-1)^2));
    end
end

%�����и���Ҷ�任���ͼ��͵�ͨ�˲���H��ˣ��õ����е�ͨ�˲����Ƶ��ͼ��
G = F .* H;

%������õ���ͼ��G������Ҷ��任��ȡʵ��
G = real(ifft2(G));

%��(-1)^(x+y)����5�Ľ�������з����Ļ�����
g = zeros(Height, Width);
for i = 1:Height
    for j = 1:Width
       g(i,j) = G(i,j)*(-1)^(i+j);
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

