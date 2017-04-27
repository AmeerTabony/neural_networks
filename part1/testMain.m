

FOLDS = 10;
path = '/Users/hilldi/Documents/MATLAB/Neuro computations/hw1';
% diary(strcat(path,'/myTextLog6.txt'));
%% get wine data
shuffledWines = getShuffledWines();
%%
avgSR = 0;
tic
paramsToTest =[4,0.9,100,8,0.9];
paramsToTest =[paramsToTest;24,0.9,100,8,0.9];
% paramsToTest =[paramsToTest;15,0.6,60,3,0.7];
numOfRows = size(paramsToTest,1);
for paramTest=1:numOfRows
    for numOfEpochs=1:1

        for lr=2:-1:2
            for ldr=1:-1:1
                for dropRate =2:-2:2
                    avgSR = 0;
                    avgTE = 0;
                    tic
                    for fold=1:10
                    %     diary(strcat(path,'/myTextLog4.txt'));

                        [train,test] = splitData(shuffledWines,FOLDS,fold);
                        train(:,2:end) = normr(train(:,2:end)); 
                        test(:,2:end) = normr(test(:,2:end));

                        trainingData = train(:,2:end);
                        testingData = test(:,2:end);

                        trainOutput = formatOutput(train(:,1));
                        testOutput = formatOutput(test(:,1));
                        ouputSize = size(trainOutput,2);

                        layerSizes = [12,paramsToTest(paramTest,1),ouputSize];
                        % 0.9 100 0.9 8 and hidden layer of 4 gave 90+ accuracy
                        % 7 hidden 90%
                        %  24 hidden 92.66%
                        trainingOpts.learningRate = paramsToTest(paramTest,2) ;
                        trainingOpts.numOfEpochs = paramsToTest(paramTest,3);
                        trainingOpts.learningDropRate = paramsToTest(paramTest,4);
                        trainingOpts.learningDecreaseRate = paramsToTest(paramTest,5);
                        

                        [network, trainingError] = trainNetwork( trainingData, trainOutput, layerSizes, trainingOpts );
                        toc


                        sr = testNetwork(network, testingData, testOutput) ;

                        logstr = strcat('Fold num: ',num2str(fold),' success rate: ',num2str(sr),'%%');
                        sprintf(logstr)
                        

                        avgSR = avgSR + sr;
                        avgTE = avgTE + trainingError;
                    %     diary('off');
                     end
                        logstr = strcat('END of all validations. average success rate: ',num2str(avgSR/FOLDS),'%%');
                        logstr = strcat(logstr, '\ntraining error: ',num2str(avgTE/FOLDS),'%%');
                         sprintf(logstr)
                         trainingOpts
                         paramsToTest(paramTest,1)
                end
            end
        end
    end
end
% diary('off');