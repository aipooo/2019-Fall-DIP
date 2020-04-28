function newImg = findThreshold(Img)
%FINDTHRESHOLD ����ȫ����ֵ�㷨
Img = uint8(Img);
[Height, Width] = size(Img);
%��ʼ����ֵΪ����ֵ�ͼ�Сֵ��ƽ����
maxImg = max(max(Img));
minImg = min(min(Img)); 
T = 0.5*(maxImg+minImg);  
 
while true  
    G1num = 0;  
    G2num = 0;    
    G1sum = 0;  
    G2sum = 0;  
    %����ͼ�񣬼����������ָ��Ե������Լ����ԻҶ�ֵ�ܺ�
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
    %�����������ֻҶ�ֵ��ƽ��ֵ  
    average1 = G1sum / G1num;
    average2 = G2sum / G2num;
    %����ֵ���ٱ仯ʱ,˵����������  
    if abs(0.5*(average1+average2)-T) < 1e-3
        break;
    %���������ֵ���������е���
    else  
        T = 0.5*(average1+average2)  ;
    end  
end  

%���ɶ�ֵ��ͼ��
newImg = zeros(Height, Width);
for i = 1:Height
    for j = 1:Width
        if Img(i,j) >= T
            newImg(i,j) = 1;
        end
    end
end

end

