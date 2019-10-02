function psnr = PSNR(P, Q)
%Calculates the PSNR of a corrupted picture
%   P = Original image
%   Q = Corrupted image
P = double(P);
Q = double(Q);
mse = MSE(P,Q);
psnr = 10*log10((255^2)/mse);

end