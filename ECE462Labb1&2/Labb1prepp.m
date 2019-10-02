%% Lab 1 ECE462 Prepp

im = zeros(300,300,3);
im(:,:,3) = 1;
im(150:151,:,:) = 1;
im(:,150:151,:) = 1;
image(im)

%%
im(:,:,3) = im(:,:,3) - sum(sum(im(:,:,3)))/(300*300);
image(im)


%%
A = ones(1000,1000,3);
A(1:250,250:750,:) = 0.5;
A(1:250,750:end,:) = 0;
A(250:750,1:250,:) = 0;
A(250:750,750:end,:) = 0.5;
A(750:end,1:250,:) = 0.5;
A(750:end,250:750,:) = 0;
image(A);
gray_map = (linspace(0,1,256)')*ones(1,3);
colormap(gray_map);

%%
S = ones(5,1);
S(3) = 0;
S(1) = 0;
S1=S(1:2:end); %The odd numbers
S2=S(2:2:end);

