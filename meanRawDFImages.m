%% mean of dark frames
Original_image_dir = '20161219DF/';
fpath = fullfile(Original_image_dir, '*.pgm');
im_dir  = dir(fpath);
im_num = length(im_dir);
rawDF = double(imread(fullfile(Original_image_dir, im_dir(1).name)));
meanDF = zeros(size(rawDF)); 
for i = 1:im_num
    %% read the tiff image
    rawDF = double(imread(fullfile(Original_image_dir, im_dir(i).name)));
    S = regexp(im_dir(i).name, '\.', 'split');
    rawname = S{1};
    fprintf('Processing %s. \n', rawname);
    meanDF = meanDF + rawDF;
end
meanDF = round(meanDF./im_num);
meanDF = uint16(meanDF);
imshow(meanDF);
imwrite(meanDF,'mean_DF_ARW2TIF.tiff');
clear rawDF meanDF;