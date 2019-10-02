function Iuv = basisIm_DCT(N,u,v)
Iuv = zeros(N);

for i = 0:N-1
    for j = 0:N-1
        Iuv(i+1,j+1) = cos((2*i+1)*u*pi/16) * cos((2*j+1)*v*pi/16);
    end
    
end