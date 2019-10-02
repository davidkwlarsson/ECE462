%% Labb 2 week 1

%% 1.2 
G1 = 3*ones(8);
G2 = 10*ones(8);
G2(:,1:2:end) = 5;
T1 = zeros(8);
T2 = zeros(8);
T1_int = zeros(8);
T2_int = zeros(8);
for i = 0:1
    for j = 0:1
        G1_block = 3*ones(4);
        G2_block = 10*ones(4);
        G2_block(:,1:2:end) = 5;
        T1_int_block = forward_DCT_H264(G1_block);
        T1_block = forwardDCT(G1_block);
        T2_int_block = forward_DCT_H264(G2_block);
        T2_block = forwardDCT(G2_block);
        T1(i*4+1:(i+1)*4, j*4+1:(j+1)*4) = T1_block;
        T2(i*4+1:(i+1)*4, j*4+1:(j+1)*4) = T2_block;
        T1_int(i*4+1:(i+1)*4, j*4+1:(j+1)*4) = T1_int_block;
        T2_int(i*4+1:(i+1)*4, j*4+1:(j+1)*4) = T2_int_block;
    end
end

%% 1.3 
DCT_norm1 = abs(norm(G1) - norm(T1)); %about 0
DCT_norm2 = abs(norm(G2) - norm(T2)); %about 0
int_norm1 = abs(norm(G1) - norm(T1_int)); %non-zero
int_norm2 = abs(norm(G2) - norm(T2_int)); %non-zero

%% 1.4 with the DCT transformed
G1_int = zeros(8);
G2_int = zeros(8);
for i = 0:1
    for j = 0:1
        T1_block = T1(i*4+1:(i+1)*4, j*4+1:(j+1)*4);
        T2_block = T2(i*4+1:(i+1)*4, j*4+1:(j+1)*4);
        G1_int_block = backward_DCT_H264(T1_block);
%         G1_block = forwardDCT(T1_block);
        G2_int_block = backward_DCT_H264(T2_block);
%         G2_block = forwardDCT(T2_block);
%         G1(i*4+1:(i+1)*4, j*4+1:(j+1)*4) = G1_block;
%         G2(i*4+1:(i+1)*4, j*4+1:(j+1)*4) = G2_block;
        G1_int(i*4+1:(i+1)*4, j*4+1:(j+1)*4) = G1_int_block;
        G2_int(i*4+1:(i+1)*4, j*4+1:(j+1)*4) = G2_int_block;
    end
end

%% 1.4 with the int transformed
G1_int = zeros(8);
G2_int = zeros(8);
for i = 0:1
    for j = 0:1
        T1_block = T1_int(i*4+1:(i+1)*4, j*4+1:(j+1)*4);
        T2_block = T2_int(i*4+1:(i+1)*4, j*4+1:(j+1)*4);
        G1_int_block = forward_DCT_H264(T1_block);
%         G1_block = forwardDCT(T1_block);
        G2_int_block = forward_DCT_H264(T2_block);
%         G2_block = forwardDCT(T2_block);
%         G1(i*4+1:(i+1)*4, j*4+1:(j+1)*4) = G1_block;
%         G2(i*4+1:(i+1)*4, j*4+1:(j+1)*4) = G2_block;
        G1_int(i*4+1:(i+1)*4, j*4+1:(j+1)*4) = G1_int_block;
        G2_int(i*4+1:(i+1)*4, j*4+1:(j+1)*4) = G2_int_block;
    end
end


%% 1.5 Construct images of the Basis images for Dimension N

N = 6;
[F,B] = F_B_DCT(N);
numberplot = 1;
clims = [-0.5 0.5];
for i = 1:N
    for j = 1:N   
        subplot(N,N,numberplot)
        imagesc(F(i,:)'*F(j,:),clims)
        numberplot = numberplot + 1;
    end
end
colormap('gray')


