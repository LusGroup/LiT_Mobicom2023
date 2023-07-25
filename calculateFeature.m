% function feature = calculateFeature(Signal1,Signal2)
% 输入信号进行刷牙片段特征提取工作，提取的特征包括：
% 最大值/最小值/标准差/均方根/欧氏距离/余弦距离/Pearson相关系数/RMSE
%  输入:
%      Signal1: 两段刷牙信号周期片段其中之一。
%      Signal2：两段刷牙信号周期片段中的另一段。
%
%  输出:
%      feature: 包含两个信号共计12个特征的数组。
%     

function feature = calculateFeature(Signal1,Signal2)
    % 确保输入信号不为空
    assert(~isempty(Signal1), '信号1为空.');
    assert(~isempty(Signal2), '信号1为空.');
    % 确保输入的向量长度相同
    assert(length(Signal1) == length(Signal2), '向量长度不一致.');
    feature = [];
    
    % 计算信号的标准差
    std1 = std(Signal1);
    std2 = std(Signal2);
    
    % 计算均方根
    rms1 = sqrt(mean(Signal1.^2));
    rms2 = sqrt(mean(Signal2.^2));
    
    % 寻找片段信号的最大值和最小值
    max1 = max(Signal1);
    max2 = max(Signal2);
    
    min1 = min(Signal1);
    min2 = min(Signal2);
    
    %RMSEdiff
    rmsdiff=rms1-rms2;
    
    % 计算欧氏距离EuclideanDistance
    eucdistance = norm(Signal1 - Signal2);
    eucdistance = eucdistance/length(Signal1);
    
    %余弦距离CosineDistance
    % 计算向量的内积
    dotProduct = dot(Signal1, Signal2);
    % 计算向量的范数
    norm1 = norm(Signal1);
    norm2 = norm(Signal2);
    % 计算余弦距离
    cosdistance = 1 - dotProduct / (norm1 * norm2);
    
    %Pearson相关系数
    % 计算平均值
    meanX = mean(Signal1);
    meanY = mean(Signal2);
    % 计算协方差
    covariance = cov(Signal1, Signal2);
    % 计算Pearson相关系数
    correlation = covariance(1, 2) / (std(Signal1) * std(Signal2));
    
    max1=(max1-122.98)/58.33;
    min1=(min1-61.58)/51.05;
    std1=(std1-19.95)/16.78;
    rms1=(rms1-90.48)/47.88;
    
    max2=(max2-119.06)/52.97;
    min2=(min2-60.06)/52.10;
    std2=(std2-18.72)/13.79;
    rms2=(rms2-89.95)/49.85;
    
    eucdistance=(eucdistance-742.48)/396.28;
    cosdistance=(cosdistance-0.14)/0.13;
    correlation=(correlation-(-0.13))/0.81;
    rmsdiff=(rmsdiff-0.08)/77.62;
    feature = [max1,min1,std1,rms1,max2,min2,std2,rms2,eucdistance,cosdistance,correlation,rmsdiff];
    
end