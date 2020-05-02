function [accuracy] = calAccuracy(train_imgs, test_imgs)
%利用PCA进行分类，同时计算预测准确率
[coff, ~, ~] = pca(train_imgs);
%计算训练图像的特征矩阵，每一行表示这个人对应的特征向量
train_eigen_matrix = train_imgs * coff;
count = 0;
for i = 1:200
    %计算得到测试图像的特征向量
    test_eigen_vector = test_imgs(i, :) * coff;
    dist = zeros(1, 40);
    %计算该测试图像特征向量到40个人的特征向量的欧几里得距离
    for j = 1:40
        dist(j) = sqrt(sum((test_eigen_vector-train_eigen_matrix(j, :)).^2));
    end
    %距离最短的对应的序号即为分类的结果
    [~, index] = min(dist);
    %判断分类结果和实际结果是否一致
    if index == floor((i - 1) / 5) + 1
        count = count + 1;
    end
end
%计算分类的准确率
accuracy = count / 200;
end

