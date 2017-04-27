function [ output ] = formatOutput( outputData, outputSize )
%FORMATOUTPUT gets the wine color and formats it to how we want the data
%to look like
%   returns formated output

outputData = outputData+1; % between 1-2

% outputSize = 2; % 2 colors of wine

%% format output

output = zeros(size(outputData,1),outputSize);
for x=1:outputSize
    tempMat = outputData - x; % zeros in the index that corresponds to the output rating 2 will have 0 in index 1
    output(:,x) = tempMat;
end
output = (output*10) +1;
output(output~=1) = 0;
% output will have 1 in the coloums where the rating matches the
% index, else 0s
%%


end

