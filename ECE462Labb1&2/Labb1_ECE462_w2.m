%% Labb1_ECE462_w2

Q = imread('jbeans_corrupted_sample.ppm');
P = imread('jbeans.ppm');
mse = MSE(P,Q)
psnr = PSNR(P,Q)
snr = SNR(P,Q)

%%
randn('state',sum(100*clock));
im = imread('jbeans.ppm');
jbeans_ycc = rgb2ycc(im);
vars = [10^2,20^2,40^2,80^2,100^2];
result_y = zeros(3,length(vars)); %first row = MSE
result_Cb = zeros(3,length(vars)); %second row = PSNR
result_Cr = zeros(3,length(vars)); %third row = SNR
for i = 1:length(vars)
    sigma2 = vars(i);
    
    noise = sqrt(sigma2)*randn(256);
    ycc_corrupted_y = jbeans_ycc;
    ycc_corrupted_y(:,:,1) = ycc_corrupted_y(:,:,1) + noise;
    
    noise = sqrt(sigma2)*randn(256);
    ycc_corrupted_Cb = jbeans_ycc;
    ycc_corrupted_Cb(:,:,2) = ycc_corrupted_Cb(:,:,2) + noise;
    
    noise = sqrt(sigma2)*randn(256);
    ycc_corrupted_Cr = jbeans_ycc;
    ycc_corrupted_Cr(:,:,3) = ycc_corrupted_Cr(:,:,3) + noise;
    
    rgb_corrupted_y = uint8(ycc2rgb(ycc_corrupted_y));
    rgb_corrupted_Cb = uint8(ycc2rgb(ycc_corrupted_Cb));
    rgb_corrupted_Cr = uint8(ycc2rgb(ycc_corrupted_Cr));
    
    result_y(:,i) = [MSE(im,rgb_corrupted_y); PSNR(im, rgb_corrupted_y);...
                SNR(im, rgb_corrupted_y)];
    result_Cb(:,i) = [MSE(im,rgb_corrupted_Cb); PSNR(im, rgb_corrupted_Cb);...
                SNR(im, rgb_corrupted_Cb)];
    result_Cr(:,i) = [MSE(im,rgb_corrupted_Cr); PSNR(im, rgb_corrupted_Cr);...
                SNR(im, rgb_corrupted_Cr)];
    
end

%% Plot MSE
figure; hold on;
plot(vars, result_y(1,:)) %first row contains MSE
plot(vars, result_Cb(1,:))
plot(vars, result_Cr(1,:))
title('MSE')
legend('Y-corrupted', 'Cb-corrupted', 'Cr-corrupted')
hold off;


%% Plot PSNR
figure; hold on;
plot(vars, result_y(2,:)) %first row contains MSE
plot(vars, result_Cb(2,:))
plot(vars, result_Cr(2,:))
legend('Y-corrupted', 'Cb-corrupted','Cr-corrupted')
title('PSNR')
hold off;
%% Plot SNR
figure; hold on;
plot(vars, result_y(3,:)) %first row contains MSE
plot(vars, result_Cb(3,:))
plot(vars, result_Cr(3,:))
legend('Y-corrupted', 'Cb-corrupted','Cr-corrupted')
title('SNR')
hold off;

%% Reconstucted, corrupted, sigma = 80
im = imread('jbeans.ppm');
jbeans_ycc = rgb2ycc(im);
noise = 80*randn(256);
ycc_corrupted_y = jbeans_ycc;
ycc_corrupted_y(:,:,1) = ycc_corrupted_y(:,:,1) + noise;

noise = 80*randn(256);
ycc_corrupted_Cb = jbeans_ycc;
ycc_corrupted_Cb(:,:,2) = ycc_corrupted_Cb(:,:,2) + noise;

noise = 80*randn(256);
ycc_corrupted_Cr = jbeans_ycc;
ycc_corrupted_Cr(:,:,3) = ycc_corrupted_Cr(:,:,3) + noise;
rgb_corrupted_y = uint8(ycc2rgb(ycc_corrupted_y));
rgb_corrupted_Cb = uint8(ycc2rgb(ycc_corrupted_Cb));
rgb_corrupted_Cr = uint8(ycc2rgb(ycc_corrupted_Cr));

figure
subplot(221)
image(rgb_corrupted_y)
title('Y-corrupt')
subplot(222)
imagesc(rgb_corrupted_Cb)
title('Cb-corrupt')
subplot(223)
imagesc(rgb_corrupted_Cr)
title('Cr-corrupt')

