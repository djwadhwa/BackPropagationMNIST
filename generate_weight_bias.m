function [W,b] = generate_weight_bias(row,col)
W = randn(row,col)*.01;
b = rand(row, 1);
end
