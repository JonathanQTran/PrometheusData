%%
%
%   Project: Prometheus Data Acquisition
%   Name: Jonathan Tran
%
%

%% Serialport initialization
clear all;
close all;
clc;

s = serialport('COM5', 9600); % baudrate 9600

flush(s); % Remove any buffered serial data

configureTerminator(s,'CR');

%% Read Data

% Initialize Figures
figure(1)
h1 = animatedline;
ax1 = gca;
ax1.YGrid = 'on';
ax1.YLim = [0 1000];
xlabel('Elapsed time (sec)')
ylabel('Load Cell Data (lbs)')

figure(2)
h2 = animatedline;
ax2 = gca;
ax2.YGrid = 'on';
ax2.YLim = [0 1000];
xlabel('Elapsed time (sec)')
ylabel('Pressure Transducer Data (psi)')

startTime = datetime('now');

% Create new file name
date = datestr(startTime,'mmm dd, yyyy (HH;MM;SS)');
file_name = append(date,'.txt');

% Create new file
fid = fopen(file_name,'wt');
fprintf(fid, '%25s %25s %25s\n','Time (s)','Force (lb)','Pressure (psi)');

fprintf('%25s %25s %25s\n','Time (s)','Force (lb)','Pressure (psi)');

while true
    % Read new line from serial
    data = readline(s);

    % Get current time
    t =  datetime('now') - startTime;
    splitString = split(data,',');

    % Plot first data value
    figure(1)
    addpoints(h1,datenum(t),str2double(splitString(1)))
    ax1.XLim = datenum([t-seconds(15) t]);
    
    datetick('x','keeplimits');
    drawnow;
    
    % Plot second data value
    figure(2)
    addpoints(h2,datenum(t),str2double(splitString(2)))
    ax2.XLim = datenum([t-seconds(15) t]);
    
    datetick('x','keeplimits');
    drawnow;
    
    % Write to file
    fprintf(fid,'%25.4f %25.4f %25.4f\n', datestr(t), str2double(splitString(1)), str2double(splitString(2)));
    
    % Print to command window
    fprintf('%25.4f %25.4f %25.4f\n', datestr(t), str2double(splitString(1)), str2double(splitString(2)))
    % fprintf('%s',data);
    
end

fclose(fid);
