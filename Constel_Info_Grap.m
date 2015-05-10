function constel_info=Constel_Info_Grap(imagefilename,num)
% 20150510-Xiaoge Liu
%constel_info=Constel_Info_Grap(imagefilename,num):this function grap the constellation information from a constellation
%image. imagefilename is the string that contains the path and filename.
%constel_info is a cell of 1*2. The first is the name obtained from the
%filename, the second is a 3*num matrix. num is the number of stars we collect. 1 column is the brightest star. 1
%row is x location, and 2 row is the y location, 3 row is the area. The
%area are normalized to the brightes star. The x,y is scaled and rotate, so
%the location of first brightest star is (0,0). and the second brightest star is
%(1,0). 

% Check number of inputs.
switch nargin
    case 1
        num=10;
    case 2
        ;
    otherwise 
        error('requires at most 2 optional inputs');
end

 [path,name,ext]=fileparts(imagefilename); 
 [img,Imap]=(imread(imagefilename));
 imgRGB=ind2rgb(img,Imap);
%  imshow(imgRGB);
 imgR=imgRGB(:,:,1);
 t1=0.6;t2=0.8;
 imgBW=(imgR>t1).*(imgR<t2);
 imgStar=areaFilter(imgBW, 1000, 25);
 imgLabel = bwlabel(imgStar);
 shapeProps = regionprops(imgLabel, 'Area');
 num=min(length(shapeProps),num);
 star=zeros(length(shapeProps),3);
%  imshow(imgLabel);
%  hold on
for nStar=1:1:length(shapeProps)
    [y,x] =find(imgLabel == nStar);
    centerx=mean(x);
    centery=mean(y);
    star(nStar,1)=shapeProps(nStar).Area;
    star(nStar,2)=centerx;
    star(nStar,3)=centery;
%   scatter(centerx,centery,star(nStar,1),'filled','r');
end
constel=sortrows(star,1);
constel=constel(1:num,:);
constel=flipud(constel);
constel(:,2)=constel(:,2)-constel(1,2);
constel(:,3)=constel(:,3)-constel(1,3);
theta=atan(-constel(2,3)/constel(2,2));
rotM=[cos(theta),-sin(theta);sin(theta),cos(theta)];
constel_XY=rotM*constel(:,2:3).';
constel_XY=constel_XY/constel_XY(1,2);
constel_Area=(constel(:,1)/constel(1,1)).';
constel_Matrix=[constel_XY;constel_Area];
constel_info=cell(1,2);
constel_info{1}=name;
constel_info{2}=constel_Matrix;
end
