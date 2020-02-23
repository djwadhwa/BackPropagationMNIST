function [W,b,a] = backprop(p,t, L, s)
% p = input, t = target, L = number of hidden layers, s = number of neurons

% store all matricies
total_layers = (L+1); %hidden layers + output
W = cell(total_layers,1); %weight
b = cell (total_layers,1); %bias
n = cell(total_layers,1); %output before transfer function
a = cell(total_layers,1); %output for neuron
S = cell(total_layers,1); %sensitivity

alpha = 0.06; %learning_rate

%feedforward
for m = 1:total_layers
    if (m == 1)
        %calculate the weight, bias, n for first hidden layer
        W{m} = rand(s,length(p));
        b{m} = rand (s,1);
        n{m} = W{m}*p(1,:)'+b{m};
    elseif (m == total_layers)
        % calculate the weight, bias, n for the last hidden layer
        %       size_of_input = size(p);
        W{m} = rand (3, s);
        b{m} = rand (3, 1);
        n{m} = W{m}*a{m-1}+b{m};
    else
        %calculate the weights, and biases between hidden layers
        W{m} = rand (s);
        b{m} = rand (s,1);
        n{m} = W{m}*a{m-1}+b{m};
    end
    a{m} = logsig(n{m}); %calculate the output for each layer
end


size_of_input = size(p);
%calculate and propagate sensitivites backwards

x = 0;
while x < 1000
    for i = 1:size_of_input(1)
        for m = total_layers:-1:1
            diff_sig = diag((1-a{m}).*a{m});
            if (m == total_layers)
                S{m} = -2*diff_sig*(t(i,:)'-a{m});
            else
                S{m} = diff_sig*W{m+1}'*S{m+1};
            end
        end
        
        for m = 1:total_layers
            b{m} = b{m}-alpha*S{m};
            if (m == 1)
                W{m} = W{m}-alpha*S{m}*p(i);
                n{m} = W{m}*p(i,:)'+b{m};
            elseif (m == total_layers)
                W{m} = W{m}-alpha*S{m}*a{m-1}';
                n{m} = W{m}*a{m-1}+b{m};
            else
                W{m} = W{m}-alpha*S{m}*a{m-1}';
                n{m} = W{m}*a{m-1}+b{m};
            end
            a{m} = logsig(n{m}); %calculate the output for each layer
        end
    end
    x=x+1;
end
end