function plane = extract_plane(in,b)
plane = in/(2^b);
plane = floor(plane);
plane = mod(plane,2);
end