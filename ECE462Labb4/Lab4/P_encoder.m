function Output = P_encoder(Reference, Current,QP,Q_Intra, Q_Inter)
[N,M] = size(Current);
Output = zeros(N,M);
[Pred, MV, Flag] = Sequential_MotionSearch(Current, Reference);
iter = 1;
for x = 1:16:M
    for y = 1:16:N
        if (Flag(iter) == 1)
            MB_encoded = zeros(16,16);
            MB = Current(y:y+15,x:x+15) - Pred(y:y+15,x:x+15);
            for i = 1:8:16
                for j = 1:8:16
                T_8 = forward_dct_quant(MB(i:i+7,j:j+7),QP,Q_Inter);
                G_8 = inverse_dct_quant(T_8,QP,Q_Inter);
                MB_encoded(i:i+7,j:j+7) = G_8;
                end
            end
            Output(y:y+15,x:x+15) = MB_encoded +  Pred(y:y+15,x:x+15);
            iter = iter + 1;
        else 
            MB_encoded = zeros(16,16);
            MB = Current(y:y+15,x:x+15);
            for i = 1:8:16
                for j = 1:8:16
                T_8 = forward_dct_quant(MB(i:i+7,j:j+7),QP,Q_Intra);
                G_8 = inverse_dct_quant(T_8,QP,Q_Intra);
                MB_encoded(i:i+7,j:j+7) = G_8;
                end
            end
            Output(y:y+15,x:x+15) = MB_encoded;
            iter = iter + 1;
        end
    end
end


end