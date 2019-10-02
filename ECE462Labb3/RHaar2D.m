function reverse = RHaar2D(A)
[n,m,~] = size(A);
reverse = A;
for i = 1:n
    reverse(i,:) = RHaar1D(reverse(i,:));
end
for j = 1:m
    reverse(:,j) = RHaar1D(reverse(:,j));
end
