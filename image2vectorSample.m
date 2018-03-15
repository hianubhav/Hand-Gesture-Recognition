function image2vectorSample(I)
%srcFiles = dir('C:\Users\Monika\Downloads\mini project\a\5 training set\Ima1.jpg');  % the folder in which ur images exists
 %   filename = strcat('C:\Users\Monika\Downloads\mini project\a\5 training set\Ima1.jpg');
    %I = imread(filename);
    imageVector = reshape(I, 1, []);
        temp=imageVector';
save('sample3.mat','temp');
