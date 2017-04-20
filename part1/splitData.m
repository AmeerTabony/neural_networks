function [ train,test ] = splitData( data,kFolds,foldNumber)
%SPLITDATA splits data to train and test
%   given shuffled matrix, splits according to fold 
%   if we have 5 fold validation, and we are training for the second time,
%   splits data into 5 chunks where the second is for testing and the rest
%   is for training

assert (foldNumber<kFolds+1 & foldNumber>0 & kFolds>0)

numberOfRows = size(data,1);
start = (floor((foldNumber-1)*numberOfRows/10))+1;
ending = (floor(foldNumber*numberOfRows/10));

test = data(start:ending,:);
train = data(setdiff(1:end,start:ending),:);

end

