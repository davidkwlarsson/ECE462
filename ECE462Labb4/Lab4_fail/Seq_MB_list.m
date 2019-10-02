function mb_list = Seq_MB_list(coords)
N = 16;
mb_list = zeros(N*N,2);
x_0,y_0 = coords;
for i = 0:N-1
    for j = 1:N
        mb_list(i*N+j,:) =  [x_0-N + i + 1,y_0-N + j];
    end
end

end