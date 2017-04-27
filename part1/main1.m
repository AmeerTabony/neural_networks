function main1(netParams,layerSizes)

FOLDS = 10;
%% get wine data
shuffledWines = getShuffledWines();
%%
ouputSize = 2;
if ~(exist('netParams', 'var') && exist('layerSizes', 'var'))
    netParams = [0.8,30,4,0.7];
    layerSizes = [12,ouputSize];
end


avgSR = [];
tic
avgTE = 0;
for fold=1:10
    
    [train,test] = splitData(shuffledWines,FOLDS,fold);
    train(:,2:end) = normr(train(:,2:end)); 
    test(:,2:end) = normr(test(:,2:end));
    
    trainingData = train(:,2:end);
    testingData = test(:,2:end);
    
    trainOutput = formatOutput(train(:,1),ouputSize);
    testOutput = formatOutput(test(:,1),ouputSize);

    trainingOpts.learningRate = netParams(1);
    trainingOpts.numOfEpochs = netParams(2);
    trainingOpts.learningDropRate = netParams(3);
    trainingOpts.learningDecreaseRate = netParams(4);
    

    [network,trainingError] = trainNetwork( trainingData, trainOutput, layerSizes, trainingOpts );
    toc

    
    sr = testNetwork(network, testingData, testOutput) ;

    logstr = strcat('Fold num: ',num2str(fold),' success rate: ',num2str(sr),'%%');
    sprintf(logstr)

    avgSR = [avgSR ,sr];
    avgTE = avgTE + trainingError;
end
logstr = strcat('END of all validations. average success rate: ',num2str(mean(avgSR)),'%%');
logstr = strcat(logstr,'\nstd:', num2str(std(avgSR)),'\naverage training error: ' ,num2str(avgTE/FOLDS));
sprintf(logstr)
trainingOpts
                   

end