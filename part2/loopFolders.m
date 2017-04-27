function suffeledData = loopFolders()
% Get a list of all files and folders in this folder.
files = dir('/Users/hilldi/Desktop/uni/Neuro computations/hw1/hw1/Hebrew_Letters');
files=files(~ismember({files.name},{'.','..'}));

% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);
% Print folder names to command window.
tic
allData =[];
for k = 1 : length(subFolders)
    currentFolderName = subFolders(k).name
    currentFolderPath = fullfile(subFolders(k).folder,currentFolderName);
	fprintf('Sub folder #%d = %s\n', k, currentFolderName);


	
	% Now we have a list of all files in this folder.
    letterNames = {'Aleph','Bet','Gimmel','Dalet','He','Vav','Kaf','Lamed'};
	for letterx =1:8
        filePattern = sprintf(strcat('%s/',letterNames{letterx},'*.txt'), currentFolderPath);
        baseFileNames = dir(filePattern);
        numberOfFiles = length(baseFileNames);
        if numberOfFiles >= 1
		% Go through all the files.
            for f = 1 : numberOfFiles
                fullFileName = fullfile(currentFolderName, baseFileNames(f).name);
                pathOfFile=fullfile(currentFolderPath, baseFileNames(f).name);
    %             expandData(getLetterAsMat(pathOfFile),pathOfFile(1:end-4));
                matLetter = getLetterAsMat(pathOfFile)';
                if size(matLetter,1)~= 16 || size(matLetter,2)~= 16
                    fprintf('oh oh')
                else
                    arrLetter = reshape(matLetter,[1,16*16]);
                    arrLetter = [letterx,arrLetter];
                    allData = [allData; arrLetter];
                end
                
    % 			fprintf('     Processing file %s\n', fullFileName);
            end
        else
            fprintf('     Folder %s has no files in it.\n', currentFolderName);
        end

        
    end
	
end
toc
suffeledData = allData(randperm(size(allData,1)),:); % shuffle wines together 
end

