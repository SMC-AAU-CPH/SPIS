function [pitchTrack, timeVector] = ...
        extractPitchTrack(filename, segmentTime, overlap,...
        pitchBounds, channelNo, reSamplingFreq)
    % load the data, optionally resample it, and optionally select a
    % channel
    [rawData, rawSamplingFreq] = audioread(filename);
    if nargin < 5 || isempty(channelNo)
        channelNo = 1;
    end
    if nargin < 6  || isempty(reSamplingFreq)
        % do not resample - just select the desired channel
        data = rawData(:,channelNo);
        samplingFreq = rawSamplingFreq;
    else
        % resample the signal
        data = resample(rawData(:,channelNo), reSamplingFreq, ...
            rawSamplingFreq);
        samplingFreq = reSamplingFreq;
    end
    
    % setup the estimation algorithm
    if nargin < 7
        estimationAlgorithm = 'NLS';
    end
    
    % setup the segmenting
    nData = length(data);
    segmentLength = round(segmentTime*samplingFreq); % samples
    segmentTime = segmentLength/samplingFreq; % also round segmentTime
    nShift = round((1-overlap/100)*segmentLength); % samples
    shiftTime = nShift/samplingFreq; % also round segmentTime
    nSegments = ceil((nData-segmentLength+1)/nShift);
    
    pitchTrack = nan(nSegments,1);
    
    % do the analysis
    idx = 1:segmentLength;
    for iSegment = 1:nSegments
        disp(['Processing segment ', num2str(iSegment), ' of ', num2str(nSegments)]);
        segmentData = data(idx);
        pitchTrack(iSegment) = combFilterPitchEstimator(segmentData, ...
            pitchBounds/samplingFreq);
        % prepare for the next segment
        idx = idx + nShift;
    end
    timeVector = segmentTime/2+(1:nSegments)*shiftTime-shiftTime/2;
    % convert from digital to analogue frequency
    pitchTrack = pitchTrack*samplingFreq;
end
