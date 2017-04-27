function expandData(dat,path)
%EXPANDDATA this function will create noisy copies of given data.
% path will be without the .txt so that we will append to the file name
% save data to path
    doSomeShifts(dat,path)
    for i=1:5
        noisyData = flipBits(dat,0.01*i);
        saveData(noisyData,strcat(path,'-fliped-',num2str(i),'-1.txt'))
        doSomeShifts(noisyData,path)
        
        noisyData = flipBits(dat,0.01*i);
        saveData(noisyData,strcat(path,'-fliped-',num2str(i),'-2.txt'))
        doSomeShifts(noisyData,path)
    end
        
end

function doSomeShifts(data, path)
% shifts mat if the coloum is not zero and saves
    for i=1:3
        if isempty(find(data(:,i)~=0))
            temp =circshift(data,-i,2);
            saveData(temp,strcat(path,'-trans',num2str(i),'-l','.txt'))
        else
            break;
        end
    end
    
    for i=1:3
        if isempty(find(data(:,end-i+1)~=0))
            temp =circshift(data,i,2);
            saveData(temp,strcat(path,'-trans',num2str(i),'-r','.txt'))
        else
            break;
        end
    end
    
    for i=1:2
        if isempty(find(data(end-i+1,:)~=0) & isempty(find(data(:,end-i+1)~=0)))
            temp =circshift(data,[1 1]);
            saveData(temp,strcat(path,'-trans',num2str(i),'-dr','.txt'))
        else
            break;
        end
    end
    
    for i=1:2
        if isempty(find(data(end-i+1,:)~=0) & isempty(find(data(:,i)~=0)))
            temp =circshift(data,[1 -1]);
            saveData(temp,strcat(path,'-trans',num2str(i),'-dl','.txt'))
        else
            break;
        end
    end
    
    for i=1:2
        if isempty(find(data(i,:)~=0) & isempty(find(data(:,i)~=0)))
            temp =circshift(data,[-1 -1]);
            saveData(temp,strcat(path,'-trans',num2str(i),'-ul','.txt'))
        else
            break;
        end
    end
    
    for i=1:2
        if isempty(find(data(i,:)~=0) & isempty(find(data(:,end-i+1)~=0)))
            temp =circshift(data,[-1 1]);
            saveData(temp,strcat(path,'-trans',num2str(i),'-ur','.txt'))
        else
            break;
        end
    end
    
end

function saveData(data,path)
dlmwrite(path,data,'delimiter','')
end

function dat =flipBits(dat, percentage)
% flips a percentage of bits in given mat, returns it
index = rand(size(dat)) <= percentage;
dat(index) = dat(index) +1;
dat(dat>1) = 0;
end