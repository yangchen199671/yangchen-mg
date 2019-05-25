clear;close all
RGB = imread('9.jpg');

figure('name','process'),
subplot(2,2,1),imshow(RGB),title('原始RGB'),

%convert frame from RGB to YCBCR colorspace（转换到YCBCR空间）
YCBCR = rgb2ycbcr(RGB);
whos,
subplot(2,2,2),imshow(YCBCR),title('YCBCR'),
%filter YCBCR image between values and store filtered image to threshold
%matrix（用各个通道的阈值对其进行二值化处理）
Y_MIN = 0;  Y_MAX = 256;
Cb_MIN = 100;   Cb_MAX = 127;
Cr_MIN = 138;   Cr_MAX = 170;
threshold=roicolor(YCBCR(:,:,1),Y_MIN,Y_MAX)&roicolor(YCBCR(:,:,2),Cb_MIN,Cb_MAX)&roicolor(YCBCR(:,:,3),Cr_MIN,Cr_MAX);
subplot(2,2,3),imshow(threshold),title('YCBCR二值化'),

%perform morphological operations on thresholded image to eliminate noise
%and emphasize the filtered object(s)（进行形态学处理：腐蚀、膨胀、孔洞填充）
erodeElement = strel('square', 3) ;
dilateElement=strel('square', 8) ;
threshold = imerode(threshold,erodeElement);
threshold = imerode(threshold,erodeElement);
threshold=imdilate(threshold, dilateElement);
threshold=imdilate(threshold, dilateElement);
threshold=imfill(threshold,'holes');
subplot(2,2,4),imshow(threshold),title('形态学处理'),


I3 = RGB.* uint8(threshold);
figure,imshow(I3)

%获取区域的'basic'属性， 'Area', 'Centroid', and 'BoundingBox' 
%figure('name','处理结果'),
%stats = regionprops(threshold, 'basic');
%[C,area_index]=max([stats.Area]);
%定位苹果区域
%apple_locate=[stats(area_index).Centroid(1),stats(area_index).Centroid(2)];
%imshow(RGB);title('after'),hold on
%text(apple_locate(1),apple_locate(2)-40,  'apple','color','red');
%plot(apple_locate(1),apple_locate(2), 'b*');
%rectangle('Position',[stats(area_index).BoundingBox],'LineWidth',2,'LineStyle','--','EdgeColor','r'),
%hold off 
%yc=imcrop(RGB,[stats(area_index).BoundingBox]);
%imshow(yc);
 
