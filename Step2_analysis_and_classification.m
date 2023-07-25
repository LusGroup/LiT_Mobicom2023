% 程序运行入口，进行周期划分、环境光消除、特征提取、分类预测
clc;
clear all

%表格初始化设置
TrainData = table();
colName={'MAX1';'MIN1';'STD1';'RMS1';'MAX2';'MIN2';'STD2';'RMS2';'Eucdistance';'CosDistance';'Correlation';'RMSDiff';'Class'};
varTypes = {'double';'double';'double';'double';'double';'double';'double';'double';'double';'double';'double';'double';'categorical'};
TrainData=table('Size',[0,13],'VariableTypes',varTypes,'VariableNames',colName) ;

PredictData = table();
colName={'MAX1';'MIN1';'STD1';'RMS1';'MAX2';'MIN2';'STD2';'RMS2';'Eucdistance';'CosDistance';'Correlation';'RMSDiff';'Class'};
varTypes = {'double';'double';'double';'double';'double';'double';'double';'double';'double';'double';'double';'double';'categorical'};
PredictData=table('Size',[0,13],'VariableTypes',varTypes,'VariableNames',colName) ;

%获取文件名
% 指定文件夹路径
folderPath = 'data';  % 替换成实际文件夹路径
% 使用 dir 函数获取文件夹中的文件列表
files = dir(fullfile(folderPath, '*.mat'));  % 替换成实际文件类型

% 提取文件名并保存
fileNames ={files.name};
len = length(fileNames);
for i = 1:len
    fileName = cell2mat(fileNames(i));
    fileName = fullfile(folderPath,fileName);
    TrainData = Process(TrainData,fileName);
end

%计算Z-Scores
Size = size(TrainData);
len = Size(2)-1;
for i = 1:len
    colData=TrainData{:,i};
    meanValue = mean(colData);
    stdValue = std(colData);
    zScores = (colData - meanValue) ./ stdValue;
    TrainData{:,i} = zScores;
end

%KNN分类
[trainedClassifier, validationAccuracy]=trainClassifier(TrainData);    
disp(['Cross-validation accuracy is ', num2str(validationAccuracy)]);

%计算特征保存在表格中
function res = Process(Table,fileName)
    load(fileName);
    [~, name, ~] = fileparts(fileName);
    T = autocorrlast(y1,y2);
    len = length(T);
    i = 1;
    while i<len
        sig1 = y1(T(i):T(i+1));
        sig2 = y2(T(i):T(i+1));
        i=i+1;
        [sig1,sig2] = Cancellation(sig1,sig2);
        features = calculateFeature(sig1,sig2);
        features= num2cell(features);
        charCell = {name};
        features = [features,charCell];
        Table = vertcat(Table,features);
    end
    res = Table;
end
