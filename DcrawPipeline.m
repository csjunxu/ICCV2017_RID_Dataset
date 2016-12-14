%% 0 read the tiff image
raw = double(imread('20161214/DSC01381.tiff'));

%% 1 Linearization
black = 0;
saturation = 4092 ;
lin_bayer = (raw-black)/(saturation-black); % ��һ����[0,1];
lin_bayer = max(0,min(lin_bayer,1)); % ȷ��û�д���1��С��0������;
imshow(lin_bayer);

%% 2 White Balancing
wb_multipliers = [1.902344, 1, 1.808594]; % for particular condition, from dcraw;
mask = wbmask(size(lin_bayer,1),size(lin_bayer,2),wb_multipliers,'rggb');
balanced_bayer = lin_bayer .* mask;
imshow(balanced_bayer);

%% 3 Demosaicking
temp = uint16(balanced_bayer/max(balanced_bayer(:)) * (2^16-1));
lin_rgb = double(demosaic(temp,'rggb'))/(2^16-1);
imshow(lin_rgb);

%% 4 Color Space Conversion
sRGB2XYZ = [0.4124564 0.3575761 0.1804375;0.2126729 0.7151522 0.0721750;0.0193339 0.1191920 0.9503041];
% sRGB2XYZ is an unchanged standard
XYZ2Cam = [7171 -1986 -648;-8085 15555 2718;-2170 2512 7457]/10000;
% Here XYZ2Cam is only for Nikon D3X, can be found in adobe_coeff in dcraw.c
sRGB2Cam = XYZ2Cam * sRGB2XYZ;
sRGB2Cam = sRGB2Cam./ repmat(sum(sRGB2Cam,2),1,3); % normalize each rows of sRGB2Cam to 1
Cam2sRGB = (sRGB2Cam)^-1;
lin_srgb = apply_cmatrix(lin_rgb, Cam2sRGB);
lin_srgb = max(0,min(lin_srgb,1)); % Always keep image clipped b/w 0-1
