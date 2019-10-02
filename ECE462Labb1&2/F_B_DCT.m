function [F,B] = F_B_DCT(N)
%Returns the two transformation matrices for DCT
F = zeros(N,N);
for j = 0:N-1
        F(1,j+1) = sqrt(1/N)*cos((2*j+1)*0*pi/(2*N));
end
for i = 1:N-1
    for j = 0:N-1
        F(i+1,j+1) = sqrt(2/N)*cos((2*j+1)*i*pi/(2*N));
    end
end
B = F';
end
