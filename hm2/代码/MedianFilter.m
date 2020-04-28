clc, clear 
%����ͼ��sport car.png��������ȡ��ͼ��ĳߴ�
original_img = imread('sport car.pgm');
[H, W] = size(original_img);
%���������������
rand_matrix1 = 255 * rand([H, W]);
rand_matrix2 = 255 * rand([H, W]);

%������������ͼ��
noisy_img = zeros(size(original_img));
for i = 1:H
    for j = 1:W
        if original_img(i,j) > rand_matrix1(i,j)
            noisy_img(i,j) = 255;
        elseif original_img(i,j) < rand_matrix2(i,j)
            noisy_img(i,j) = 0;
        else
            noisy_img(i,j) = original_img(i,j);
        end
    end
end

%����3*3����ʵ����ֵ�˲�
my_medfilt_img = noisy_img;
for i = 2:H-1
    for j = 2:W-1
        %windowΪһ��3*3�Ĵ���
        window = noisy_img(i-1:i+1, j-1:j+1);
        sequence = reshape(window, 9, 1);
        my_medfilt_img(i,j) = median(sequence);
    end
end

%����MATLAB�⺯��medfilt2ʵ����ֵ�˲�
medfilt2_img=medfilt2(noisy_img);

subplot(2,2,1);
imshow(original_img);
title('original img');
subplot(2,2,2);
imshow(noisy_img);
title('noisy img');
subplot(2,2,3);
imshow(my_medfilt_img);
title('my medfilt img');
subplot(2,2,4);
imshow(medfilt2_img);
title('medfilt2 img');

saveas(gcf, 'MedianFilterResult.png');