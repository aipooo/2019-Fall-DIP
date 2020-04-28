clc, clear
%读入图像‘office.png’，转为灰度图像
img = rgb2gray(imread('office.jpg'));

for D0 = 100:100:1000
    g_homo = Homo_filter(img, D0);
    imwrite(g_homo, ['Homo_D0_', int2str(D0), '.jpg']);
end

g_bhpf_10 = Butterworth_high_pass_filter(img, 0.0001);
imwrite(g_bhpf_10, ['BHPF_D0_0p0001.jpg']);
g_bhpf_0p001 = Butterworth_high_pass_filter(img, 0.001);
imwrite(g_bhpf_0p001, ['BHPF_D0_0p001.jpg']);
g_bhpf_0p01 = Butterworth_high_pass_filter(img, 0.01);
imwrite(g_bhpf_0p01, ['BHPF_D0_0p01.jpg']);
g_bhpf_0p1 = Butterworth_high_pass_filter(img, 0.1);
imwrite(g_bhpf_0p1, ['BHPF_D0_0p1.jpg']);
g_bhpf_1 = Butterworth_high_pass_filter(img, 1);
imwrite(g_bhpf_1, ['BHPF_D0_1.jpg']);
g_bhpf_10 = Butterworth_high_pass_filter(img, 10);
imwrite(g_bhpf_10, ['BHPF_D0_10.jpg']);