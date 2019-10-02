function Output = inverse_dct_quant(Input,QP,Q_matrix)
    T_q = Input;
    T_hat = T_q.*QP.*Q_matrix;
    G = backwardDCT(T_hat);
    Output = G;
end