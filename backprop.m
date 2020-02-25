function [W,b,mse] = backprop(p, t, L, s, alpha, epochs, output)
% p = input, t = target, L = number of layers, s = number of neurons
%alpha = learning_rate, epochs = # of epochs to propagate,
%output = number_of_neurons in the output layer

input_dimensions = size(p);
input_length = input_dimensions(1);
input_samples = input_dimensions(2);
% store all matricies
W = cell(L,1); %weight
b = cell(L,1); %bias
n = cell(L,1); %output before transfer function
a = cell(L,1); %output for neuron
S = cell(L,1); %sensitivity

%generate Weights and biases
for m = 1:L
    if (m == 1)
        %calculate the weight, bias, n for first hidden layer
        [W{m},b{m}] = generate_weight_bias(s,input_length);
    elseif (m == L)
        % calculate the weight, bias, n for the last hidden layer
        [W{m},b{m}] = generate_weight_bias(output,s);
    else
        %calculate the weights, and biases between hidden layers
        [W{m},b{m}] = generate_weight_bias(s,s);
    end
end


%calculate and propagate sensitivites backwards
x = 1;
mse = zeros(epochs-1);
while x < epochs
    
    %feedforward
    label = zeros(output,1);
    for i = 1:input_samples
        for m = 1:L
            if (m == 1)
                n{m} = W{m}*p(:,i)+b{m};
            else
                n{m} = W{m}*a{m-1}+b{m};
            end
            a{m} = logsig(n{m}); %calculate the output for each layer
        end
        label(t(i)+1) = 1;
        
        %propagate sensitivities backwards
        for m = L:-1:1
            diff_sig = diag((1-a{m}).*a{m});
            if (m == L)
                S{m} = -2*diff_sig*(label-a{m});
%                 S{m} = -2*diff_sig*(t(:,i)-a{m});
            else
                S{m} = diff_sig*W{m+1}'*S{m+1};
            end
        end
        
        label (t(i)+1) = 0;
        %update weights and biases
        for m = 1:L
            if (m == 1)
                W{m} = W{m}-alpha*S{m}*p(:,i)';
            else
                W{m} = W{m}-alpha*S{m}*a{m-1}';
            end
            b{m} = b{m}-alpha*S{m};
        end
    end
    label (t(i)+1) = 1;
    disp(x);
        mse(x) = sum((label-a{L}).^2)/output;
%     mse(x) = sum((t(:,i)-a{total_layers}).^2);
    x=x+1;
end
end
