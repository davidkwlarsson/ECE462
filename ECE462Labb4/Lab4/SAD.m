function sad = SAD(T, R, x, y, i, j) 
    sad = 0;
    for k = 0:15
        for l = 0:15
            tx = x+k;
            ty = y+l;
            rx = i+k;
            ry = j+l;
          
            sad = sad + abs( T(tx, ty) - R(rx, ry)); 
        end
    end
    