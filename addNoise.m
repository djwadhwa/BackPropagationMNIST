function pvec = addNoise(pvec, num)
% ADDNOISE Add noise to "binary" vecto
%   pvec pattern vector (-1 and 1)
%   num  number of elements to flip randomly

% Handle special case where there's no noise
if num == 0    
    return;
end

% first, generate a random permutation of all indices into pvec
inds = randperm(length(pvec));

% then, use the first n elements to flip pixels
pvec(inds(1:num)) = uint8(~pvec(inds(1:num)));