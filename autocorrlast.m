% function res = autocorrlast(Signal1,Signal2)
% 返回经过分割之后的刷牙周期的开始和结束位置。
%  输入:
%      Signal1: 两段刷牙信号其中之一。
%      Signal2：两段刷牙信号中的另一段。
%
%  输出:
%      CycleArr: 经过自相关运算找到的周期开始的位置。
%     
%
% 以下代码基于自相关进行周期分割，输出为找到的周期序列位置。

function CycleArr = autocorrlast(Signal1,Signal2)
    [s1,scoor1] = seg(Signal1);
    [s2,scoor2] = seg(Signal2);
    if isempty(scoor1) || sum((scoor1)) < sum(scoor2)
        s=s2;
    else
        s=s1;
    end
    CycleArr = s;
end

%计算自相关，得到极小和极大值
function [ret,ret1,ret2] = mycorr1(A,size)
[R,tau] = xcorr(A,'unbiased',size-1);
N = floor(length(R)+1)/2;
%返回相关性
ret = R(N+1:end);
%一阶差分
inf = diff(R(N:end));
%sign信号
inf = sign(inf);
%二阶差分
inf = diff(inf);
max = ((find(inf<0)));
min = ((find(inf>0)));
ret1 = min;
ret2 = max;
end

function [s,scorr] = seg(target1)
size=27;
s=[];
scorr=[];
T=0;
start=1;
i=1;%记录当前序列号
N = length(target1);
    while i<= N % && i>=101
        if i< 27 %如果前面没有27个点，大约三个周期的刷牙信号
        elseif i>= 27%如果有27个点，那就开始判断当前窗口是否有27个点
            A1 = mapminmax(target1(start+i-27:size+i-27),-1,1);%对信号做归一化
            [arr_sim,arr_min,arr_max] = mycorr1(A1,size);%获取当前的自相关函数，极小值，极大值点
            if ~isempty(arr_max) && ~isempty(arr_min) && length(arr_min) == length(arr_max) && all(arr_min <arr_max)%如果极大值极小值数量相等，并且先有极小值再有极大值
                logical_array_min = (arr_sim(arr_min) <=-0.15);%每对极大极小值都阈值计算一下
                logical_array_max = (arr_sim(arr_max) >= 0.15);
                if (all(logical_array_min) && all(logical_array_max)|| all(arr_sim(arr_min)-arr_sim(arr_max)<=-0.3)) && length(arr_max)>=2%判断是否有周期性和对称性
                    if T==0%说明之前没有至少一个周期
                        s=[s,i-27,arr_max+i-27];%记录所有分割点，一个，两个，三个或者四个
                        scorr=[scorr,arr_sim(arr_max)];
                        T=1;%有的话记录，当前窗口有
                    elseif T==1 && all(arr_max(end-1)+i-27 == s(end)) %说明之前至少有一个周期性。顺便判断是否和前面的周期匹配，先判断最后一个
                        s=[s,arr_max(end)+i-27];
                        scorr=[scorr,arr_sim(arr_max(end))];
                        T=1;
                    elseif T==1  && all(arr_max(end-1)+i-27+1 == s(end))
                        s=[s,arr_max(end)+i+1-27];
                        scorr=[scorr,arr_sim(arr_max(end))];
                        T=1;
                    elseif T==1  && all(arr_max(end-1)+i-27-1 == s(end))
                        s=[s,arr_max(end)+i-1-27];
                        scorr=[scorr,arr_sim(arr_max(end))];
                        T=1;      
                    elseif arr_max(end)+i-27>s(end)+27
                        s=[s,s(end)+(s(end)-s(end-1))];
                        s=[s,i-27,arr_max+i-27];%记录所有分割点，一个，两个，三个或者四个
                        scorr=[scorr,arr_sim(arr_max)];
                        T=1;%有的话记录，当前窗口有
                    end   
                end
            elseif ~isempty(arr_max) && ~isempty(arr_min) && (length(arr_min) - length(arr_max)) ==1 && all(arr_min(1) < arr_max(1)) %如果先有极小值再有极大值，但是最后极小值多了一个
                logical_array_min = (arr_sim(arr_min(1:end-1)) <=-0.15);%只对前面成对的极大极小值进行计算
                logical_array_max = (arr_sim(arr_max) >= 0.15);
                if (all(logical_array_min) && all(logical_array_max) || all(arr_sim(arr_min(1:end-1))-arr_sim(arr_max)<=-0.3)) && length(arr_max)>=2%判断是否有周期性和对称性
                    if T==0%说明之前没有至少一个周期
                        s=[s,i-27,arr_max+i-27];%记录所有分割点，一个，两个，三个或者四个
                        scorr=[scorr,arr_sim(arr_max)];
                        T=1;%有的话记录，当前窗口有
                    elseif T==1  && all(arr_max(end-1)+i-27 == s(end))%说明之前至少有一个周期性。顺便判断是否和前面的周期匹配，先判断最后一个
                        s=[s,arr_max(end)+i-27];
                        scorr=[scorr,arr_sim(arr_max(end))];
                        T=1;
                    elseif T==1  && all(arr_max(end-1)+i-27+1 == s(end))
                        s=[s,arr_max(end)+i+1-27];
                        scorr=[scorr,arr_sim(arr_max(end))];
                        T=1;
                    elseif T==1  && all(arr_max(end-1)+i-27-1 == s(end))
                        s=[s,arr_max(end)+i-1-27];
                        scorr=[scorr,arr_sim(arr_max(end))];
                        T=1;         
                    elseif T==1  && all(arr_max(end-1)+i-27+2 == s(end))
                        s=[s,arr_max(end)+i+2-27];
                        scorr=[scorr,arr_sim(arr_max(end))];
                        T=1;
                    elseif T==1  && all(arr_max(end-1)+i-27-2 == s(end))
                        s=[s,arr_max(end)+i-2-27];
                        scorr=[scorr,arr_sim(arr_max(end))];
                        T=1;    
                     elseif T==1  && all(arr_max(end-1)+i-27+3 == s(end))
                        s=[s,arr_max(end)+i+3-27];
                        scorr=[scorr,arr_sim(arr_max(end))];
                        T=1;
                    elseif T==1  && all(arr_max(end-1)+i-27-3 == s(end))
                        s=[s,arr_max(end)+i-3-27];
                        scorr=[scorr,arr_sim(arr_max(end))];
                        T=1;         
                    elseif T==1  && all(arr_max(end-1)+i-27+4 == s(end))
                        s=[s,arr_max(end)+i+4-27];
                        scorr=[scorr,arr_sim(arr_max(end))];
                        T=1;
                    elseif T==1  && all(arr_max(end-1)+i-27-4 == s(end))
                        s=[s,arr_max(end)+i-4-27];
                        scorr=[scorr,arr_sim(arr_max(end))];
                        T=1;
                    elseif arr_max(end)+i-27>s(end)+27
                        s=[s,s(end)+(s(end)-s(end-1))];
                        s=[s,i-27,arr_max+i-27];%记录所有分割点，一个，两个，三个或者四个
        %                 scorr=[scorr,arr_sim(s(end)+(s(end)-s(end-1)))];
                        scorr=[scorr,arr_sim(arr_max)];
                        T=1;
                    end   
                end
            end
        end
        if i==N && ~isempty(s) && N-s(end) >= s(end)-s(end-1)
            s=[s,s(end)+(s(end)-s(end-1))];
        end
        i=i+1;%数据长度加1
    end

end