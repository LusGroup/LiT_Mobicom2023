% 程序运行入口，进行周期划分、环境光消除、特征提取、分类预测
clc;
clear all

%%
%画分割示例图 (这里展示了用户在吸顶灯情况下的刷牙过程（图13），这个数据是从伸入口腔到刷，可以通过load()来获得指定的信号的分割结果图)
%(Here, the user's brushing process in the case of ceiling light is shown (Figure 13). 
% The data is from the mouth to the brush, and the segmentation result of the specified signal can be obtained by load().)
color = [[0 0.4470 0.7410]; [0.8500 0.3250 0.0980]; [0 0.8 0];[0.9290 0.6940 0.1250]; [0.4940 0.1840 0.5560]; ...
        [0.4660 0.6740 0.1880]; [0.3010 0.7450 0.9330]; [0.6350 0.0780 0.1840]];
load ('data\typical_brushing_process\intomouth_upleftout_flipping_uprightout.mat');%可以改变信号文件，查看信号分割结果
s=segment(y1,y2);
Fs = 10;  %sampling rate
s = s/Fs;
figure;
len = length(y1);
%Note: The sampling rate is 10HZ
t = 0.1:0.1:len/Fs;
plot(t,y1);
hold on;
plot(t,y2);
hold on;
for k = 1:length(s)-1
    c = mod(k,length(color))+1;
hold on;
    if (s(k+1)-s(k))<27/Fs
        rectangle('Position',[s(k),3,(s(k+1)-s(k)),200],'LineWidth',2,'EdgeColor',color(c,:));
    end
end
legend('Sensor 1','Sensor 2');
% xlabel('Sample Index');
xlabel('Time(s)');
ylabel('Light Intensity (lux)');
xlim([0 len/Fs]);
%%
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
    T = segment(y1,y2);
    len = length(T);
    i = 1;
    fprintf('%s\n',name);
    while i<len
        sig1 = y1(T(i):T(i+1));
        sig2 = y2(T(i):T(i+1));
        skewness_value = skewness(sig1);
        i=i+1;
        [sig1,sig2] = cancellation(sig1,sig2);
        features = calculateFeature(sig1,sig2);
        features= num2cell(features);
        charCell = {name};
        features = [features,charCell];
        Table = vertcat(Table,features);
    end
    res = Table;
end
