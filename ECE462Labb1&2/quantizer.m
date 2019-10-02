function T_q = quantizer(T,Q)
T_q = round(T./Q);
T_hat = T_q.*Q;