function feature = calculateFeature(SignalA,SignalB)
    % 确保输入信号不为空
    assert(~isempty(SignalA), '信号1为空.');
    assert(~isempty(SignalB), '信号1为空.');
    % 确保输入的向量长度相同
    assert(length(SignalA) == length(SignalB), '向量长度不一致.');
    feature = [];
    
    % 计算信号的标准差
    std1 = std(SignalA);
    std2 = std(SignalB);
    feature = [feature,std1,std2];
    
    % 计算均方根
    rms1 = sqrt(mean(SignalA.^2));
    rms2 = sqrt(mean(SignalB.^2));
    
    feature = [feature,rms1,rms2];
    
    % 寻找片段信号的最大值和最小值
    max1 = max(SignalA);
    max2 = max(SignalB);
    feature = [feature,max1,max2];
    
    min1 = min(SignalA);
    min2 = min(SignalB);
    feature = [feature,min1,min2];
    
    %RMSE
    % 计算平方差的平均值
    squaredError = (SignalB - SignalA).^2;
    meanSquaredError = mean(squaredError);
    % 计算均方根误差（RMSE）
    rmse = sqrt(meanSquaredError);
    feature = [feature,rmse];
    
    % 计算欧氏距离EuclideanDistance
    distance = norm(SignalA - SignalB);
    feature = [feature,distance];
    
    %余弦距离CosineDistance
    % 计算向量的内积
    dotProduct = dot(SignalA, SignalB);
    % 计算向量的范数
    norm1 = norm(SignalA);
    norm2 = norm(SignalB);
    % 计算余弦距离
    distance = 1 - dotProduct / (norm1 * norm2);
    feature = [feature,distance];
    
    %Pearson相关系数
    % 计算平均值
    meanX = mean(SignalA);
    meanY = mean(SignalB);
    % 计算协方差
    covariance = cov(SignalA, SignalB);
    % 计算Pearson相关系数
    correlation = covariance(1, 2) / (std(SignalA) * std(SignalB));
    feature = [feature,correlation];
    
end