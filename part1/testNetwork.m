function [ successRate ] = testNetwork(network, testData, outputs )
%TESTNETWORK tests the network
%   tests the network on testing data, and returns the success rate
    assert (size(testData,1)==size(outputs,1))

    dataSize = size(testData,1);
    success =0;
    for i=1:dataSize
        network = feedForward(network, testData(i,:));
        
        rating = predict(network);
        expectedRating = find(outputs(i,:)==max(outputs(i,:)));
        if(expectedRating==rating)
            success = success +1;
        end
        
    end
    successRate = floor(1000*(success/dataSize))/10.0;
end