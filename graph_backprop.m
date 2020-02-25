function graph_backprop(p,t,test_input,test_label)
epochs = 40;
[W,b,mse] = backprop(p,t,2,60,0.06,epochs,10);

plot1 = plot([1:epochs-1],mse(1:epochs-1));
xlabel('epochs')
ylabel('Mean Squared Error')
title ('MSE of backprop with 10 digits')

x = 0;
for i = 1:length(test_input)
    [m,ind] = max(logsig(W{2}*logsig(W{1}*test_input(:,i)+b{1})+b{2}));
    if(test_label(i)+1 == ind)
        x = x+1;
    end
end

disp(x/length(test_input));
%add_noise_input(W,b,p,t);
end