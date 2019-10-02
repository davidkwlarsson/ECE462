function sad = SAD(T_MB,R_MB)
sad = 0;

for k = 1:16
    for l = 1:16
        sad = sad + abs(T_MB(k,l)-R_MB(k,l));
    end
end

end
        