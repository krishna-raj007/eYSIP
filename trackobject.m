function [hueimage area bb]=trackobject(image)
[img0 img]=maskingexterior(image);
[h s v]=rgb2hsv(img);
hueimage=(h>0.9)|(h<0.1);
simage=s>0.2;
hueimage=hueimage & simage;
% imshow(hueimage);
data=bwareaopen(hueimage, 10);
%imshow(data);
stats1 = regionprops(data, 'BoundingBox', 'Centroid','Area');
% if mod(frame,10) == 0
figure,imshow(image);

hold on
max_area=0;
max_obj=1;

for object = 1:length(stats1)
     area=stats1(object).Area;
     if area > max_area
         max_area=area;
         max_obj=object;
     end
end
 bb = stats1(max_obj).BoundingBox;
 bc = stats1(max_obj).Centroid;
 rectangle('Position',bb,'EdgeColor','r','LineWidth',2);
 plot(bc(1),bc(2), '-m+');
 plot(bb(1),bb(2), '-m+');
 a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), '    Y: ', num2str(round(bc(2)))));
 set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
% end
end


