function T = forwardDCT(G)
N = length(G);
[F,~] = F_B_DCT(N);
T = F*G*(F');
end