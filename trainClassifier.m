function [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% 返回经过训练的分类器及其 准确度。以下代码重新创建在分类学习器中训练的分类模型。您可以使用
% 该生成的代码基于新数据自动训练同一模型，或通过它了解如何以程序化方式训练模型。
%
%  输入:
%      trainingData: 一个包含导入 App 中的预测变量和响应列的表。
%
%  输出:
%      trainedClassifier: 一个包含训练的分类器的结构体。该结构体中具有各种关于所训练分
%       类器的信息的字段。
%
%      trainedClassifier.predictFcn: 一个对新数据进行预测的函数。
%
%      validationAccuracy: 一个包含准确度百分比的双精度值。在 App 中，"历史记录" 列
%       表显示每个模型的此总体准确度分数。
%
% 使用该代码基于新数据来训练模型。要重新训练分类器，请使用原始数据或新数据作为输入参数
% trainingData 从命令行调用该函数。
%
% 例如，要重新训练基于原始数据集 T 训练的分类器，请输入:
%   [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
% 要使用返回的 "trainedClassifier" 对新数据 T2 进行预测，请使用
%   yfit = trainedClassifier.predictFcn(T2)
%
% T2 必须是一个表，其中至少包含与训练期间使用的预测变量列相同的预测变量列。有关详细信息，请



% 提取预测变量和响应
% 以下代码将数据处理为合适的形状以训练模型。
%
inputTable = trainingData;
predictorNames = {'MAX1';'MIN1';'STD1';'RMS1';'MAX2';'MIN2';'STD2';'RMS2';'Eucdistance';'CosDistance';'Correlation';'RMSDiff'};
predictors = inputTable(:, predictorNames);
response = inputTable.Class;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false];

% 训练分类器
% 以下代码指定所有分类器选项并训练分类器。
classificationKNN = fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Cityblock', ...
    'Exponent', [], ...
    'NumNeighbors', 1, ...
    'DistanceWeight', 'SquaredInverse', ...
    'Standardize', false, ...
    'ClassNames', categorical({'low_front_in'; 'low_front_out'; 'low_left_in'; 'low_left_occ'; 'low_left_out'; 'low_right_in'; 'low_right_occ'; 'low_right_out'; 'up_front_in'; 'up_front_out'; 'up_left_in'; 'up_left_occ'; 'up_left_out'; 'up_right_in'; 'up_right_occ'; 'up_right_out'}));

% 使用预测函数创建结果结构体
predictorExtractionFcn = @(t) t(:, predictorNames);
knnPredictFcn = @(x) predict(classificationKNN, x);
trainedClassifier.predictFcn = @(x) knnPredictFcn(predictorExtractionFcn(x));

% 向结果结构体中添加字段
trainedClassifier.RequiredVariables = {'MAX1';'MIN1';'STD1';'RMS1';'MAX2';'MIN2';'STD2';'RMS2';'Eucdistance';'CosDistance';'Correlation';'RMSDiff'};
trainedClassifier.ClassificationKNN = classificationKNN;


% 提取预测变量和响应
% 以下代码将数据处理为合适的形状以训练模型。
%
inputTable = trainingData;
predictorNames = {'MAX1';'CosDistance';'Correlation';'RMSDiff';'MIN1';'STD1';'RMS1';'MAX2';'MIN2';'STD2';'RMS2';'Eucdistance'};
predictors = inputTable(:, predictorNames);
response = inputTable.Class;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false];

% 执行交叉验证
partitionedModel = crossval(trainedClassifier.ClassificationKNN, 'KFold', 5);

% 计算验证预测
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

% 计算验证准确度
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
