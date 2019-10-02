function [Prediction, MotionVector, Flag] = Logarithmic_MotionSearch_MacroBlock(Target, Reference, x, y, p)
    [M,N] = size(Target);
    min_x = x;
    min_y = y;
    min_delta = 0;
    
    starting_x = x;
    starting_y = y;
    
    min_SAD = 16*16*256;
    threshold = 2048;
    
    MotionVector = zeros(1, 2);
    Flag = 0;
    Prediction = zeros(16,16);

    offset = p/2;
    
    while offset > 1
        for i = -1:1
            for j = -1:1
                xp = starting_x + i*offset;
                yp = starting_y + j*offset;
                
                if xp < 1 || yp < 1 || xp > M-15 || yp > N-15
                   continue 
                end
                
                cur_SAD = SAD(Target, Reference, starting_x, starting_y, xp, yp);

                if cur_SAD < min_SAD
                    min_SAD = cur_SAD;
                    min_x = xp;
                    min_y = yp;
                    min_delta = (xp-x)^2 + (yp-y)^2;
                    
                elseif cur_SAD == min_SAD
                    cur_delta = (xp-x)^2 + (yp-y)^2;
                    if cur_delta < min_delta
                       min_x = xp;
                       min_y = yp;
                       min_delta = cur_delta;
                    end 
                end
            end
        end
        offset = offset/2;
        starting_x = min_x;
        starting_y = min_y;
    end
    
    if min_SAD < threshold
        Flag = 1;
        MotionVector(1, 1) = min_x - x;
        MotionVector(1, 2) = min_y - y;
        Prediction = Reference(min_x:min_x+15, min_y:min_y+15);
    end