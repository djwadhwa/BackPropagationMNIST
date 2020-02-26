function error = noise_error(W,b,p,t)

a = cell(length(W),1);
error = zeros (3,length(t));

for i = 1:3
    for j = length(t)
        correct = 0;
        for k = 1:10
            for h = 1:length(W) %calculation of a
                if (h == 1)
                    noised_image = addNoise(p(:,j),i*4-4);
                    a{h} = logsig(W{h}*noised_image+b{h});
                else
                    a{h} = logsig(W{h}*a{h-1}+b{h});
                end
            end
            [m,ind] = max(a{end});
            if (ind == t(j)+1)
                correct = correct +1;
            end
        end
        error(i,j) = (10-correct)*100/10;
    end
end
end