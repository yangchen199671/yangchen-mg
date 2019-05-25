clc
clear all
close all
a=imread('2.jpg');
figure,imshow(a);title('原始图像');%读入图像并显示

R = a(:,:,1);
G = a(:,:,2);
B = a(:,:,3);
figure,subplot(221);
imshow(R);
title('r')
subplot(222);
imshow(G);
title('g')
subplot(223);
imshow(B);
title('b')
subplot(224);
imshow(a);

figure;
subplot(1, 3, 1); imhist(a(:, :, 1)); title('R直方图');
subplot(1, 3, 2); imhist(a(:, :, 2)); title('G直方图');
subplot(1, 3, 3); imhist(a(:, :, 3)); title('B直方图');

YCBCR = rgb2ycbcr(a);
figure,subplot(1,2,1),imshow(YCBCR),title('YCBCR'),
%filter YCBCR image between values and store filtered image to threshold
%matrix（用各个通道的阈值对其进行二值化处理）
Y_MIN = 0;  Y_MAX = 256;
Cb_MIN = 100;   Cb_MAX = 127;
Cr_MIN = 138;   Cr_MAX = 170;
threshold=roicolor(YCBCR(:,:,1),Y_MIN,Y_MAX)&roicolor(YCBCR(:,:,2),Cb_MIN,Cb_MAX)&roicolor(YCBCR(:,:,3),Cr_MIN,Cr_MAX);
subplot(1,2,2),imshow(threshold),title('YCBCR二值化'),



hsv=rgb2hsv(a);
h=hsv(:,:,1);
s=hsv(:,:,2);
v=hsv(:,:,3);
figure,
subplot(2,2,1),imshow(hsv);title('hsv格式图');
subplot(2,2,2),imshow(h);title('h');
subplot(2,2,3),imshow(s);title('s');
subplot(2,2,4),imshow(v);title('v');
%转换为hsv图像并显示


%I=(0.55<h<0.6)&(0.5<s)%检绿色区域
%I2=(0.176<h<0.294)&(0.5<s)%检黄色区域
%figure,imshow(I);title('绿色区域')
%figure,imshow(I2),title('黄色区域')

I1=(0.095<h<0.25)&(0.25<s)%检红色区域
figure,imshow(I1),title('苹果区域')
%perform morphological operations on thresholded image to eliminate noise
%and emphasize the filtered object(s)（进行形态学处理：腐蚀、膨胀、孔洞填充）
erodeElement = strel('square', 3) ;
dilateElement=strel('square', 8) ;
I1 = imerode(I1,erodeElement);
I1 = imerode(I1,erodeElement);
I1=imdilate(I1, dilateElement);
I1=imdilate(I1, dilateElement);
I1=imfill(I1,'holes');
figure,imshow(I1),title('形态学处理')

I2 = a.* uint8(I1);
figure,imshow(I2),title('切割出的苹果图像')