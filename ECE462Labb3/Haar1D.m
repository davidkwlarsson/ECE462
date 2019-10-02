function transform = Haar1D(A)
N = length(A);
transform = zeros(N,1);
for i = 0:(N/2-1)
    transform(i+1)=(A(2*i+1)+A(2*i+2))/sqrt(2);
    transform((i+1)+N/2) = (A(2*i+1)-A(2*i+2))/sqrt(2);
end