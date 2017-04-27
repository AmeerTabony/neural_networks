FOLDS = 4;
load('shuffledLetters2.mat')

if ~exist('shuffledData', 'var')
    shuffledData = loopFolders();
end

% paramsToTest =[30,0.9,120,8,0.9];72
% paramsToTest =[paramsToTest;40,0.9,150,10,0.9];70
% paramsToTest =[paramsToTest;16,0.9,120,10,0.9];69
% paramsToTest =[paramsToTest;128,0.9,100,8,0.9]; %0 187s 88.2te
% paramsToTest =[30,0.9,200,10,0.9]; % 75.5 198s 4.6te
% paramsToTest =[paramsToTest;30,0.9,200,12,0.9]; %72.1 197s 8.7te
% paramsToTest =[paramsToTest;30,0.9,200,20,0.9]; % 71 197s 8.5te
% paramsToTest =[paramsToTest;30,0.9,200,12,0.99]; % 72.5 297s 7.9te
% paramsToTest =[30,0.9,200,8,0.9];% 72.5
% paramsToTest =[paramsToTest;30,0.9,200,10,0.8];% 71.3
% paramsToTest =[paramsToTest;30,0.9,160,10,0.7]; % 70
%paramsToTest =[16,0.9,70,8,0.9];
% paramsToTest =[paramsToTest;12,0.9,140,12,0.7];
paramsToTest =[10,0.9,100,10,0.7];
paramsToTest =[paramsToTest;10,0.9,50,4,0.7];
paramsToTest =[paramsToTest;10,0.9,70,4,0.8];
paramsToTest =[paramsToTest;10,0.7,80,8,0.9];
numOfRows = size(paramsToTest,1);
for paramTest=1:numOfRows
    avgSR = [];
    avgTE =0;
    tic
    path = '/Users/hilldi/Desktop/uni/Neuro computations/hw1/hw1/part2';
    for fold=1:FOLDS
         diary(strcat(path,'/myTextLog4.txt'));

        [train,test] = splitData(shuffledData,FOLDS,fold);
        train(:,2:end) = normr(train(:,2:end)); 
        test(:,2:end) = normr(test(:,2:end));

        trainingData = train(:,2:end);
        testingData = test(:,2:end);

        ouputSize = 8;
        trainOutput = formatOutput(train(:,1),ouputSize);
        testOutput = formatOutput(test(:,1),ouputSize);

        layerSizes = [16*16,ouputSize];
        % 0.99,200,0.9,19 te27 sr56%
        % 50 hidden was NOT good
        % 20 70%
        trainingOpts.learningRate = paramsToTest(paramTest,2) ;
        trainingOpts.numOfEpochs = paramsToTest(paramTest,3);
        trainingOpts.learningDropRate = paramsToTest(paramTest,4);
        trainingOpts.learningDecreaseRate = paramsToTest(paramTest,5);

        [network, trainingError] = trainNetwork( trainingData, trainOutput, layerSizes, trainingOpts );
        toc


        sr = testNetwork(network, testingData, testOutput) ;

        logstr = strcat('Fold num: ',num2str(fold),' success rate: ',num2str(sr),'%%');
        sprintf(logstr)
        trainingError

        avgSR = [avgSR ,sr];
        avgTE = avgTE + trainingError;
         diary('off');
    end
    logstr = strcat('END of all validations. average success rate: ',num2str(mean(avgSR)),'%%');
    logstr = strcat(logstr,'\nstd:', num2str(std(avgSR)),'\naverage training error: ' ,num2str(avgTE/FOLDS));
    sprintf(logstr)
end

                   

% diary('off');