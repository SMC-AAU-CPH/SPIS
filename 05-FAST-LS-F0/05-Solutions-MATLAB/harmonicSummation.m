function estimatedPitch = harmonicSummation(dataSegment, pitchBounds, ...
        pitchOrder)
    nData = length(dataSegment);
    nDft = 5*nData*pitchOrder;
    dftData = fft(dataSegment, nDft);
    % ensure that pitchOrder*maxPitch is smaller than the Nyquist frequency
    pitchBounds(2) = min(pitchBounds(2), 1/(2*pitchOrder));
    % compute the grid of dft indices between the pitch bounds
    pitchDftIndices = computeValidDftIndices(pitchBounds, nDft);
    % compute the harmonic summation objection function
    hsObjective = computeHsObjective(dftData, ...
        pitchDftIndices, pitchOrder);
    % compute the pitch estimate
    [~, idx] = max(hsObjective);
    estimatedPitch = pitchDftIndices(idx(1))/nDft;
end

function dftIndices = computeValidDftIndices(pitchBounds, nDft)
    minDftIndex = ceil(nDft*pitchBounds(1));
    maxDftIndex = floor(nDft*pitchBounds(2));
    dftIndices = (minDftIndex:maxDftIndex)';
end

function hsObjective = computeHsObjective(dftData, ...
        validPitchDftIndices, pitchOrder)
    nPitches = length(validPitchDftIndices);
    hsObjective = zeros(nPitches,1);
    for ii = 1:pitchOrder
        iiDftIndices = validPitchDftIndices*ii;
        % the +1 is to compensate for MATLAB's indexing
        hsObjective = hsObjective + ...
            abs(dftData(iiDftIndices+1)).^2;
    end
end
