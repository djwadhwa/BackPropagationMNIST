function[error_percentage] = add_noise_input(p, pix, t, L, s, alpha, iterations)
%     p = [0,1,1,1,0,1,0,0,0,1,1,0,0,0,1,1,0,0,0,1,1,0,0,0,1,0,1,1,1,0; %0
%      0,1,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0; %1
%     1,1,1,0,0,0,0,0,1,0,0,0,0,1,0,0,1,1,0,0,0,1,0,0,0,0,1,1,1,1]; %2 
%     t = [1,0,0; %0
%     0,1,0; %1
%     0,0,1]; %2

    %variables to count the wrong outputs
    input = p;
    input_size = size(p,1);
    [W,b] = backprop(p, t, L, s, alpha, iterations);
    total_layers = L+1;
    a = cell(total_layers, 1);
    outputs = cell(input_size, 1);
    match_counter = 0;
    tries = 0;
    
    %for loop to go through all the layers of neurons   
    for trial = 1:10
        %add the pixel to the desired input and change it with the pixel
        for inp = 1:input_size
            new_noisy = addNoise(input(inp,:), pix);
            %calculate the output from using the changed input
            for j = 1:total_layers
                if (j == 1)
                    a{j} = (W{1} * new_noisy.' + b{1});
                elseif (j == total_layers)
                    a{j} = (W{2} * a{j-1} + b{2});
                else
                    a{j} = (W{1} * a{j-1} + b{1});
                end
            end
            outputs{inp} = a{total_layers};
            if (outputs{inp} == t(inp,:).')
                match_counter = match_counter + 1;
            end
            tries = tries + 1;
        end
    end
    disp(tries)
    disp(match_counter)
    error_percentage = ((tries - match_counter) / tries) / 100;        
end