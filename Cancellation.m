% function feature = calculateFeature(Signal1,Signal2)
% 对输入的周期信号进行环境光干扰消除的工作
%  输入:
%      Signal1: 两段刷牙信号周期片段其中之一。
%      Signal2：两段刷牙信号周期片段中的另一段。
%
%  输出:
%      [Sig1,Sig2]:干扰消除后的两个信号 。
%     
function [Sig1,Sig2] = Cancellation(Signal1,Signal2)
    Sig1 = Signal1;
    Sig2=Signal2;
    if max(Signal1)>250 
        Sig1=ALI_cancellation(Signal1);
    end
    if max(Signal2)>250 
        Sig2=ALI_cancellation(Signal2);
    end
    
end

function [seg_can]=ALI_cancellation(seg)
    seg_can=((seg-min(seg))/(max(seg)-min(seg))*(150-min(seg)))+min(seg);
end
   