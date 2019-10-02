%% Labb 2 week 2

%% 
im = imread('lena512color.tiff');
im_ycc = rgb2ycc(im);
im_y = im_ycc(:,:,1);
im_cb = im_ycc(:,:,2);
im_cr = im_ycc(:,:,3);
T_y = zeros(512,512);
T_cb = zeros(512,512);
T_cr = zeros(512,512);
Q_y = [16 11 10 16 24 40 51 61; 12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56; 14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77; 24 36 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101; 72 92 95 98 112 100 103 107];
Q_c = [17 18 24 47 99 99 99 99; 18 21 26 66 99 99 99 99;
    24 26 56 99 99 99 99 99; 47 66 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99; 99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99; 99 99 99 99 99 99 99 99];
for i = 0:63
    for j = 0:63
    im_y_block = im_y(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    im_cb_block = im_cb(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    im_cr_block = im_cr(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    t_y_block = forwardDCT(im_y_block);
    t_cb_block = forwardDCT(im_cb_block);
    t_cr_block = forwardDCT(im_cr_block);
    T_y(i*8+1:(i+1)*8, j*8+1:(j+1)*8) = quantizer(t_y_block,Q_y);
    T_cb(i*8+1:(i+1)*8, j*8+1:(j+1)*8) = quantizer(t_cb_block,Q_c);
    T_cr(i*8+1:(i+1)*8, j*8+1:(j+1)*8) = quantizer(t_cr_block,Q_c);
    end
end

%% alpha = 5

T_y_alpha = zeros(512,512);
T_cb_alpha = zeros(512,512);
T_cr_alpha = zeros(512,512);
Q_y_alpha = 5*[16 11 10 16 24 40 51 61; 12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56; 14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77; 24 36 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101; 72 92 95 98 112 100 103 107];
Q_c_alpha = 5*[17 18 24 47 99 99 99 99; 18 21 26 66 99 99 99 99;
    24 26 56 99 99 99 99 99; 47 66 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99; 99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99; 99 99 99 99 99 99 99 99];
for i = 0:63
    for j = 0:63
    im_y_block = im_y(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    im_cb_block = im_cb(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    im_cr_block = im_cr(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    t_y_block = forwardDCT(im_y_block);
    t_cb_block = forwardDCT(im_cb_block);
    t_cr_block = forwardDCT(im_cr_block);
    T_y_alpha(i*8+1:(i+1)*8, j*8+1:(j+1)*8) = quantizer(t_y_block,Q_y_alpha);
    T_cb_alpha(i*8+1:(i+1)*8, j*8+1:(j+1)*8) = quantizer(t_cb_block,Q_c_alpha);
    T_cr_alpha(i*8+1:(i+1)*8, j*8+1:(j+1)*8) = quantizer(t_cr_block,Q_c_alpha);
    end
end

%% 6 CREATE A Q

Q_y_R5 = zeros(8,8);
Q_c_R5 = zeros(8,8);
Q_y_R63 = zeros(8,8);
Q_c_R63 = zeros(8,8);
R5 = [1,5];
R63 = [1,63];
for i = 0:7
    for j = 0:7
        Q_y_R5((i+1),(j+1)) = 1 + (i^2 + j^2)*1;
        Q_c_R5((i+1),(j+1)) = 1 + (i^2 + j^2)*5;
        Q_y_R63((i+1),(j+1)) = 1 + (i^2 + j^2)*1;
        Q_c_R63((i+1),(j+1)) = 1 + (i^2 + j^2)*63;
    end
end


for i = 0:63
    for j = 0:63
    im_y_block = im_y(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    im_cb_block = im_cb(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    im_cr_block = im_cr(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    t_y_block = forwardDCT(im_y_block);
    t_cb_block = forwardDCT(im_cb_block);
    t_cr_block = forwardDCT(im_cr_block);
    T_y_R5(i*8+1:(i+1)*8, j*8+1:(j+1)*8) = quantizer(t_y_block,Q_y_R5);
    T_cb_R5(i*8+1:(i+1)*8, j*8+1:(j+1)*8) = quantizer(t_cb_block,Q_c_R5);
    T_cr_R5(i*8+1:(i+1)*8, j*8+1:(j+1)*8) = quantizer(t_cr_block,Q_c_R5);
    T_y_R63(i*8+1:(i+1)*8, j*8+1:(j+1)*8) = quantizer(t_y_block,Q_y_R63);
    T_cb_R63(i*8+1:(i+1)*8, j*8+1:(j+1)*8) = quantizer(t_cb_block,Q_c_R63);
    T_cr_R63(i*8+1:(i+1)*8, j*8+1:(j+1)*8) = quantizer(t_cr_block,Q_c_R63);
    end
end

%% 7
G = zeros(512,512,3);

G_alpha = zeros(512,512,3);

G_R5 = zeros(512,512,3);

G_R63 = zeros(512,512,3);

for i = 0:63
    for j = 0:63
    y_block = T_y(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    cb_block = T_cb(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    cr_block = T_cr(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    G(i*8+1:(i+1)*8, j*8+1:(j+1)*8,1) = backwardDCT(y_block.*Q_y);
    G(i*8+1:(i+1)*8, j*8+1:(j+1)*8,2) = backwardDCT(cb_block.*Q_c);
    G(i*8+1:(i+1)*8, j*8+1:(j+1)*8,3) = backwardDCT(cr_block.*Q_c);
%     G_y_block = backwardDCT(y_block);
%     G_cb_block = backwardDCT(cb_block);
%     G_cr_block = backwardDCT(cr_block);
%     G(i*8+1:(i+1)*8, j*8+1:(j+1)*8,1) = G_y_block.*Q_y;
%     G(i*8+1:(i+1)*8, j*8+1:(j+1)*8,2) = G_cb_block.*Q_c;
%     G(i*8+1:(i+1)*8, j*8+1:(j+1)*8,3) = G_cr_block.*Q_c;
    
    y_block = T_y_alpha(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    cb_block = T_cb_alpha(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    cr_block = T_cr_alpha(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    G_alpha(i*8+1:(i+1)*8, j*8+1:(j+1)*8,1) = backwardDCT(y_block.*Q_y_alpha);
    G_alpha(i*8+1:(i+1)*8, j*8+1:(j+1)*8,2) = backwardDCT(cb_block.*Q_c_alpha);
    G_alpha(i*8+1:(i+1)*8, j*8+1:(j+1)*8,3) = backwardDCT(cr_block.*Q_c_alpha);
%     G_y_block = backwardDCT(y_block);
%     G_cb_block = backwardDCT(cb_block);
%     G_cr_block = backwardDCT(cr_block);
%     G_alpha(i*8+1:(i+1)*8, j*8+1:(j+1)*8,1) = G_y_block.*Q_y_alpha;
%     G_alpha(i*8+1:(i+1)*8, j*8+1:(j+1)*8,2) = G_cb_block.*Q_c_alpha;
%     G_alpha(i*8+1:(i+1)*8, j*8+1:(j+1)*8,3) = G_cr_block.*Q_c_alpha;
    
    y_block = T_y_R5(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    cb_block = T_cb_R5(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    cr_block = T_cr_R5(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    G_R5(i*8+1:(i+1)*8, j*8+1:(j+1)*8,1) = backwardDCT(y_block.*Q_y_R5);
    G_R5(i*8+1:(i+1)*8, j*8+1:(j+1)*8,2) = backwardDCT(cb_block.*Q_c_R5);
    G_R5(i*8+1:(i+1)*8, j*8+1:(j+1)*8,3) = backwardDCT(cr_block.*Q_c_R5);
%     G_y_block = backwardDCT(y_block);
%     G_cb_block = backwardDCT(cb_block);
%     G_cr_block = backwardDCT(cr_block);
%     G_R5(i*8+1:(i+1)*8, j*8+1:(j+1)*8,1) = G_y_block.*Q_y_R5;
%     G_R5(i*8+1:(i+1)*8, j*8+1:(j+1)*8,2) = G_cb_block.*Q_c_R5;
%     G_R5(i*8+1:(i+1)*8, j*8+1:(j+1)*8,3) = G_cr_block.*Q_c_R5;
    
    y_block = T_y_R63(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    cb_block = T_cb_R63(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    cr_block = T_cr_R63(i*8+1:(i+1)*8, j*8+1:(j+1)*8);
    G_R63(i*8+1:(i+1)*8, j*8+1:(j+1)*8,1) = backwardDCT(y_block.*Q_y_R63);
    G_R63(i*8+1:(i+1)*8, j*8+1:(j+1)*8,2) = backwardDCT(cb_block.*Q_c_R63);
    G_R63(i*8+1:(i+1)*8, j*8+1:(j+1)*8,3) = backwardDCT(cr_block.*Q_c_R63);
%     G_y_block = backwardDCT(y_block);
%     G_cb_block = backwardDCT(cb_block);
%     G_cr_block = backwardDCT(cr_block);
%     G_R63(i*8+1:(i+1)*8, j*8+1:(j+1)*8,1) = G_y_block.*Q_y_R63;
%     G_R63(i*8+1:(i+1)*8, j*8+1:(j+1)*8,2) = G_cb_block.*Q_c_R63;
%     G_R63(i*8+1:(i+1)*8, j*8+1:(j+1)*8,3) = G_cr_block.*Q_c_R63;
    
    end
end

%% PSNR
G = ycc2rgb(G);
G_alpha = ycc2rgb(G_alpha);
G_R5 = ycc2rgb(G_R5);
G_R63 = ycc2rgb(G_R63);

PSNR_org = PSNR(im,uint8(G))
PSNR_alpha = PSNR(im,uint8(G_alpha))
PSNR_R5 = PSNR(im,uint8(G_R5))
PSNR_R63 = PSNR(im,uint8(G_R63))

