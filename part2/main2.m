FOLDS = 4;
load('shuffledLetters2.mat')
if ~exist('shuffledData', 'var')
    shuffledData = loopFolders();
end
avgSR = [];
avgTE=0;
tic
for fold=1:FOLDS    
    [train,test] = splitData(shuffledData,FOLDS,fold);
    train(:,2:end) = normr(train(:,2:end)); 
    test(:,2:end) = normr(test(:,2:end));
    
    trainingData = train(:,2:end);
    testingData = test(:,2:end);
    
    ouputSize = 8;
    trainOutput = formatOutput(train(:,1),ouputSize);
    testOutput = formatOutput(test(:,1),ouputSize);

    layerSizes = [16*16,30,ouputSize];
    trainingOpts.learningRate = 0.9;
    trainingOpts.numOfEpochs = 120;
    trainingOpts.learningDecreaseRate = 0.9;
    trainingOpts.learningDropRate = 12;

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
                   

