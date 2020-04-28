clc,clear
%读入图像car.png和模板wheel.png
car = imread('car.png');
wheel = imread('wheel.png');
[H, W] = size(car);
[h, w] = size(wheel);

% car_extend为对car进行边缘补零后的图像
car_extend = zeros(H+h-1, W+w-1);  
half_h = floor(h/2);
half_w = floor(w/2);
car_extend(half_h+1:half_h+H, half_w+1:half_w+W) = car;

%G为相关值矩阵
G = zeros(H+h-1, W+w-1);
% 滑动窗口进行相关滤波，并进行归一化处理
wheel_avg = mean(wheel(:));
for i = half_h+1:half_h+H
    for j = half_w+1:half_w+W
        sum1 = 0;
        sum2 = 0;
        sum3 = 0;
        car_area_avg = mean(mean(car_extend(i-half_h:i+half_h, j-half_w:j+half_w)));
        for u = -half_h:half_h
            for v = -half_w:half_w
                sum1 = sum1 + (car_extend(i+u, j+v)-car_area_avg) * (double(wheel(half_h+1+u,half_w+1+v))-wheel_avg);
                sum2 = sum2 + (car_extend(i+u, j+v)-car_area_avg)^2;
                sum3 = sum3 + (double(wheel(half_h+1+u,half_w+1+v))-wheel_avg)^2;
            end
        end
        G(i,j) = sum1/(sqrt(sum2*sum3));   
    end
end

%将相关值矩阵G边缘的0去除
G = G(half_h+1:half_h+H, half_w+1:half_w+W);
G = mat2gray(G);
%我们在检测完G当前坐标后将其领域表注为不可检测
%我们用flag矩阵用于标记对应的G矩阵坐标是否可以被检测
flag = zeros(size(G));
% 找出目标坐标，使用position记录
position = [];
max_G = [];
while true
    %查找G中符合要求的最大值及其对应坐标
    max_num =0;
    for i = 1:H
        for j = 1:W
            if flag(i, j)==0 && G(i, j)>max_num
                max_num = G(i, j);
                max_i = i;
                max_j = j;
            end
        end
    end
    %如果找到的最大值小于设定的阈值，则退出检测
    if max_num<0.5
        break;
    end
    position = [position; [max_i, max_j]];
    max_G = [max_G; max_num];
    %根据本次循环得到的坐标更新flag矩阵
    for u = max(1, max_i-half_h):min(H, max_i+half_h)
        for v = max(1, max_j-half_w):min(W, max_j+half_w)
            flag(u, v) = 1;
        end
    end
end

disp(position);
disp(max_G);

imshow(G);
imwrite(G, 'CorrelationResult.png');


