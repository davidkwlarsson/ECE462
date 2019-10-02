function transform = CDF2D(A)
[n,m,~] = size(A);
transform = A;
for j = 1:m
  transform(:,j) = fwd_cdf(transform(:,j));
end
for i = 1:n
    transform(i,:) = fwd_cdf(transform(i,:));
end