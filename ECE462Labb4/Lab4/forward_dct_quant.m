function Output = forward_dct_quant(Input,QP,Q_matrix)
    T = forwardDCT(Input);
    T_q = round(T./(QP.*Q_matrix));
    Output = T_q;

end