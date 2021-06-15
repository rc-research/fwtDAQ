close all;clc;fclose all;clear all;restoredefaultpath;
%% GVT DAQ Script
% Created: R.C.M. Cheung
% Contact: r.c.m.cheung@bristol.ac.uk
% Date: 15 JUN 2021
%% Init meta data container
d = initData();
%% Test Set
d.cfg = setMeta(d.cfg,'testType','GVT');
%% Files
swSave = 1; % save data?
d.cfg = setMeta(d.cfg,'dataDirectory','..\data'); % output directory
d.cfg = setMeta(d.cfg,'fileName','Testcase_1'); % output filename
%% Test Condition
% DAQ Duration
d.cfg.sampleDuration = 30.0; % sec
% DAQ rate
d.daq = setMeta(d.daq,'rate',1700.0); % nearest to 1706.667 Hz(calculated from 1/5.859375e-04)
%% Init Test
[s,d,lh,lh2] = initTest(d);
% wait for user input to begin DAQ
disp('Press any key to begin DAQ.')
pause
%% Run Test
runTest(s,d);
%% load data from tmp DAQ file
d = loadData(s,d);
%% Save data
saveData(d,swSave);
%% Finish Test
endTest(s,d,lh,lh2);
%% Plots
figure
subplot(4,1,1)
plot(d.daq.t,d.daq.strain.v)
xlabel('Time, s')
ylabel('Strain Ch, v')

figure
sz = size(d.daq.accelerometer.v,2);
for ii = 1:sz
    subplot(sz,1,ii)
    plot(d.daq.t,d.daq.accelerometer.v(:,ii))
    xlabel('Time, s')
    ylabel('v')
end
subplot(sz,1,1)
title('Accelerometer Ch')
