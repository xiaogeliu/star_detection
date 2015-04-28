
clc;
clear all;
load('constel');
%%test
trainname={'test1.jpg'};
Train=im2double(imread(trainname{1}));
Train_gray=rgb2gray(Train);
Level=graythresh(Train_gray);
Train_Thre=im2bw(Train_gray,Level);

% EP=strel('disk',2);
% Train_Reduce=imdilate(imerode(Train_Thre,EP),EP);
% 
Train_Reduce=areaFilter(Train_Thre, 1000, 20);
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
    star(nStar,2)=centery;
    star(nStar,3)=centerx;
%     scatter(centerx,centery,star(nStar,1),'filled','r');
end
consteltest=star;%flipud(sortrows(star));
constel(:,2)=constel(:,2)+consteltest(1,2);
constel(:,3)=constel(:,3)+consteltest(1,3);
% consteltest(:,2)=consteltest(:,2)-consteltest(1,2);
% consteltest(:,3)=consteltest(:,3)-consteltest(1,3);
% for FiStar=1:1:size(consteltest)
%     for SeStar=FiStar:1:size(consteltest)
%         consteltest(:,2)=consteltest(:,2)-consteltest(FiStar,2);
%         consteltest(:,3)=consteltest(:,3)-consteltest(FiStar,3);
%        % thelta=atan(constel(SeStar,3)/constel(SeStar,2));
%     end
% end

