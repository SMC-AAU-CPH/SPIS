clear
clc
close all

% set-up
filename = '09viola.flac';
reSamplingFreq = 16000; % Hz
channelNo = 1;
segmentTime = 25/1000; % seconds
overlap = 75; % percentage
minF0 = 100;
maxF0 = 1000;
pitchBounds = [minF0, maxF0];

%% analyse the signal segment-by-segment
[pitchTrack, timeVector] = ...
        extractPitchTrack(filename, segmentTime, overlap,...
        pitchBounds, channelNo, reSamplingFreq);

%% setup and compute spectrogram
[audio, samplingFreq] = audioread(filename);
segmentLength = round(segmentTime*samplingFreq);
specSegmentLength = round(2*segmentLength);
specWindow = gausswin(specSegmentLength);
nDft = 4096;
specNOverlap = round(3*specSegmentLength/4);
[S, F, T] = spectrogram(audio(:,1), specWindow, specNOverlap, nDft, samplingFreq);

%% plot the results
figure(1)
imagesc(T,F,20*log10(abs(S)))
set(gca,'YDir','normal')
hold on
plot(timeVector, pitchTrack,'r.')
ylim([0,1000])
hold off
xlabel('time [s]')
ylabel('frequency [Hz]')