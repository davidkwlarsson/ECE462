function transform = LCDF2D(A,L)
[n,m,~] = size(A);
transform = A;
A_temp = A;
for i = 1:L
    transform(1:n/(2^(i-1)),1:m/(2^(i-1))) = CDF2D(A_temp);
    A_temp = transform(1:n/(2^i),1:m/(2^i));
end
