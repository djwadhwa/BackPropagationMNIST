function[input] = add_noise_input(p, pix, t)
%     p = [0,1,1,1,0,1,0,0,0,1,1,0,0,0,1,1,0,0,0,1,1,0,0,0,1,0,1,1,1,0; %0
%      0,1,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0; %1
%     1,1,1,0,0,0,0,0,1,0,0,0,0,1,0,0,1,1,0,0,0,1,0,0,0,0,1,1,1,1]; %2 
%     t = [1,0,0; %0
%     0,1,0; %1
%     0,0,1]; %2
    input = p;
    input_size = size(p,1);
    
    %change the pattern of each input with pix pixels
    for i = 1:input_size
        add_noise = addNoise(input(i,:), pix);
        input(i,:) = add_noise;
    end
    
    
end