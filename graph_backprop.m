function graph_backprop(p,t)
epochs = 45;
[W,b,a,mse] = backprop(p,t,2,200,0.02,epochs,10);

plot1 = plot([1:epochs-1],mse(1:epochs-1));
xlabel('epochs')
ylabel('Mean Squared Error')
title ('MSE of backprop with 3 digits')

logsig(W{2}*logsig(W{1}*p(:,1)+b{1})+b{2})
%add_noise_input(W,b,p,t);
end