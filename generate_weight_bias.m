function [W,b] = generate_weight_bias(row,col)
W = randn(row, col)*sqrt(2)/sqrt(row);
b = zeros(row, 1);
end
