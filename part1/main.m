

FOLDS = 10;
path = '/Users/hilldi/Documents/MATLAB/Neuro computations/hw1';
% diary(strcat(path,'/myTextLog6.txt'));
%% get wine data
shuffledWines = getShuffledWines();
%%
avgSR = 0;
tic

avgSR = 0;
for fold=1:10
%     diary(strcat(path,'/myTextLog4.txt'));
    tic
    
    [train,test] = splitData(shuffledWines,FOLDS,fold);
    train(:,2:end) = normr(train(:,2:end)); 
    test(:,2:end) = normr(test(:,2:end));
    
    trainingData = train(:,2:end);
    testingData = test(:,2:end);
    
    trainOutput = formatOutput(train(:,1));
    testOutput = formatOutput(test(:,1));
    ouputSize = size(trainOutput,2);

    layerSizes = [12,4,ouputSize]; % assuming only 7 classes, unsure*

    trainingOpts.learningRate = 0.9;
    trainingOpts.numOfEpochs = 80;
    trainingOpts.learningDecreaseRate = 0.9;
    trainingOpts.learningDropRate = 4;

    network = trainNetwork( trainingData, trainOutput, layerSizes, trainingOpts );
    toc

    
    sr = testNetwork(network, testingData, testOutput) ;

    logstr = strcat('Fold num: ',num2str(fold),' success rate: ',num2str(sr),'%%');
    sprintf(logstr)

    avgSR = avgSR + sr;
%     diary('off');
end
logstr = strcat('END of all validations. average success rate: ',num2str(avgSR/FOLDS),'%%');
 sprintf(logstr)
                   
toc

% diary('off');