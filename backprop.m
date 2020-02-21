function a = backprop(p,t, L, s) %p = input, t = target, L = number of hidden layers, s = number of neurons

%store all matricies
total_layers = (L+1); %total number of layers excluding the input
W = cell(total_layers,1);
b = cell (total_layers,1);
n = cell(total_layers,1);
a = cell(total_layers,1);

%forward propagation
for i = 1:total_layers
    if (i == 1) 
        %calculate the weight, bias, n for hidden layer 1
        W{i} = rand(s,length(p));
        b{i} = rand (s,1);
        n{i} = W{i}*p'+b{i};
    elseif (i == total_layers) 
        % calculate the weight, bias, n for the last hidden layer  
        size_of_input = size(p);
        W{i} = rand (size_of_input(1), s);
        b{i} = rand (size_of_input(1), 1);
        n{i} = W{i}*a{i-1}+b{i};
    else
        %calculate the weights, and biases between hidden layers
        W{i} = rand (s);
        b{i} = rand (s,1);
        n{i} = W{i}*a{i-1}+b{i};
    end
    a{i} = logsig(n{i}); %calculate the output for each layer, each column is a row from p
end

end