%  A script to extract and audit random segments of audio signals, then stitch them together.
%  This exercise demonstrates micro-sampling and signal manipulation.

% Clear environment
clear; clc; close all;

%% SELECT AUDIO FILES
% Set audio directory (Example using MATLAB's built-in samples)
myDIR = fullfile(matlabroot, 'toolbox', 'audio', 'samples');

% Check if directory exists, otherwise ask user
if ~exist(myDIR, 'dir')
    fprintf('Directory %s not found.\n', myDIR);
    myDIR = uigetdir(pwd, 'Select audio directory containing .wav files');
    if myDIR == 0, return; end
end

% List audio files
files = dir(fullfile(myDIR, '*.wav')); 
if length(files) < 3
    error('Not enough .wav files found in %s. Need at least 3.', myDIR);
end

% Select 3 random files
rng('shuffle');
randIdx = randperm(length(files), 3);
f1 = fullfile(myDIR, files(randIdx(1)).name);
f2 = fullfile(myDIR, files(randIdx(2)).name);
f3 = fullfile(myDIR, files(randIdx(3)).name);

fprintf('Selected files:\n1: %s\n2: %s\n3: %s\n', ...
    files(randIdx(1)).name, files(randIdx(2)).name, files(randIdx(3)).name);

%% GENERATE MINI-MASTERPIECE
% Call the microsample function
y = microsample(f1, f2, f3);

%% VISUALIZE AND AUDIT
% Plot the result
figure('Color', 'w');
plot(y, 'LineWidth', 0.5, 'Color', [0 0.447 0.741]);
title('Stitched Micro-Samples: ((s2 \times 3 + s1) \times 3) + s3 \times 7 + s1');
xlabel('Samples [n]');
ylabel('Amplitude (RMS Normalized)');
grid on;
axis tight;

% Play the result
Fs = 44100; % Assuming standard sample rate for playback
disp('Press any key to play the creation...'); pause;
soundsc(y, Fs);

disp('Exercise complete.');

%% FUNCTIONS

function y = microsample(f1, f2, f3)
    % MICROSAMPLE Extracts random segments and stitches them according to the formula:
    % y = ((s2*3 + s1)*3) + s3*7 + s1
    % Where multiplications represent segment repetitions.
    
    % Extract 16384 samples from each file
    L = 16384;
    s1 = get_segment(f1, L);
    s2 = get_segment(f2, L);
    s3 = get_segment(f3, L);
    
    % Stitching formula
    % (s2*3 + s1)
    partA = [repmat(s2, 3, 1); s1];
    
    % (s2*3 + s1)*3
    partB = repmat(partA, 3, 1);
    
    % s3*7
    partC = repmat(s3, 7, 1);
    
    % Final composition: partB + partC + s1
    y = [partB; partC; s1];
end

function s = get_segment(filename, L)
    % GET_SEGMENT Audits a file and extracts a random segment of length L
    
    % Read audio
    [y, ~] = audioread(filename);
    
    % Force to mono
    if size(y, 2) > 1
        y = mean(y, 2);
    end
    
    % 1. Remove DC offset
    y = y - mean(y);
    
    % 2. Normalize by RMS
    RMS = sqrt(mean(y.^2));
    if RMS > 0
        y = y / RMS;
    end
    
    % 3. Extract random segment
    if length(y) < L
        % Pad with zeros if file is too short
        y = [y; zeros(L - length(y), 1)];
        startIdx = 1;
    else
        maxStart = length(y) - L + 1;
        startIdx = randi(maxStart);
    end
    
    s = y(startIdx : startIdx + L - 1);
end
