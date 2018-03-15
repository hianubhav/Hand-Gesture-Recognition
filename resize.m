function I=resize(frame)
%    srcFiles = dir('E:\Downloads\Compressed\hand\4\*.jpg');  % the folder in which ur images exists
%    filename = strcat('E:\Downloads\Compressed\hand\4\',srcFiles(i).name);
%    I = imread(filename);
    I= extractGesture(frame);
    I = imresize(I,[80 45]);%give required resolution in [ ] square braces 
%    fname=['Ima' num2str(i) '.jpg']; %output images will be as Ima1.jpg Ima2.jpg Ima3.jpg in the same specified folder above 
%    imwrite(J,fname,'jpg')
%     figure, imshow(J);
end


