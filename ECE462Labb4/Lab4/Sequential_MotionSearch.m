function [Prediction, MotionVectors, Flag] = Sequential_MotionSearch(Target, Reference)
    [M,N] = size(Target);
    
    K = M*N/256;
    MotionVectors = zeros(K, 2);
    Flag = zeros(K, 1);
    Prediction = zeros(M,N);
    iter = 0;
    
    
    for x = 1:16:M
        for y = 1:16:N
            iter = iter + 1;
            
            [mbp, mbmv, mbf] = Sequential_MotionSearch_MacroBlock(Target, Reference, x, y);
            
            Prediction(x:x+15, y:y+15) = mbp;
            MotionVectors(iter, :) = mbmv(1, :);
            Flag(iter, 1) = mbf;
        end
    end
    
    