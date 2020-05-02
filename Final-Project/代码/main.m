clear;clc;
width = 92;
height = 112;
%记录100次实验的准确率
accuracy_array = zeros(1, 100);
for t = 1:100
    %train_imgs为训练图像，行号代表人，该行为这个人训练图像对应向量的平均值
    %test_imgs为测试图像，按顺序排列，每三行表示一个人，代表这个人训练图像对应向量
    train_imgs = zeros(40, width*height);
    test_imgs = zeros(200, width*height);
    count = 1;
    for person = 1:40
        %每个人从10张图像中随机选择5张图作为训练图像，5张作为测试图像
        chosen_index = randperm(10, 5);
        for i = 1:10
            %读取图像，并将图像reshape成行向量
            img = double(imread(['orl_faces/s' num2str(person) '/' num2str(i) '.pgm']));
            img = reshape(img, 1, width*height);
            if ismember(i, chosen_index)
                train_imgs(person, :) = train_imgs(person, :) + img;
            else
                test_imgs(count, :) =  img;
                count = count + 1;
            end
        end
    end
    %求取每个人对应的5张训练图像平均值
    train_imgs = train_imgs ./ 5;
    %计算准确率
    accuracy = calAccuracy(train_imgs, test_imgs);
    accuracy_array(t) = accuracy;
end
scatter([1:100],accuracy_array),title("PCA准确率"),axis([1 100 0.5 1]);