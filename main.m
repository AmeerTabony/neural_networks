%% 312163454 034639294
prompt = 'Hello, this is the project of Hilal and Amir';
prompt2 = '\nFor part 1A, no hidden layers, press 1';
prompt3 = '\nFor part 1B, 1 hidden layer press 2';
prompt4 = '\nFor part 1C, 2 hidden layers press 3';
prompt5 = '\nFor part 2, 1 hidden layer press 4\n';
x = input(strcat(prompt,prompt2,prompt3,prompt4,prompt5));

if x== 4
    main2
elseif x==1
    netParams = [0.8,30,4,0.7];
    layerSizes = [12,ouputSize];
    main1(netParams,layerSizes)
elseif x==2
    netParams = [0.9,80,8,0.9];
    layerSizes = [12,7,ouputSize];
    main1(netParams,layerSizes)
elseif x==3
    netParams = [0.9,120,8,0.9];
    layerSizes = [12,7,4,ouputSize];
    main1(netParams,layerSizes)
else
    main1()
end