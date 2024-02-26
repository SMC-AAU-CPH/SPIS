clear
clc
close all

% select and load input file
[data, samplingFreq] = audioread('changingSinusoids.wav');
% [data, samplingFreq] = audioread('roy.wav');
% [data, samplingFreq] = audioread('trumpetFull.wav');
segmentTime = 0.03; % seconds
segmentLength = round(segmentTime*samplingFreq); % samples
% some windows have user-defined parameters and some don't
windowList = {'rectwin', 'hann', 'gausswin'};
windowParameters = {[], [], 4};
nWindows = length(windowList);
overlapPercentage = 50;
nOverlap = round(overlapPercentage*segmentLength/100);
nDft = 4096;
% for the plotting, set the maximum dynamic range
maxRangeDb = 100; % dB

% compute the STFT for the different windows
figure(1)
for ii = 1:nWindows
    if size(windowParameters{ii},1) > 0
        iiWindow = window(str2func(windowList{ii}), segmentLength, ...
            windowParameters{ii});
    else
        iiWindow = window(str2func(windowList{ii}), segmentLength);
    end
    [stft, freqVector, timeVector] = ...
        spectrogram(data, iiWindow, nOverlap, nDft, samplingFreq);
    subplot(nWindows,1,ii)
    % to make a fair visual comparison, we set the dynamic range of the
    % spectrograms to the same value
    limSpectrogram = dynamicRangeLimiting(abs(stft).^2, maxRangeDb);
    imagesc(timeVector, freqVector, 10*log10(limSpectrogram));
    set(gca,'Ydir','Normal')
    xlabel('Time [s]')
    ylabel('Frequency [f]')
    title(['Spectrogram for N=', num2str(segmentLength), ...
        ' and the ', windowList{ii}, ' window']);
end
