function reverse = LRHaar2D(A,L)
[n,m,~] = size(A);
reverse = A;
% A_temp = A;
for i = L:-1:1
    D = 2^(i-1);
    reverse(1:(n/D),1:(m/D)) = RHaar2D(reverse(1:(n/D),1:(m/D)));
%     A_temp = reverse(1:n/(2^(i-1)),1:m/(2^(i-1)));
end
