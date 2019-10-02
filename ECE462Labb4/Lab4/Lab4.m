cmap = gray(256);

target = imread('lab4_wk1_p0102_tgt.pgm');
% figure, imagesc(target);
% title('Target');
% colormap(cmap);

ref = imread('lab4_wk1_p0102_ref.pgm');
% figure, imagesc(ref);
% title('Reference');
% colormap(cmap);

[Pred, MV, Flag] = Sequential_MotionSearch(target, ref);
res = double(target) - double(Pred);

show_mv(MV);
title('Sequential Motion Vectors');

figure, imagesc(Pred);
title('Sequential Prediction');
colormap(cmap);

figure, imagesc(res);
title('Sequential Residual');
colormap(cmap);

seq_mse = immse(uint8(Pred), target)

[Pred, MV, Flag] = Logarithmic_MotionSearch(target, ref);
res = double(target) - double(Pred);

show_mv(MV);
title('Logarithmic Motion Vectors');

figure, imagesc(Pred);
title('Logarithmic Prediction');
colormap(cmap);

figure, imagesc(res);
title('Logarithmic Residual');
colormap(cmap);

log_mse = immse(uint8(Pred), target)

%% WEEK 2
Q = load('Q_matrices.mat');
Q_Inter = Q.Q_intra;
Q_Intra = Q.Q_inter;
QP = 2;
%% IPIPIP...
seq = load('sequence_P0101.mat');
seq = seq.sequence;
seq = double(seq);
outputIPIP = zeros(288,352,30);
for i= 0:14
    I = seq(:,:,2*i+1);
    P = seq(:,:,2*(i+1));
    I_enc = I_encoder(I,QP,Q_Intra);
    outputIPIP(:,:,2*i + 1) = I_enc;
    outputIPIP(:,:,2*(i+1)) = P_encoder(I_enc, P, QP, Q_Intra, Q_Inter);
    
end
play_frames(outputIPIP,5);
[Pred_IP,MV_IP,Flag] = Sequential_MotionSearch(seq(:,:,end), outputIPIP(:,:,end-1));
show_mv(MV_IP)
PSNR_IP = 10*log10(255^2/(immse(Pred_IP,outputIPIP(:,:,end))));
%% IPPPPP...
seq = load('sequence_P0102.mat');
seq = seq.sequence;
seq = double(seq);
outputIPPP = zeros(288,352,30);
I = seq(:,:,1);
prev = I_encoder(I,QP,Q_Intra);
outputIPPP(:,:,1) = prev;
for i= 2:30
    P = seq(:,:,i);
    prev = P_encoder(prev, P, QP, Q_Intra, Q_Inter);
    outputIPPP(:,:,i) = prev;
end
play_frames(outputIPPP,5);
[Pred_PP,MV_PP,Flag] = Sequential_MotionSearch(seq(:,:,end), outputIPPP(:,:,end-1));
show_mv(MV_PP);
PSNR_PP = 10*log10(255^2/(immse(Pred_PP,outputIPPP(:,:,end))));