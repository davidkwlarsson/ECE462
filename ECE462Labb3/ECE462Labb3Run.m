%% ECE462 LABB 3

%% Week 1:
im = imread('lab3_p0101-1.pgm');
% im = rgb2ycc(im);
% im = im(:,:,1);
L = 3;
im_t = LHaar2D(double(im),L);
% subplot(211)
% imagesc(im_t)
% subplot(212)
% im_r = LRHaar2D(im_t,L);
disp_dwt(im_t,L)

%%
im = imread('lab3_p0102-1.pgm');
L = 3;
im_t = LHaar2D(double(im),L);
% subplot(211)
% imagesc(im_t)
% subplot(212)
im_r = LRHaar2D(im_t,L);
imagesc(im_r)
disp_dwt(im_t,L)


%% Week2:
L = 3;
im = imread('lab3_p0101-1.pgm');
im = double(im);
im_t = LCDF2D(im,L);
disp_dwt(im_t,L)
im_r = LRCDF2D(im_t,L);
figure
imagesc(im_r)
%% Basis img:
L = 3;
LL3 = zeros(64,64);
LL3(64/(2*(2^L)),64/(2*(2^L))) = 1;

LL3_base = LRCDF2D(LL3,L);

subplot(3,4,1)
imagesc(LL3_base)
plotnbr = 2;

for i = 0:2
  a = 12*2^i;
  b = 4*2^i;
  LH = zeros(64,64);
  LH(a,b) = 1;
  HL = zeros(64,64);
  HL(b,a) = 1;
  HH = zeros(64,64);
  HH(a,a) = 1;
  LH_base = LRCDF2D(LH,L);
  HL_base = LRCDF2D(HL,L);
  HH_base = LRCDF2D(HH,L);
  subplot(3,4,plotnbr)
  imagesc(LH_base)
  subplot(3,4,plotnbr+1)
  imagesc(HL_base)
  subplot(3,4,plotnbr+2)
  imagesc(HH_base)
  plotnbr = plotnbr + 3;
  
end
%% 
L = 3;
LL3 = zeros(64,64);
LL3(64/(2*(2^L)),64/(2*(2^L))) = 1;

LL3_base = LRHaar2D(LL3,L);

subplot(3,4,1)
imagesc(LL3_base)
plotnbr = 2;

for i = 0:2
  a = 12*2^i;
  b = 4*2^i;
  LH = zeros(64,64);
  LH(a,b) = 1;
  HL = zeros(64,64);
  HL(b,a) = 1;
  HH = zeros(64,64);
  HH(a,a) = 1;
  LH_base = LRHaar2D(LH,L);
  HL_base = LRHaar2D(HL,L);
  HH_base = LRHaar2D(HH,L);
  subplot(3,4,plotnbr)
  imagesc(LH_base)
  subplot(3,4,plotnbr+1)
  imagesc(HL_base)
  subplot(3,4,plotnbr+2)
  imagesc(HH_base)
  plotnbr = plotnbr + 3;
  
end

%% BIT PLANE CODING
%%
im = imread('lab3_p0101-1.pgm');
im = double(im);
transformed = LCDF2D(im,5);
[n,m] = size(im);
planes = zeros(n,m,6);
psnrs = zeros(6,1);
for i = 1:6
    plane = code_planes(transformed,i);
    figure
    reversed = LRCDF2D(plane,5);
    planes(:,:,i) = plane;
    reversed = uint8(round(reversed));
    imagesc(reversed);
    norm_mse = (im-double(reversed)).^2;
    mse = mean(norm_mse(:));
    psnrs(i) = 10*log10((255^2)/mse);
    
end

%% HAAR

%%
im = imread('lab3_p0101-1.pgm');
im = double(im);
transformed = LHaar2D(im,5);
[n,m] = size(im);
planes = zeros(n,m,6);
psnrs = zeros(6,1);
for i = 1:6
    plane = code_planes(transformed,i);
    figure
    reversed = LRHaar2D(plane,5);
    planes(:,:,i) = plane;
    reversed = uint8(round(reversed));
    imagesc(reversed);
    norm_mse = (im-double(reversed)).^2;
    mse = mean(norm_mse(:));
    psnrs(i) = 10*log10((255^2)/mse);
    
end




















% 
% im = imread('lab3_p0101-1.pgm');
% im = double(im);
% transformed = LCDF2D(im,5);
% signmat = sign(transformed);
% [n,m] = size(transformed);
% transformed = abs(transformed);
% MSB_mat = floor(log2(transformed));
% b_0 = max(MSB_mat(:));
% approxs = zeros(n,m,6);
% prev = zeros(n,m);
% % approx = transformed;
% for i = 0:5
%     approx = zeros(n,m);
%     b = b_0 - 1*i;
%     b_mat = transformed/(2^b);
%     b_mat = floor(b_mat);
%     b_mat = mod(b_mat,2);
%     i_eq = b_mat==MSB_mat;
%     i_less = b_mat<MSB_mat;
%     approx(i_eq) = 1.5*2^b;
%     approx(i_less) = prev(i_less) + (b_mat(i_less)*0.5*2^b - (1-b_mat(i_less))*0.5*2^b);     
%     approxs(:,:,i+1) = signmat.*reshape(approx,n,m);
%     prev = approx;
%     
% end
% 
% 



% im = imread('lab3_p0101-1.pgm');
% im = double(im);
% transformed = LHaar2D(im,5);
% signmat = sign(transformed);
% transformed = abs(transformed);
% MSB_mat = floor(log2(transformed));
% [n,m] = size(transformed);
% b_0 = max(MSB_mat(:));
% approxs_haar = zeros(n,m,6);
% approx = transformed;
% for i = 0:5
%     b = b_0 - 1*i;
%     b_mat = approx./(2.^b);
%     b_mat = floor(b_mat);
%     b_mat = mod(b_mat,2);
%     i_eq = b_mat==MSB_mat;
%     i_less = b_mat<MSB_mat;
%     approx(i_eq) = 1.5*2^b(i_eq);
%     approx(i_less) = approx(i_less) + (b_mat(i_less)*0.5.*2^b - (1-b_mat(i_less))*0.5*2^b);     
%     approxs_haar(:,:,i+1) = signmat.*reshape(approx,n,m);
%     
% end

%%
A100 = zeros(512,512);
A100(1,1) = 100;
A110 = zeros(512,512);
A110(1,1) = 110;
HA110 = LHaar2D(A110,3);
HA100 = LHaar2D(A100,3);
norm_mse = (A110-A100).^2;
mse = mean(norm_mse(:))
immse(HA100,HA110)
diff = HA110 - HA100;
number = nonzeros(diff);
size(number)

%%

A50 = zeros(512,512);
A50(1,1) = 50;
A60 = zeros(512,512);
A60(1,1) = 60;
HA60 = LRHaar2D(A60,2);
HA50 = LRHaar2D(A50,2);
norm_mse = (A60-A50).^2;
mse = mean(norm_mse(:))
immse(HA50,HA60)
diff = HA60 - HA50;
number = nonzeros(diff);
size(number)