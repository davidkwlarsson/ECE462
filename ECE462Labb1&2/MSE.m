function mse = MSE(P, Q)
%Calculates the MSE of a corrupted picture
%   P = Original image
%   Q = Corrupted image
P = double(P);
Q = double(Q);
[n,m,~] = size(P);
N = n*m;
norm_mse = ((P(:,:,1)-Q(:,:,1)).^2 + (P(:,:,2)-Q(:,:,2)).^2 + (P(:,:,3)-Q(:,:,3)).^2)/3;
mse = mean(norm_mse(:));
end