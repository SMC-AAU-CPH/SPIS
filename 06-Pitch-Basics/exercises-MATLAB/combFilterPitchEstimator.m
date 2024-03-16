function [pitchEstimate, freqVector, objFunction] = ...
        combFilterPitchEstimator(data, pitchBounds)
    nData = length(data);
    delayBounds = [max(1,ceil(1/pitchBounds(2))), ...
        min(nData-1, floor(1/pitchBounds(1)))];
    delayVector = delayBounds(1):delayBounds(2);
    nDelays = length(delayVector);
    % the last half of the input data are the reference data which we
    % correlate against
    refDataIdx = (delayBounds(2):nData-1)+1; % +1 is for MATLAB's indexing
    refData = data(refDataIdx);
    refDataPower = refData'*data(refDataIdx);
    % compute the cost function
    objFunction = nan(nDelays,1);
    for ii = 1:nDelays
        iDelay = delayVector(ii);
        shiftedData = data(refDataIdx-iDelay);
        shiftedDataPower = shiftedData'*shiftedData;
        crossPower = refData'*shiftedData;
        normalisedXCorr = crossPower/sqrt(shiftedDataPower*refDataPower);
        % the MAX() stems for requiring that the gain must be nonnegative
        % if this is not there, we would get pitch doubling if a single
        % sinusoid where used as input
        objFunction(ii) = max(normalisedXCorr,0);
    end
    % compute the freq vector and the cost function corresponding to the
    % delays in the delay vector
    objFunction = flipud(objFunction);
    freqVector = flipud(1./delayVector(:));
    [~, idx] = max(objFunction);
    pitchEstimate = freqVector(idx);
end
