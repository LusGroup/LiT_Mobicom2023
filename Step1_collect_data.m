

%%
%实时画出数据
%Code to collect data. 4 minutes of data can be collected, and the
%collected data is displayed in real time.
close all;
close();
fclose(instrfind);
s = serial('COM5','BaudRate',9600);  
%定义串口对象 Define serial port objects (Note that, this port (first parameter) depends on the Arduino UNO port recognized by the computer)


fopen(s);  %打开串口对象s Open serial port object s

t=0;
y1=0;
y2=0;
figure('Position', [100, 100, 1280, 600]);

interval = 2400;%sampling number (Note that, sampling rate is 10 Hz)
while(t<interval)
    b=str2num(fgetl(s));
    if length(b)==2
    a4=b(1);
    a5=b(2);
        y1=[y1,a5];
        y2=[y2,a4];
    else
        break;
    end
    plot(y1,'-b', 'LineWidth',2);
    hold on;
    plot(y2,'-.r', 'LineWidth',2);
    t=t+1;
    drawnow;
end
%The data of the two sensors are stored in mat files.
save("data\brushingsurface1.mat", "y1","y2");% Path to save sensor data

fclose(s);
