function predictedLabel = weightedKNN(trainData, trainLabels, testData, k)
    % 计算测试数据点与训练数据点之间的欧氏距离
    distances = pdist2(trainData, testData);

    % 获取距离最近的 k 个训练数据点的索引
    [~, indices] = mink(distances, k);

    % 根据距离计算权重
    weights = 1./distances(indices);

    % 将类别标签映射为正整数下标
    uniqueLabels = unique(trainLabels);
    labelMap = containers.Map(uniqueLabels, 1:numel(uniqueLabels));
    mappedTrainLabels = cell2mat(values(labelMap, num2cell(trainLabels(indices))));

    % 使用加权得票的方式预测测试数据点的标签
    vote = accumarray(mappedTrainLabels, weights, [numel(uniqueLabels), 1], @sum);

    % 找到得票最多的标签作为预测结果
    [~, maxIndex] = max(vote);
    predictedLabel = uniqueLabels(maxIndex);
end
