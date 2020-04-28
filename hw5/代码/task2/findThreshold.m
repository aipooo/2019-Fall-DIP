function newImg = findThreshold(Img)
%FINDTHRESHOLD 基本全局阈值算法
Img = uint8(Img);
[Height, Width] = size(Img);
%初始化阈值为极大值和极小值的平均数
maxImg = max(max(Img));
minImg = min(min(Img)); 
T = 0.5*(maxImg+minImg);  
 
while true  
    G1num = 0;  
    G2num = 0;    
    G1sum = 0;  
    G2sum = 0;  
    %遍历图像，计算两个划分各自的数量以及各自灰度值总和
    for i = 1:Height  
        for j = 1:Width  
            if Img(i,j) >= T   
                G1num = G1num + 1;  
                G1sum = G1sum + Img(i,j);  
            else  
                G2num = G2num + 1;  
                G2sum = G2sum + Img(i,j);  
            end  
        end  
    end  
    %计算两个划分灰度值的平均值  
    average1 = G1sum / G1num;
    average2 = G2sum / G2num;
    %当阈值不再变化时,说明迭代结束  
    if abs(0.5*(average1+average2)-T) < 1e-3
        break;
    %否则更新阈值，继续进行迭代
    else  
        T = 0.5*(average1+average2)  ;
    end  
end  

%生成二值化图像
newImg = zeros(Height, Width);
for i = 1:Height
    for j = 1:Width
        if Img(i,j) >= T
            newImg(i,j) = 1;
        end
    end
end

end

