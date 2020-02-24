function [W,b,a] = backprop(p,t, L, s)
% p = input, t = target, L = number of hidden layers, s = number of neurons

% counting the number of input and make a n array of n inputs
input_counter = size(p,1);
outputs = cell(input_counter,1);

% store all matricies
total_layers = (L+1); %hidden layers + output
W = cell(total_layers,1); %weight
b = cell(total_layers,1); %bias
n = cell(total_layers,1); %output before transfer function
a = cell(total_layers,1); %output for neuron
S = cell(total_layers,1); %sensitivity

alpha = 0.05; %learning_rate

%generate Weights and biases
for m = 1:total_layers
    if (m == 1)
        %calculate the weight, bias, n for first hidden layer
        W{m} = rand(s,length(p))*.1;
        b{m} = rand (s,1);
    elseif (m == total_layers)
        % calculate the weight, bias, n for the last hidden layer
        W{m} = rand (3, s)*.1;
        b{m} = rand (3, 1);
    else
        %calculate the weights, and biases between hidden layers
        W{m} = rand (s)*.1;
        b{m} = rand (s,1);
    end
end


%calculate and propagate sensitivites backwards
x = 0;

while x<1000
    %feedforward
    for i = 1:length(t)
        
        for m = 1:total_layers
            if (m == 1)
                n{m} = W{m}*p(i,:)'+b{m};
            else
                n{m} = W{m}*a{m-1}+b{m};
            end
            a{m} = logsig(n{m}); %calculate the output for each layer
            
            %show the last output for all digits in the input
            if x == 999 && m == total_layers
                outputs{i} = a{m}
                celldisp(outputs)
            end
        end
        
        %propagate sensitivities backwards
        for m = total_layers:-1:1
            diff_sig = diag((1-a{m}).*a{m});
            if (m == total_layers)
                S{m} = -2*diff_sig*(t(:,i)-a{m});
            else
                S{m} = diff_sig*W{m+1}'*S{m+1};
            end
        end
        
        %update weights and biases
        for m = 1:total_layers
            if (m == 1)
                W{m} = W{m}-alpha*S{m}*p(i,:);
            else
                W{m} = W{m}-alpha*S{m}*a{m-1}';
            end
            b{m} = b{m}-alpha*S{m};
        end
        
    end
    x=x+1;
end
end