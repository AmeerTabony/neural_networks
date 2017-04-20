function [ network ] = trainNetwork( trainingData, trainingOutputs, layerSizes, trainingOpts )
%TRAINNETWORK trains a network on the trainingData
%   trains a neural net with backpropagation on the input data
%   trainingOutputs is the expected outputs to the training data
%   layerSizes is an array of sizes for the layers in the neural network
%   trainingOpts has the training options used to train the NN 
%   (learningRate(0-1), numOfEpochs(int), learningDecreaseRate(0-1), learningDropRate(int))
%   returns the trained network
    
    assert (size(trainingData,1) == size(trainingOutputs,1))
    
    network = initNetwork(layerSizes);
    for j=1:trainingOpts.numOfEpochs
        trainingError = 0;
        for i=1:size(trainingData,1)
            network = feedForward(network, trainingData(i,:));
            network = updateWeights(network, trainingOutputs(i,:),trainingOpts.learningRate);
            
            rating = predict(network);
            expectedRating = find(trainingOutputs(i,:)==max(trainingOutputs(i,:)));
            if(expectedRating~=rating)
                trainingError = trainingError +1;
            end
        end
        trainingError = floor(1000*(trainingError/size(trainingOutputs,1)))/10.0;
        logstr = strcat('epoch num: ',num2str(j),' training error is: ',num2str(trainingError) );
        logstr = strcat(logstr,'%%  learning rate: ',num2str(trainingOpts.learningRate));
        %sprintf(logstr)
        if j~=0 && mod(j,trainingOpts.learningDropRate) ==0
            trainingOpts.learningRate = trainingOpts.learningRate*trainingOpts.learningDecreaseRate;
        end
        
    end

end





function [network] = initNetwork(layerSizes)
% INITNETWORK creates a network
% creates network and initilizes the weights and biases
% the first layer is the input size, the last layer is the output size
% returns network

    % needs to have the size of input and output layers
    assert (exist('layerSizes', 'var') & size(layerSizes,2)>1) 
    
    network.layers = {};
    numberOfLayers = size(layerSizes,2);
    
    %% init layers and weights/biases
    for i=2:numberOfLayers
        numOfNeurons = layerSizes(1,i);
        prevNumOfNeurons = layerSizes(1,i-1);
        % according to http://cs231n.github.io/neural-networks-2/#init
        % its better to normalize the weights for better convergence.
        network.layers(i).weights = rand(prevNumOfNeurons,numOfNeurons);%*sqrt(2.0/numOfNeurons);
        network.layers(i).bias = zeros(1,numOfNeurons);
    end
    
    
end

function [network] = updateWeights(network, expectedOutputs, learningRate)
% UPDATEWEIGHTS   updates the network's weights
% update the weights according to the outputs and expected outputs, with
% given learning rate.

    % (t-y)*f'(inp)
    layerOutputs = network.layers(end).outputs;
    deltaLast = (expectedOutputs - layerOutputs).* (layerOutputs.*(1-layerOutputs));
    deltaW = (learningRate*deltaLast'*network.layers(end-1).outputs)';
    prevWeightsOfUpperLayer = network.layers(end).weights;
    network.layers(end).weights = prevWeightsOfUpperLayer + deltaW;
    network.layers(end).bias = network.layers(end).bias + (learningRate*deltaLast);
    
    if (size(network.layers,2)>2) 
        for i=size(network.layers,2)-1:2
            layerOutputs = network.layers(i).outputs;
            delta = (deltaLast*(prevWeightsOfUpperLayer)').*(layerOutputs.*(1-layerOutputs));
            
            deltaW = (learningRate*delta'*network.layers(i-1).outputs)';
            
            prevWeightsOfUpperLayer = network.layers(i).weights;
            network.layers(i).weights = prevWeightsOfUpperLayer + deltaW;
            network.layers(i).bias = network.layers(i).bias + (learningRate*delta);
            
            deltaLast = delta;
        end
    end
    
end

