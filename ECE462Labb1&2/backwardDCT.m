function G = backwardDCT(T)
N = length(T);
[~,B] = F_B_DCT(N);
G = B*T*(B');
end