function [Prediction, MotionVectors, Flag]=Log_MotionSearch(Target, Reference)
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
        offset = ceil(p/2);
        u = 0;
        c = 0;
        succ = 0;
        T_MB = Target((k_x-1)*N+1:k_x*N,(k_y-1)*N+1:k_y*N);
        pred = zeros(N,N);
        last = false;
        x_0 = (k_x-1)*N+1;
        y_0 = (k_y-1)*N+1;
        while last ~= true
            for i = -1:1
                for j = -1:1
                    %HOW DO I HANDLE THE OUT OF BOUNDS FOR THIS??
                    x_off = min(max(x_0 + i*offset,1),n-N);
                    y_off = min(max(y_0 + j*offset,1),m-N);

                    R_MB = Reference(x_off:x_off+N-1,y_off:y_off + N-1);
                    cur_SAD = SAD(T_MB, R_MB);
                    if cur_SAD < min_SAD
                        min_SAD = cur_SAD;
                        u=i-p-1;
                        c=j-p-1;
                        succ = 1;
                        pred = R_MB;
                        x_temp = x_0 + i*offset;
                        y_temp = y_0 + j*offset;
                    end
                end
            end
            offset = ceil(offset/2);
            if offset == 1
                last = true;
            end
            x_0 = x_temp;
            y_0 = y_temp;
        end
        Prediction((k_x-1)*N+1:k_x*N,(k_y-1)*N+1:k_y*N) = pred;
        Flag(K_index) = succ;
        MotionVectors(K_index,:) = [u, c];
        K_index = K_index + 1;
    end
end

end