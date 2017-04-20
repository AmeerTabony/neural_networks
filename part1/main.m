

FOLDS = 10;
path = '/Users/hilldi/Documents/MATLAB/Neuro computations/hw1';
diary(strcat(path,'/myTextLog6.txt'));
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
for layerSize=4:2:20
    epocStartNum = 9;
    if layerSize == 4
        epocStartNum =12;
    end
    for numOfEpochs=epocStartNum:15
        lrStartNum =2;
        if layerSize == 4
            lrStartNum =4;
        end
        for lr=lrStartNum:4
            for ldr=2:4
                for dropRate =2:2:10
                    avgSR = 0;
                    for fold=1:1
                        diary(strcat(path,'/myTextLog4.txt'));
                        tic
%                         [train,test] = splitData(shuffledWines,FOLDS,fold);
%                         train(:,1:end-1) = normr(train(:,1:end-1)); 
%                         test(:,1:end-1) = normr(test(:,1:end-1));
% 
%                         trainOutput = formatOutput(train(:,end));
%                         ouputSize = size(trainOutput,2);

                        layerSizes = [12,5+layerSize,ouputSize]; % assuming only 7 classes, unsure*

                        trainingOpts.learningRate = lr*0.2 + 0.1;
                        trainingOpts.numOfEpochs = numOfEpochs*10;
                        trainingOpts.learningDecreaseRate = ldr*0.2+0.1;
                        trainingOpts.learningDropRate = dropRate*2;

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