clear;clc;
width = 92;
height = 112;
%��¼100��ʵ���׼ȷ��
accuracy_array = zeros(1, 100);
for t = 1:100
    %train_imgsΪѵ��ͼ���кŴ����ˣ�����Ϊ�����ѵ��ͼ���Ӧ������ƽ��ֵ
    %test_imgsΪ����ͼ�񣬰�˳�����У�ÿ���б�ʾһ���ˣ����������ѵ��ͼ���Ӧ����
    train_imgs = zeros(40, width*height);
    test_imgs = zeros(200, width*height);
    count = 1;
    for person = 1:40
        %ÿ���˴�10��ͼ�������ѡ��5��ͼ��Ϊѵ��ͼ��5����Ϊ����ͼ��
        chosen_index = randperm(10, 5);
        for i = 1:10
            %��ȡͼ�񣬲���ͼ��reshape��������
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
    %��ȡÿ���˶�Ӧ��5��ѵ��ͼ��ƽ��ֵ
    train_imgs = train_imgs ./ 5;
    %����׼ȷ��
    accuracy = calAccuracy(train_imgs, test_imgs);
    accuracy_array(t) = accuracy;
end
scatter([1:100],accuracy_array),title("PCA׼ȷ��"),axis([1 100 0.5 1]);