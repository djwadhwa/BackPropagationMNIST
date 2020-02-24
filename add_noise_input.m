function[input] = add_noise_input(p, pixels)
    p = [0,1,1,1,0,1,0,0,0,1,1,0,0,0,1,1,0,0,0,1,1,0,0,0,1,0,1,1,1,0; %0
     0,1,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0; %1
    1,1,1,0,0,0,0,0,1,0,0,0,0,1,0,0,1,1,0,0,0,1,0,0,0,0,1,1,1,1]; %2 
    t = [1,0,0; %0
    0,1,0; %1
    0,0,1]; %2
    input = p;
    input_size = size(input,1);
    for i = 1:input_size
        add_noise = addNoise(input(i,:), 8)
        input(i,:) = add_noise;
    end
end