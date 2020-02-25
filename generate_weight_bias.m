function [W,b] = generate_weight_bias(row,col)
W = randn(row, col)*.1;%*sqrt(2/col*row);
b = randn(row, 1)*.1; %*sqrt(2/col*row);
end
