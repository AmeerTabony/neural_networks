function [ output ] = formatOutput( outputData )
%FORMATOUTPUT gets the wine rating and formats it to how we want the data
%to look like
%   returns formated output

outputData = outputData- min(outputData)+1; % between 1-7

ouputSize = max(outputData) - min(outputData) +1; % 3 minimum rating, 9 max rating

%% format output

output = zeros(size(outputData,1),ouputSize);
for x=1:ouputSize
    tempMat = outputData - x; % zeros in the index that corresponds to the output rating 3 will have 0 in index 1
    output(:,x) = tempMat;
end
output = (output*10) +1;
output(output~=1) = 0;
% output will have 1 in the coloums where the rating matches the
% index, else 0s
%%


end

