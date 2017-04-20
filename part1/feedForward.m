function [network] = feedForward(network, input)
% FEEDFORWARD, goes over the network with the input
% network.layers(i).outputs is updated occoding to the input
    network.layers(1).outputs = input;
    for i=2:size(network.layers,2)
        newInput = network.layers(i-1).outputs;
        network.layers(i).outputs = getLayerOutputs(network.layers(i),newInput);
    end
end


function [outputs] = getLayerOutputs(layer,inputs)
% GETLAYEROUTPUTS calculates the output of a layer with the given input
    
    assert ( size(inputs,1)==1 & size(inputs,2)==size(layer.weights,1) )
    
    temp = inputs*layer.weights + layer.bias;
    outputs = 1.0./(1.0+exp(-temp));  % [1,n] mat, activation
    
end

