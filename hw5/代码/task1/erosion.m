function newMatrix = erosion(Matrix, mask, x0, y0)
%EROSION 腐蚀
%Matrix为原始矩阵，mask为模板，x0，y0为模板原点
[Height, Width] = size(Matrix);
[h, w] = size(mask);
%将原图像做零扩充处理
padMatrix = zeros(Height+2*(h-1),Width+2*(w-1));
padMatrix(h:h+Height-1, w:w+Width-1) = Matrix;
newMatrix = zeros(Height,Width);

%统计模板中1的个数
se_num = sum(sum(mask == 1));
%遍历原矩阵
for i = h:h+Height-1
	for j = w:w+Width-1
        %count用于标记当前矩阵和模板重合的部分1的个数，初始化为0
        count = 0;
        for u = 1:h
            for v = 1:w
                %如果模板该位置为1，则判断原矩阵该位置是否为1
                if mask(u,v) == 1   
                    %如果也为1，则count增加1
                    if padMatrix(i-x0+u,j-y0+v) == 1 
                    	count = count+1;
                    end
                end
            end
        end
        %如果count与se_num相等，则不满足腐蚀条件，置为1
        %否则满足腐蚀条件，保持原来的0
        if count == se_num
            newMatrix(i-h+1,j-w+1) = 1;
        end
	end
end

end

