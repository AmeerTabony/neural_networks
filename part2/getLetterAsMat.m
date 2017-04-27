function A = getLetterAsMat(path)
% return txt file as a matrix of 1s and 0s
fileID = fopen(path,'r');
formatSpec = '%1u %1u %1u %1u %1u %1u %1u %1u %1u %1u %1u %1u %1u %1u %1u';
sizeA = [16 16];
A = fscanf(fileID,formatSpec,sizeA)';
fclose(fileID);

end