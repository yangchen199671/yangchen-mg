% By lyqmath
% DLUT School of Mathematical Sciences
% BLOG��http://blog.csdn.net/lyqmath
clc; clear all; close all;
I = imread('9.jpg'); % ����ͼ��
figure; 
imshow(I); title('ԭͼ��', 'FontWeight', 'Bold');
I1 = rgb2hsv(I); % RGBת����HSV�ռ�
h=I1(:,:,1); % S��
s=I1(:,:,2);
v=I1(:,:,3);

I2=(0.095<h<0.25)&(0.25<s);
figure,imshow(I2);
bw1 = imfill(I2, 'holes'); % ����
bw1 = imopen(bw1, strel('disk', 5));
bw1 = bwareaopen(bw1, 2000);
bw2 = cat(3, bw1, bw1, bw1);

I3 = I.* uint8(bw2);
figure,imshow(I3),title('�и����ƻ��ͼ��')
%bw = imbinarize(a, graythresh(a)); % ��ֵ��
%bw = ~bw; % ȡ��
%bw1 = imfill(bw, 'holes'); % ����
%bw1 = imopen(bw1, strel('disk', 5)); % ͼ�񿪲���
%bw1 = bwareaopen(bw1, 2000); % ����˲�
%subplot(1, 3, 2); imshow(bw1); title('��ֵͼ��', 'FontWeight', 'Bold');
%bw2 = cat(3, bw1, bw1, bw1); % ����ģ��
%I2 = I .* uint8(bw2); % ���
%subplot(1, 3, 3); imshow(I2); title('�ָ�ͼ��', 'FontWeight', 'Bold');
