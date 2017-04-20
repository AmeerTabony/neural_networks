

FOLDS = 10;
path = '/Users/hilldi/Documents/MATLAB/Neuro computations/hw1';
%% get wine data
shuffledWines = getShuffledWines();
%%
avgSR = 0;
tic

[train,test] = splitData(shuffledWines,FOLDS,1);
train(:,1:end-1) = normr(train(:,1:end-1)); 
test(:,1:end-1) = normr(test(:,1:end-1));

trainOutput = formatOutput(train(:,end));
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

                        network = trainNetwork( train(:,1:end-1), trainOutput, layerSizes, trainingOpts );
                        toc

                        testOutput = formatOutput(test(:,end));
                        sr = testNetwork(network, test(:,1:end-1), testOutput) ;

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