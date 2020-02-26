function noise_error(W,b,p,t,output)

a = cell(output,1);
error = zeros (3,10);


for i = 0:4:8 %noise
    for j = 1:10 %number of tests
        for
            for k = 1:length(W) %calculation of a
                if (k == 1)
                    a{k} = logsig(W{k}*addNoise(p(h,:),i)'+b{k});
                else
                    a{k} = logsig(W{k}*addNoise(a{k-1}',i)'+b{k});
                end
            end
            [m, i1] = max(a{end});
            [m2, i2] = max(t(:,h));
            if (i1 == i2)
                correct = correct+1;
            end
        end
    end

end
end