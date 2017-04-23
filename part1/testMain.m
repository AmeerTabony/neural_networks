

FOLDS = 10;
path = '/Users/hilldi/Documents/MATLAB/Neuro computations/hw1';
%% get wine data
shuffledWines = getShuffledWines();
%%
avgSR = 0;
tic

[train,test] = splitData(shuffledWines,FOLDS,fold);
train(:,2:end) = normr(train(:,2:end)); 
test(:,2:end) = normr(test(:,2:end));

trainingData = train(:,2:end);
testingData = test(:,2:end);

trainOutput = formatOutput(train(:,1));
testOutput = formatOutput(test(:,1));
ouputSize = size(trainOutput,2);
toc
for layerSize=4:7
    
    for numOfEpochs=3:6

        for lr=4:-1:2
            for ldr=3:-1:1
                for dropRate =6:-2:2
                    avgSR = 0;
                    for fold=1:1
                        diary(strcat(path,'/myTextLog8.txt'));
                        tic

                        layerSizes = [12,5+layerSize,ouputSize]; % assuming only 7 classes, unsure*

                        trainingOpts.learningRate = lr*0.2 ;
                        trainingOpts.numOfEpochs = numOfEpochs*10;
                        trainingOpts.learningDecreaseRate = ldr*0.2+0.1;
                        trainingOpts.learningDropRate = dropRate;

                        network = trainNetwork( trainingData(:,1:end-1), trainOutput, layerSizes, trainingOpts );
                        toc

                        sr = testNetwork(network, testingData(:,1:end-1), testOutput) ;

                        logstr = strcat('Fold num: ',num2str(fold),' success rate: ',num2str(sr),'%%');
                        sprintf(logstr)
                        trainingOpts
                        layerSize

                        avgSR = avgSR + sr;
                        pause(3)
                        diary('off');
                    end
                    %logstr = strcat('END of all validations. average success rate: ',num2str(avgSR/FOLDS),'%%');
                   % sprintf(logstr)
                end
            end
        end
    end
end
toc

diary('off');