function [Prediction, MotionVector, Flag] = Sequential_MotionSearch_MacroBlock(Target, Reference, x, y)
    [M,N] = size(Target);
    min_x = x;
    min_y = y;
    min_delta = double(0);
    min_SAD = 16*16*256;
    threshold = 2048;
    p = 4;
    
    MotionVector = zeros(1, 2);
    Flag = 0;
    Prediction = zeros(16,16);

    dup_count = 0;
    over_count = 0;
    
    if x < 1 || y < 1 || x > M-15 || y > N-15
       return
    end

    for i = -p:p
        for j = -p:p
            rx = x + i;
            ry = y + j;
            
            if rx < 1 || ry < 1 || rx > M-15 || ry > N-15
               continue 
            end 
            
            cur_SAD = SAD(Target, Reference, x, y, rx, ry);
            
            if cur_SAD < min_SAD
                min_SAD = cur_SAD;
                min_x = rx;
                min_y = ry;
                min_delta = (rx-x)^2 + (ry-y)^2;
                
            elseif cur_SAD == min_SAD
                dup_count = dup_count + 1;
                cur_delta = (rx-x)^2 + (ry-y)^2;
                if cur_delta < min_delta
                    over_count = over_count + 1;
                    min_x = rx;
                    min_y = ry;
                    min_delta = cur_delta;
                end 
            end   
          
        end
    end
    
    if min_SAD < threshold
        Flag = 1;
        MotionVector(1, 1) = min_x - x;
        MotionVector(1, 2) = min_y - y;
        Prediction = Reference(min_x:min_x+15, min_y:min_y+15);
    end
    
    