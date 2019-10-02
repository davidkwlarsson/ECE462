%% Labb 4 Week 1:

im_ref = imread('lab4_wk1_p0101_ref.pgm');
im_tgt = imread('lab4_wk1_p0101_tgt.pgm');
[Prediction, MotionVectors, Flag]=Sequential_MotionSearch(im_tgt, im_ref);
show_mv(MotionVectors)
figure
subplot(211)
imagesc(Prediction)
subplot(212)
imagesc(double(im_tgt) - double(Prediction))
colormap('gray')
mse_seq = immse(double(im_tgt),double(Prediction));
%%
im_ref = imread('lab4_wk1_p0101_ref.pgm');
im_tgt = imread('lab4_wk1_p0101_tgt.pgm');
[Prediction, MotionVectors, Flag]=Log_MotionSearch(im_tgt, im_ref);
show_mv(MotionVectors)
figure
subplot(211)
imagesc(double(Prediction))
subplot(212)
imagesc(double(im_tgt) - double(Prediction))
colormap('gray')
mse_log = immse(double(im_tgt),double(Prediction));