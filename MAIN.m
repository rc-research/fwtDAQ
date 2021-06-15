close all;clc;fclose all;clear all;restoredefaultpath;
addpath('./gust_vane_7x5'); % Add Gust Vane Code Library
%% Folding Wingtip WTT DAQ Script
% Created: R.C.M. Cheung
% Contact: r.c.m.cheung@bristol.ac.uk
% Date: 11 NOV 2019
%% Init meta data container
d = initData();
%% Test Set
d.cfg = setMeta(d.cfg,'testType','');
gustFreqList = 1.0:0.5:2.0; % list of 1-cos gust frequencies
%% Files
swSave = 1; % save data?
d.cfg = setMeta(d.cfg,'dataDirectory','..\data'); % output directory
%% Test Condition
% datum case?
d.cfg = setMeta(d.cfg,'datum',0);
% hinge configuration
d.cfg = setMeta(d.cfg,'locked',1);
% WT configuration
d.cfg = setMeta(d.cfg,'aoa',5.0);
d.cfg = setMeta(d.cfg,'velocity',18.0);
% gust
d.gust = setMeta(d.gust,'duration',20.0,'amplitudeDeg',3.0);
d.gust = setMeta(d.gust,'sine',1,'frequency',0.0);
% d.gust = setMeta(d.gust,'random',1);
if(d.cfg.datum)
    d.gust = setMeta(d.gust,'frequency',0.0,'amplitudeDeg',0.0);
    gustFreqList = 0;
end
% timing
d.cfg = setMeta(d.cfg,'measurementPauseDuration',25.0, ...
    'preGustPauseDuration',1.0,'postGustPauseDuration',1.0);
% DAQ rate
d.daq = setMeta(d.daq,'rate',1700.0); % nearest to 1706.667 Hz(calculated from 1/5.859375e-04)
%% Init Test
[s,d,lh,lh2] = initTest(d);
swNewTest = 1;
for tt = 1:length(gustFreqList)
    %% Update gust settings
    d.gust = setMeta(d.gust,'frequency',gustFreqList(tt));
    %% Queue output data
    if(swNewTest)
        setOutput(s,d,1); % first pass
        swNewTest = 0;
    else
        setOutput(s,d,0);
        fprintf('\nPause for Next Measurement... \n\n');
        pause(d.cfg.measurementPauseDuration); % Pause between cases
    end
    %% Run Test
    runTest(s,d);
    %% load data from tmp DAQ file
    d = loadData(s,d);
    %% Save data
    saveData(d,swSave);
end
%% Finish Test
endTest(s,d,lh,lh2);
%% Plots
figure
subplot(4,1,1)
plot(d.daq.t,d.daq.strain.v)
xlabel('Time, s')
ylabel('Strain Ch, v')
subplot(4,1,2)
plot(d.daq.t,d.daq.encoder.v)
xlabel('Time, s')
ylabel('Encoder Ch, v')
subplot(4,1,3)
plot(d.daq.t,d.daq.sync.v)
xlabel('Time, s')
ylabel('Sync Ch, v')
subplot(4,1,4)
plot(d.daq.t,d.daq.gust.v)
xlabel('Time, s')
ylabel('Gust Ch, v')

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
