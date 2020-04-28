function newMatrix = dilation(Matrix, mask, x0, y0)
%DILATION ����
%MatrixΪԭʼ����maskΪģ�壬x0��y0Ϊģ��ԭ��
[Height, Width] = size(Matrix);
[h, w] = size(mask);
%��ԭͼ���������䴦��
padMatrix = zeros(Height+2*(h-1),Width+2*(w-1));
padMatrix(h:h+Height-1, w:w+Width-1) = Matrix;
newMatrix = zeros(Height,Width); 

%����ԭ����
for i = h:h+Height-1
	for j = w:w+Width-1
        %flag���ڱ���Ƿ�������������
        flag = false;
        for u = 1:h
            for v = 1:w
                %���ģ���λ��Ϊ1�����ж�ԭ�����λ���Ƿ�Ϊ1
                if mask(u,v) == 1 
                    %���ҲΪ1���������������������б��
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

