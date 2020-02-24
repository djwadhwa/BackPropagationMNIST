function graph_backprop(p,t)
figure;
iterations = 350;
[W,b,error] = backprop(p,t,1,20,0.1,iterations);
plot1 = plot([1:iterations],error(1:iterations));
xlabel('# of iterations')
ylabel('Mean Squared Error')
title ('MSE of backprop with 3 digits')

end