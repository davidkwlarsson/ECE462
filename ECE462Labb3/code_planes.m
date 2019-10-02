function out = code_planes(in,planes)

in = double(in);

% extract and remove signs, to be added back later
sign_plane = sign(in);
in = abs(in);

% get MSB of each coefficient
b_msb = floor(log2(in));

% get highest MSB (starting bit-plane)
b0 = max(b_msb(:));

out = zeros(size(in));

% loop through each bit-plane starting at the highest MSB
for ii=1:planes
%current bit-plane
b = b0-ii+1;

% create a mask of all coefficient locations which have
% previously been found significant
affected_planes = b_msb>b;

% extract the current bit-plane from all coefficients
plane = extract_plane(in,b);

% create a mask of all coefficient locations which have their MSB
% in the current bit-plane
msbs = b==b_msb;

% take the current bit-plane and remove all ones which represent MSBs
% for their respective coefficients (this is used for refinement of
% coefficients previously found significant).
non_msb_plane = plane;
non_msb_plane(msbs==1) = 0;

% take the previous approximation and:
% 1. set value to 1.5*2^b if coefficient is found significant
% in current bit-plane ("msbs" used as mask for this)
% 2. Use (2*non_msb_plane-1) to turn refinement bit 0 into -1, and
% and refinement bit 1 into +1, multiply by 0.5*2^b to refine by
% by appropriate amount (+/- 0.5*2^b) and mask by "affected_planes"
% so that only coefficients previously found significant are refined
out(msbs) = 1.5*(2^b);
out(affected_planes) = out(affected_planes) + (2*non_msb_plane(affected_planes)-1)*0.5*(2^b);

end

% apply signs back
out = out.*sign_plane;