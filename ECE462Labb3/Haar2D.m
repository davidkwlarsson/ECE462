function transform = Haar2D(A)
[n,m,~] = size(A);
transform = A;
for j = 1:m
  transform(:,j) = Haar1D(transform(:,j));
end
for i = 1:n
    transform(i,:) = Haar1D(transform(i,:));
end