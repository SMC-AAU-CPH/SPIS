function [pitchTrack, timeVector, orderTrack] = ...
        extractPitchTrack(filename, segmentTime, overlap,...
        pitchBounds, channelNo, reSamplingFreq, estimationAlgorithm)
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
        estimationAlgorithm.method = 'NLS';
        estimationAlgorithm.maxOrder = 15;
    end
    
    % setup the segmenting
    nData = length(data);
    segmentLength = round(segmentTime*samplingFreq); % samples
    segmentTime = segmentLength/samplingFreq; % also round segmentTime
    nShift = round((1-overlap/100)*segmentLength); % samples
    shiftTime = nShift/samplingFreq; % also round segmentTime
    nSegments = ceil((nData-segmentLength+1)/nShift);
    
    % initialise the estimator
    if strcmp(estimationAlgorithm.method,'NLS') == 1      
        pitchEstimator = fastF0Nls(segmentLength, ...
            estimationAlgorithm.maxOrder, pitchBounds/samplingFreq);
    elseif strcmp(estimationAlgorithm.method,'HS') == 1
        % no initialisation
    elseif strcmp(estimationAlgorithm.method,'comb') == 1 
        % no initialisation
    end
    
    pitchTrack = nan(nSegments,1);
    orderTrack = nan(nSegments,1);
    
    % do the analysis
    idx = 1:segmentLength;
    for iSegment = 1:nSegments
        disp(['Processing segment ', num2str(iSegment), ' of ', num2str(nSegments)]);
        segmentData = data(idx);
        if strcmp(estimationAlgorithm.method,'NLS') == 1
            [pitchTrack(iSegment), orderTrack(iSegment)] = ...
                pitchEstimator.estimate(segmentData);
        elseif strcmp(estimationAlgorithm.method,'HS') == 1
            pitchTrack(iSegment) = harmonicSummation(segmentData, ...
                pitchBounds/samplingFreq, estimationAlgorithm.pitchOrder);
        elseif strcmp(estimationAlgorithm.method,'comb') == 1
            pitchTrack(iSegment) = combFilterPitchEstimator(segmentData, ...
                pitchBounds/samplingFreq);
        else
            error('Unknown method');
        end
        % prepare for the next segment
        idx = idx + nShift;
    end
    timeVector = segmentTime/2+(1:nSegments)*shiftTime-shiftTime/2;
    % convert from digital to analogue frequency
    pitchTrack = pitchTrack*samplingFreq;
end
