% Sampling and Reconstruction
% This script demonstrates the sampling and reconstruction of sinusoidal signals.

clear; clc; close all;

nData = 100;
samplingFreq = 100; % Hz
samplingTime = 1/samplingFreq; % s
samplingIndices = 0:nData-1;
time = samplingIndices * samplingTime;
freqA = 10; % Hz
freqB = 90; % Hz (samplingFreq-freqA)

% Anonymous function for sinusoid
sinusoid = @(n, f) cos(2*pi*f*n);

% Plot the results
figure('Name', 'Sampling and Aliasing', 'NumberTitle', 'off');
plot(time, sinusoid(samplingIndices, freqA/samplingFreq), 'LineWidth', 2, 'Marker', 'o', 'DisplayName', 'x(t)');
hold on;
plot(time, sinusoid(samplingIndices, freqB/samplingFreq), 'LineWidth', 2, 'Marker', 'o', 'DisplayName', 'y(t)');
legend('show');
xlim([time(1), time(end)]);
ylim([-1.5, 1.5]);
grid on;
title('Sampling and Reconstruction/Aliasing Demo');
xlabel('time [s]');
ylabel('Amplitude [.]');
