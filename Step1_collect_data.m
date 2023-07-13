

%%
%实时画出数据
%Code to collect data. 4 minutes of data can be collected, and the
%collected data is displayed in real time.
close all;
close();
% fclose(instrfind);
s = serial('COM5','BaudRate',9600);  
%定义串口对象 Define serial port objects (Note that, this port (first parameter) depends on the Arduino UNO port recognized by the computer)


fopen(s);  %打开串口对象s Open serial port object s

t=0;
x=0;
y=0;
% z=0;
% j=0;
interval = 2400;%sampling number (Note that, sampling rate is 10 Hz)
while(t<interval)
    b=str2num(fgetl(s));
    if length(b)==2
    a4=b(1);
    a5=b(2);
        x=[x,a5];
        y=[y,a4];
    else
        break;
    end
    plot(x,'-r', 'LineWidth',2);
    hold on;
    plot(y,'-.b', 'LineWidth',2);

    t=t+1;
    drawnow;
end
%The data of the two sensors are stored in separate mat files.
save("E:\toothbrush\原始数据\原始数据3\sensor1.mat", "x");% Path to save sensor 1's data
save("E:\toothbrush\原始数据\原始数据3\sensor2.mat", "y");% Path to save sensor 2's data
fclose(s);
