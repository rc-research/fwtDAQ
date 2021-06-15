function [d] = initData()
%% Folding Wingtip WTT DAQ - Init Data
% Created: R.C.M. Cheung
% Contact: r.c.m.cheung@bristol.ac.uk
% Date: 11 NOV 2019

% cfg
d.cfg.locked = 0;
d.cfg.aoa = 0.0;
d.cfg.velocity = 0.0;
d.cfg.datum = 0;
d.cfg.sync = [];
d.cfg.preGustPauseDuration = 0.0;
d.cfg.postGustPauseDuration = 0.0;
d.cfg.padDuration = 0.0;
d.cfg.sampleDuration = 0.0;
d.cfg.measurementPauseDuration = 0.0;
d.cfg.dataDirectory = '';
d.cfg.testType = '';
d.cfg.runCount = 1;
d.cfg.genGust = 0;

% gust
d.gust.amplitudeDeg = 0.0;
d.gust.frequency = 0.0;
d.gust.sine = 0;
d.gust.oneMinusCosine = 0;
d.gust.random = 0;
d.gust.chirp = 0;
d.gust.frequencyEnd = 0.0;
d.gust.analogue = 0;
d.gust.duration = 0.0;
d.gust.timeOffset = 0.0;
d.gust.offsetDeg = 0.0;

% tab
d.tab.amplitudeDeg = 0.0;
d.tab.frequency = 0.0;
d.tab.sine = 0;
d.tab.chirp = 0;
d.tab.frequencyEnd = 0;
d.tab.analogue = 0;
d.tab.duration = 0.0;
d.tab.delay = 0.0;
d.tab.timeOffset = 0.0;
d.tab.trimDeg = 0.0;
d.tab.command = [];

% daq - calibration
d.daq.accelerometer.calibration = accCalibration();
d.daq.loadcell.calibration = loadCalibration();
[d.daq.encoder.calibration.slope,d.daq.encoder.calibration.constant] ...
    = encoderCalibration();
[d.daq.strain.calibrationBMT,d.daq.strain.calibration] ...
    = strainCalibration();
d.daq.servo.calibrationTabDeg = servoCalibration();

% % daq - data
d.daq.triggerTime  = 0;
d.daq.date = '';
d.daq.rate = 0.0;
d.daq.t = [];
d.daq.sync.v = [];
d.daq.accelerometer.v = [];
d.daq.loadcell.v = [];
d.daq.encoder.v = [];
d.daq.strain.v = [];
d.daq.servo.v = [];
d.daq.gust.v = [];

% % cam
% d.cam = camDATA;

end