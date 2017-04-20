function rating = predict(network)
    outputOfNetwork = network.layers(end).outputs;
    rating = find(outputOfNetwork==max(outputOfNetwork));
    if(size(rating,2)>1)  % if more than 1 are equally likely, take the first
        rating = rating(1);
    end
end


