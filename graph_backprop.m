function graph_backprop(p,t)
epochs = 400;
[W,b,a,mse] = backprop(p,t,1,40,0.1,epochs,10);

plot1 = plot([1:epochs],mse(1:epochs));
xlabel('epochs')
ylabel('Mean Squared Error')
title ('MSE of backprop with 3 digits')
%add_noise_input(W,b,p,t);
end