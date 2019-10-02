function [Prediction, MotionVectors, Flag]=Sequential_MotionSearch(Target, Reference) 
Target = double(Target);
Reference = double(Reference);
N = 16;
p = 8;
[n,m] = size(Target);
K_x = m/N;
K_y = n/N;
K = (n*m)/(N^2);
Prediction = zeros(n,m);
MotionVectors = zeros(K,2);
Flag = zeros(K,1);
K_index = 1;
for k_x = 1:K_y
    for k_y = 1:K_x    
        min_SAD = 2048;
        u = 0;
        c = 0;
        succ = 0;
        T_MB = Target((k_x-1)*N+1:k_x*N,(k_y-1)*N+1:k_y*N);
        if (k_x-1)*N-p < 1 || (k_x)*N + p > n || (k_y-1)*N-p < 1 || (k_y)*N + p > n
            continue
        end
        R_MB = Reference((k_x-1)*N-p:k_x*N+p,(k_y-1)*N-p:k_y*N+p);
        pred = zeros(N,N);
        for i = -p:p
            for j = -p:p
                cur_SAD = SAD(T_MB,R_MB(i:i+N,j:j+N));
                if cur_SAD < min_SAD
                    min_SAD = cur_SAD;
                    u=(k_x-1)*N+1 - max((k_x-1)*N,1)+i;
                    c=(k_y-1)*N+1 - max((k_y-1)*N,1)+j;
                    succ = 1;
                    pred = R_MB(i:i+N-1,j:j+N-1);

                end
            end
        end
        size(pred)
        Prediction((k_x-1)*N+1:k_x*N,(k_y-1)*N+1:k_y*N) = pred;
        Flag(K_index) = succ;
        MotionVectors(K_index,:) = [u, c];
        K_index = K_index + 1;
    end
end

end