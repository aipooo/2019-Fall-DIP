function newMatrix = dilation(Matrix, mask, x0, y0)
%DILATION 膨胀
%Matrix为原始矩阵，mask为模板，x0，y0为模板原点
[Height, Width] = size(Matrix);
[h, w] = size(mask);
%将原图像做零扩充处理
padMatrix = zeros(Height+2*(h-1),Width+2*(w-1));
padMatrix(h:h+Height-1, w:w+Width-1) = Matrix;
newMatrix = zeros(Height,Width); 

%遍历原矩阵
for i = h:h+Height-1
	for j = w:w+Width-1
        %flag用于标记是否满足膨胀条件
        flag = false;
        for u = 1:h
            for v = 1:w
                %如果模板该位置为1，则判断原矩阵该位置是否为1
                if mask(u,v) == 1 
                    %如果也为1，则满足膨胀条件，进行标记
                    if padMatrix(i-x0+u,j-y0+v) == 1
                    	newMatrix(i-h+1,j-w+1) = 1;
                        flag = true;
                        break;
                    end
                end
            end
            if flag == true
                break;
            end
        end
	end
end

end

