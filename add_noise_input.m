function add_noise_input(W,b,a,p,t)
% p = [0,1,1,1,0,1,0,0,0,1,1,0,0,0,1,1,0,0,0,1,1,0,0,0,1,0,1,1,1,0; %0
%     0,1,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0; %1
%     1,1,1,0,0,0,0,0,1,0,0,0,0,1,0,0,1,1,0,0,0,1,0,0,0,0,1,1,1,1]; %2
% t = [1,0,0; %0
%     0,1,0; %1
%     0,0,1]; %2

correct = 0;
for h = 1:length(t)
    for i = 0:4:8
        for j = 1:10
            for k = 1:length(W)
                if (k == 1)
                    a{k} = W{k}*addNoise(p(h,:),i)'+b{k};
                else
                    a{k} = W{k}*addNoise(a{k-1}',i)'+b{k};
                end
            end
            [m, i1] = max(a{end});
            [m2, i2] = max(t(:,h));
            if (i1 == i2)
                correct = correct+1;
            end
        end
    end
end

disp (correct/90);

% outputs = cell(input_size, 1);
% match_counter = 0;
% tries = 0;
% 
% %for loop to go through all the layers of neurons
% for trial = 1:10
%     %add the pixel to the desired input and change it with the pixel
%     for inp = 1:input_size
%         new_noisy = addNoise(p(inp,:), pix);
%         %calculate the output from using the changed input
%         for j = 1:total_layers
%             if (j == 1)
%                 a{j} = (W{1} * new_noisy.' + b{1});
%             elseif (j == total_layers)
%                 a{j} = (W{2} * a{j-1} + b{2});
%             else
%                 a{j} = (W{1} * a{j-1} + b{1});
%             end
%         end
%         outputs{inp} = a{total_layers};
%         if (outputs{inp} == t(inp,:).')
%             match_counter = match_counter + 1;
%         end
%         tries = tries + 1;
%     end
% end
% disp(tries)
% disp(match_counter)
% error_percentage = ((tries - match_counter) / tries) / 100;
end