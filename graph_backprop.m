function graph_backprop()

p = [0,1,1,1,0,1,0,0,0,1,1,0,0,0,1,1,0,0,0,1,1,0,0,0,1,0,1,1,1,0; %0
    0,1,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0; %1
    1,1,1,0,0,0,0,0,1,0,0,0,0,1,0,0,1,1,0,0,0,1,0,0,0,0,1,1,1,1]'; %2

% t is read as t0=[1,0,0], t1=[0,1,0], t2 = [0,0,1] by the backprop
% alogrithm, however it is stated like this for the sake of brevity
t = [0;1;2];

% number of iterations for three digits
epochs = 15000;
output = 3;
layers = 4;
neurons = 100;
learning_rate = 0.08;
[W,b,mse] = backprop(p,t,layers,neurons,learning_rate,epochs,output);
error = noise_error(W,b,p,t);
figure;
plot1 = plot([1:epochs],mse);
xlabel('epochs');
ylabel('Mean Squared Error');
name = ['MSE with ' num2str(output) ' digits, ' num2str(layers) ' layers and alpha of ' num2str(learning_rate)];
title (name);
figure;
plot1 = plot([0,4,8],error);
xlabel('noise (pixels)');
ylabel('error (%)');
title ('Error in classification as noise increases per digit');
legend([plot1],["digit 0","digit 1","digit 2"]);

p = loadMNISTImages("train-images.idx3-ubyte");
t = loadMNISTLabels("train-labels.idx1-ubyte");

test_inputs = loadMNISTImages("t10k-images.idx3-ubyte");
test_labels = loadMNISTLabels("t10k-labels.idx1-ubyte");

progress = zeros(4,1);
counter = 1;
for j = [5,10,20,40]
    epochs = j;
    output = 10;
    layers = 2;
    neurons = 100;
    learning_rate = 0.06;
    [W,b,mse2] = backprop(p,t,layers,neurons,learning_rate,epochs,output);
    
    figure;
    plot1 = plot([1:epochs],mse2);
    xlabel('epochs');
    ylabel('Mean Squared Error');
    name = ['MSE with ' num2str(output) ' digits, ' num2str(layers) ' layers and alpha of ' num2str(learning_rate)];
    title (name);
    
    x = 0;
    for i = 1:length(test_inputs)
        [m,ind] = max(logsig(W{2}*logsig(W{1}*test_inputs(:,i)+b{1})+b{2}));
        if(test_labels(i)+1 == ind)
            x = x+1;
        end
    end
    progress(counter) = x*100/length(test_inputs);
    counter=counter+1;
end

figure;
plot1 = plot([5,10,20,40],progress);
xlabel('epochs');
ylabel('percent correct (%)');
title ('Test Set classification accuracy for 10, 20, 40, and 60 epcohs');

end