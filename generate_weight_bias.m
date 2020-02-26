function [W,b] = generate_weight_bias(row,col)
W = randn(row, col)*sqrt(2)/(col*row);
b = randn(row, 1)*sqrt(2)/(col*row);
end
