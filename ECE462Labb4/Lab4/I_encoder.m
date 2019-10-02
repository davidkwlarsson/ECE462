function Output = I_encoder(Current,QP,Q_matrix)
[N,M] = size(Current);
Output = zeros(N,M);
for x = 1:16:M
    for y = 1:16:N
        MB_encoded = zeros(16,16);
        MB = Current(y:y+15,x:x+15);
        for i = 1:8:16
            for j = 1:8:16
            T_8 = forward_dct_quant(MB(i:i+7,j:j+7),QP,Q_matrix);
            G_8 = inverse_dct_quant(T_8,QP,Q_matrix);
            MB_encoded(i:i+7,j:j+7) = G_8;
            end
        end
        Output(y:y+15,x:x+15) = MB_encoded;
    end
end

end