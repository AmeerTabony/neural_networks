

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
    
    [train,test] = splitData(shuffledWines,FOLDS,fold);
    train(:,2:end) = normr(train(:,2:end)); 
    test(:,2:end) = normr(test(:,2:end));
    
    trainingData = train(:,2:end);
    testingData = test(:,2:end);
    
    ouputSize = 2;
    trainOutput = formatOutput(train(:,1),ouputSize);
    testOutput = formatOutput(test(:,1),ouputSize);

    layerSizes = [12,7,ouputSize];
    % 0.9 100 0.9 8 and hidden layer of 4 gave 90+ accuracy
    % 7 hidden 90%
    %  24 hidden 92.66%
    trainingOpts.learningRate = 0.9;
    trainingOpts.numOfEpochs = 80;
    trainingOpts.learningDecreaseRate = 0.9;
    trainingOpts.learningDropRate = 8;

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
                   

% diary('off');