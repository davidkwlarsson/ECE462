function snr = SNR(P, Q)
%Calculates the SNR of a corrupted picture
%   P = Original image
%   Q = Corrupted image
P = double(P);
Q = double(Q);
[n,m,~] = size(P);
N = n*m;
mse = MSE(P,Q);
p_norm2 = (P(:,:,1).^2 + P(:,:,2).^2 + P(:,:,3).^2)/3;
snr = 10*log10((sum(p_norm2(:))/N)/mse);
end