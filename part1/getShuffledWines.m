function [ shuffledWines ] = getShuffledWines( )
%GETSHUFFLEDWINES loads wines, combines and suffles then in one matrix
redWines = getWineData('winequality-red.csv');
whiteWines = getWineData('winequality-white.csv');
meanTable = getDataMean('table.csv');

redWines(:,1:end-1) = redWines(:,1:end-1)./(meanTable(:,1)');
whiteWines(:,1:end-1) = whiteWines(:,1:end-1)./(meanTable(:,2)');

%% add a column with extra information, wine color
redWines = [zeros(size(redWines,1),1),redWines];
whiteWines = [ones(size(whiteWines,1),1),whiteWines];
%%

allWines = [redWines;whiteWines];
shuffledWines = allWines(randperm(size(allWines,1)),:); % shuffle wines together 

end

