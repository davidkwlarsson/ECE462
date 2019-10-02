%% Labb 1: Week 1
im = zeros(10,10,3);
im(1:2:end,1:2:end,:) = 255;
im(2:2:end,2:2:end,:) = 255;
image(uint8(im))
%%
im(5:2:7,4:2:6,1) = 255;
im(4:2:6,5:2:7,1) = 255;
image(uint8(im))
%%
randim = 255*rand([256,256,3]);
image(uint8(randim))
figure
Rmu = mean(mean(randim(:,:,1)));
Gmu = mean(mean(randim(:,:,2)));
Bmu = mean(mean(randim(:,:,3)));
iR = find(randim(:,:,1) > Rmu);
iG = find(randim(:,:,2) > Gmu);
iB = find(randim(:,:,3) > Bmu);
randim(iR) = Rmu;
randim(iG) = Gmu;
randim(iB) = Bmu;
image(uint8(randim))

%% 2 Color image Transfrom
im = imread('jbeans.ppm');
yccim = rgb2ycc(im);
subplot(221)
imagesc(yccim(:,:,1))
title('Y-chanel')
subplot(222)
imagesc(yccim(:,:,2))
title('Cb-chanel')
subplot(223)
imagesc(yccim(:,:,3))
title('Cr-chanel')
%%
rgbim = ycc2rgb(yccim);
subplot(211)
image(uint8(rgbim))
title('reconstructed image')
subplot(212)
image(im)
title('Original image')



