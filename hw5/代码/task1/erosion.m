function newMatrix = erosion(Matrix, mask, x0, y0)
%EROSION ��ʴ
%MatrixΪԭʼ����maskΪģ�壬x0��y0Ϊģ��ԭ��
[Height, Width] = size(Matrix);
[h, w] = size(mask);
%��ԭͼ���������䴦��
padMatrix = zeros(Height+2*(h-1),Width+2*(w-1));
padMatrix(h:h+Height-1, w:w+Width-1) = Matrix;
newMatrix = zeros(Height,Width);

%ͳ��ģ����1�ĸ���
se_num = sum(sum(mask == 1));
%����ԭ����
for i = h:h+Height-1
	for j = w:w+Width-1
        %count���ڱ�ǵ�ǰ�����ģ���غϵĲ���1�ĸ�������ʼ��Ϊ0
        count = 0;
        for u = 1:h
            for v = 1:w
                %���ģ���λ��Ϊ1�����ж�ԭ�����λ���Ƿ�Ϊ1
                if mask(u,v) == 1   
                    %���ҲΪ1����count����1
                    if padMatrix(i-x0+u,j-y0+v) == 1 
                    	count = count+1;
                    end
                end
            end
        end
        %���count��se_num��ȣ������㸯ʴ��������Ϊ1
        %�������㸯ʴ����������ԭ����0
        if count == se_num
            newMatrix(i-h+1,j-w+1) = 1;
        end
	end
end

end

