function reverse = RHaar1D(A)
N = length(A);
reverse = zeros(N,1);
for i=0:(N/2)-1
    reverse(2*i+1) = (A(i+1) + A((i+1)+N/2))/sqrt(2);
    reverse(2*i+2) = (A(i+1) - A((i+1)+N/2))/sqrt(2);
end
