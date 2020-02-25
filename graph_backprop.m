function graph_backprop(p,t)
iterations = 1000;
[W,b,a,mse] = backprop(p,t,1,20,0.04,iterations);
plot1 = plot([1:iterations],mse(1:iterations));
xlabel('epochs')
ylabel('Mean Squared Error')
title ('MSE of backprop with 3 digits')
add_noise_input(W,b,a,p,t);
end