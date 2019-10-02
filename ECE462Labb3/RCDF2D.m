function reverse = RCDF2D(A)
[n,m,~] = size(A);
reverse = A;
for i = 1:n
    reverse(i,:) = rev_cdf(reverse(i,:));
end
for j = 1:m
    reverse(:,j) = rev_cdf(reverse(:,j));
end
