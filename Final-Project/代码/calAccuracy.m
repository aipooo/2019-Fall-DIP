function [accuracy] = calAccuracy(train_imgs, test_imgs)
%����PCA���з��࣬ͬʱ����Ԥ��׼ȷ��
[coff, ~, ~] = pca(train_imgs);
%����ѵ��ͼ�����������ÿһ�б�ʾ����˶�Ӧ����������
train_eigen_matrix = train_imgs * coff;
count = 0;
for i = 1:200
    %����õ�����ͼ�����������
    test_eigen_vector = test_imgs(i, :) * coff;
    dist = zeros(1, 40);
    %����ò���ͼ������������40���˵�����������ŷ����þ���
    for j = 1:40
        dist(j) = sqrt(sum((test_eigen_vector-train_eigen_matrix(j, :)).^2));
    end
    %������̵Ķ�Ӧ����ż�Ϊ����Ľ��
    [~, index] = min(dist);
    %�жϷ�������ʵ�ʽ���Ƿ�һ��
    if index == floor((i - 1) / 5) + 1
        count = count + 1;
    end
end
%��������׼ȷ��
accuracy = count / 200;
end

