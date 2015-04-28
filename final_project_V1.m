%%create the database.

clc;
clear all; 
trainname={'t1.jpg'};
Train=im2double(imread(trainname{1}));
Train_gray=rgb2gray(Train);
Level=graythresh(Train_gray);
Train_Thre=im2bw(Train_gray,Level);

% EP=strel('disk',2);
% Train_Reduce=imdilate(imerode(Train_Thre,EP),EP);
% 
Train_Reduce=areaFilter(Train_Thre, 1000, 13);
imLabel = bwlabel(Train_Reduce);
shapeProps = regionprops(imLabel, 'Area');
star=zeros(length(shapeProps),5);
 imshow(imLabel);
 hold on
for nStar=1:1:length(shapeProps)
    [y,x] =find(imLabel == nStar);
    centerx=mean(x);
    centery=mean(y);
    star(nStar,1) = shapeProps(nStar).Area;
    star(nStar,2)=centerx;
    star(nStar,3)=centery;
     scatter(centerx,centery,star(nStar,1),'filled','r');
end
%star=sort(star,1,'descend');
% scatter(star(:,3),star(:,2),15,'filled','r');
% plot(star(:,3),star(:,2));
constel=star;%flipud(sortrows(star));
% scatter(constel(:,3),constel(:,2),15,'filled','r');
% plot(constel(:,3),constel(:,2));
constel(:,2)=constel(:,2)-constel(1,2);
constel(:,3)=constel(:,3)-constel(1,3);
constel(1,4)=sqrt(constel(2,2).^2+constel(2,3).^2);
constel(1,5)=constel(2,3)/constel(2,2);
save('constel','constel');
%%