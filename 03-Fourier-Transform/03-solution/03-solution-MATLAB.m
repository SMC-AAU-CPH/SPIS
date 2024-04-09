%% Exercise 2.1 
% Using a computer, compute theK-point amplitude spectra of x1(n)andx2(n).
% Experiment with the size of K. Start with a value of K=N and increase it. 
% What changes when you change K? Why?
nData = 100;
n = (0:nData-1)';
freq = 2*pi*0.2; % rad/sample
x1 = exp(1i*freq*n);
x2 = cos(freq*n);

% compute the dft's
nDftList = [100,200,1000]; % the DFT-length
dftListLength = length(nDftList);
for ii = 1:dftListLength
    dftX1 = fft(x1, nDftList(ii));
    dftX2 = fft(x2, nDftList(ii));
    % plot the amplitude spectra
    freqVector = (0:nDftList(ii)-1)/nDftList(ii); % cycles/sample
    figure(ii)
    subplot(2,2,1)
    plot(freqVector, abs(dftX1))
    title(['Amplitude spectrum of x_1(n) for K=', num2str(nDftList(ii))])
    xlabel('Freq. [cycles/sample]')
    ylabel('Amplitude spectrum [\cdot]')
    subplot(2,2,2)
    plot(freqVector, angle(dftX1))
    title(['Phase spectrum of x_1(n) for K=', num2str(nDftList(ii))])
    xlabel('Freq. [cycles/sample]')
    ylabel('Phase spectrum [radians]')
    subplot(2,2,3)
    title(['Amplitude spectrum of x_2(n) for K=', num2str(nDftList(ii))])
    plot(freqVector, abs(dftX2))
    xlabel('Freq. [cycles/sample]')
    ylabel('Amplitude spectrum [\cdot]')
    subplot(2,2,4)
    plot(freqVector, angle(dftX2))
    title(['Phase spectrum of x_2(n) for K=', num2str(nDftList(ii))])
    xlabel('Freq. [cycles/sample]')
    ylabel('Phase spectrum [radians]')
end

%% Exercise 2.1b: Amplitude spectra of a trumpet signal
clear
clc
close all

[data, samplingFreq] = audioread('../data/trumpet.wav');

nData = length(data);
nDft = nData;
dftData = fft(data,nDft);

freqVector = samplingFreq*(0:nDft-1)'/nDft;
plot(freqVector, abs(dftData));
xlabel('Freq. [Hz]')
ylabel('Amplitude [\cdot]')

% The amplitude spectrum of the trumpet signal contains only a few harmonics.
% Therefore a harmonic summation model is a good model for the trumpet signal.

%% Exercise 2.2: Convolution in time and frequency domain

clear
clc
close all

nData = 10;
n = (0:nData-1)';
freq = 1.1; % rad/sample
a = -0.9;
h = a.^n;
x = cos(freq*n);
convLength = 2*nData-1;
hzp = [h; zeros(convLength-nData,1)];
xzp = [x; zeros(convLength-nData,1)];
% a) compute convolution as a sum
ya = zeros(convLength,1);
for ii = 1:convLength
    for jj = 1:nData
        % the '+1' is to convert to MATLAB indexing
        ya(ii) = ya(ii) + hzp(jj)*xzp(mod(ii-jj,convLength)+1);
    end
end

% b) compute the convolution using linear algebra
H = gallery('circul',hzp)'; % the convolution matrix
yb = H*xzp;

% c) compute the convolution in the frequency domain
% real() is only used for numerical reasons
yc = real(ifft(fft(h,convLength).*fft(x,convLength)));

% d) compute the convolution using the DFT matrix
F = dftmtx(convLength);
% real() is only used for numerical reasons
yd = real((1/convLength)*F'*diag(F*hzp)*F*xzp);

% plot the four results on top of each other - they should be the same
timeVector = (0:convLength-1)'/convLength;
plot(timeVector, [ya, yb, yc, yd])

import numpy as np
import matplotlib.pyplot as plt
from scipy.fft import fft, ifft

# What changes when you change K? Why?
nData = 100
n = np.arange(nData)
freq = 2*np.pi*0.2  # rad/sample
x1 = np.exp(1j*freq*n)
x2 = np.cos(freq*n)

# compute the dft's
nDftList = [100, 200, 1000]  # the DFT-length
dftListLength = len(nDftList)
for ii in range(dftListLength):
    dftX1 = fft(x1, nDftList[ii])
    dftX2 = fft(x2, nDftList[ii])
    # plot the amplitude spectra
    freqVector = np.arange(nDftList[ii])/nDftList[ii]  # cycles/sample
    plt.figure(ii)
    plt.subplot(2, 2, 1)
    plt.plot(freqVector, np.abs(dftX1))
    plt.title(f'Amplitude spectrum of x_1(n) for K={nDftList[ii]}')
    plt.xlabel('Freq. [cycles/sample]')
    plt.ylabel('Amplitude spectrum [.]')
    plt.subplot(2, 2, 2)
    plt.plot(freqVector, np.angle(dftX1))
    plt.title(f'Phase spectrum of x_1(n) for K={nDftList[ii]}')
    plt.xlabel('Freq. [cycles/sample]')
    plt.ylabel('Phase spectrum [radians]')
    plt.subplot(2, 2, 3)
    plt.title(f'Amplitude spectrum of x_2(n) for K={nDftList[ii]}')
    plt.plot(freqVector, np.abs(dftX2))
    plt.xlabel('Freq. [cycles/sample]')
    plt.ylabel('Amplitude spectrum [.]')
    plt.subplot(2, 2, 4)
    plt.plot(freqVector, np.angle(dftX2))
    plt.title(f'Phase spectrum of x_2(n) for K={nDftList[ii]}')
    plt.xlabel('Freq. [cycles/sample]')
    plt.ylabel('Phase spectrum [radians]')
plt.show()
