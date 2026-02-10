# Sampling Essentials Bilingual

In this section, we explore how analog signals are converted into digital representations and vice versa.

## Continuous-time signal
A **continuous-time** signal is characterised by having a value $x(t)$ for every possible time $t$. Informally: You draw a continuous-time signal without lifting your pen from the paper.

## Sampling
Storing a continuous-time signal on a computer requires an infinite amount of memory. To solve this, we only measure the value of a continuous-time signal every $T_\text{s}$ seconds. This is called **sampling**.

$$
f_\text{s} = 1/T_\text{s}
$$

where $f_\text{s}$ is the **sampling frequency** (Hz) and $T_\text{s}$ is the **sampling time** (seconds).

## Discrete-time signal
A **discrete-time** signal only has a value $x_n$ at certain times $t_n = nT_\text{s}$. The $x$-axis is often the sampling index $n$.

## Reconstruction
Converting a discrete-time signal $x_n$ back into a continuous-time signal $x(t)$ is called **reconstruction**. This is typically done using:
1. **Hold circuit**: Creates a staircase signal.
2. **Post filter**: Smooths the signal using a low-pass filter with a cut-off frequency of $f_\text{s}/2$.

## Aliasing
Aliasing occurs when a sinusoidal component of one frequency disguises itself as another frequency due to insufficient sampling.

::::{tab-set}
:::{tab-item} Python
:sync: python

```{code-block} python
---
filename: 01-Sampling-Reconstruction-Resampling.py
---
import numpy as np
import matplotlib.pyplot as plt

def sinusoid(samplingIndices, digitalFreq):
    '''Compute a cosine'''
    return np.cos(2*np.pi*digitalFreq*samplingIndices)

nData = 100
samplingFreq = 100 # Hz
samplingTime = 1/samplingFreq # s
samplingIndices = np.arange(nData)
time = samplingIndices*samplingTime
freqA = 10 # Hz
freqB = 90 # Hz (samplingFreq-freqA)

# plot the results
plt.figure(figsize=(10,6))
plt.plot(time, sinusoid(samplingIndices,freqA/samplingFreq), linewidth=2, marker='o', label="$x(t)$")
plt.plot(time, sinusoid(samplingIndices,freqB/samplingFreq), linewidth=2, marker='o', label="$y(t)$")
plt.legend()
plt.xlim((time[0],time[nData-1])), plt.ylim((-1.5,1.5))
plt.xlabel('time [s]'), plt.ylabel('Amplitude [.]');
```
:::

:::{tab-item} MATLAB
:sync: matlab

```{code-block} matlab
---
filename: 01-Sampling-Reconstruction-Resampling.m
---
%%%
%% Generating Signals
%
%Code	Description
%t = (0:1/fs:T)'	Create a time vector of a specified duration T
%t = (0:n-1)'/fs	Create a time vector with a specified number of samples
%s = A * sin(2*pi*f*t + phi)	Generate a sine wave at a given frequency f, amplitude A, and phase phi
%y = chirp(t,f0,t1,f1)	Generate a chirp signal from f0 Hz to f1 Hz

% Function defined at end of script or in separate file
% function s = sinusoid(samplingIndices, digitalFreq)
%     s = cos(2*pi*digitalFreq*samplingIndices);
% end

nData = 100;
samplingFreq = 100; % Hz
samplingTime = 1/samplingFreq; % s
samplingIndices = 0:nData-1;
time = samplingIndices * samplingTime;
freqA = 10; % Hz
freqB = 90; % Hz (samplingFreq-freqA)

% Anonymous function for sinusoid
sinusoid = @(n, f) cos(2*pi*f*n);

% plot the results
figure;
plot(time, sinusoid(samplingIndices, freqA/samplingFreq), 'LineWidth', 2, 'marker', 'o', 'DisplayName', 'x(t)');
hold on;
plot(time, sinusoid(samplingIndices, freqB/samplingFreq), 'LineWidth', 2, 'marker', 'o', 'DisplayName', 'y(t)');
legend('show');
xlim([time(1), time(end)]); ylim([-1.5, 1.5]);
xlabel('time [s]'); ylabel('Amplitude [.]');

%%% Resample the signal
% resample	The sample rate of y is p/q times the sample rate of x
sinusoidResampled = resample(sinusoid(samplingIndices, freqA/samplingFreq), 4, 1);
figure;
plot(sinusoidResampled);
```
:::
::::

## Nyquist-Shannon sampling theorem
To avoid aliasing, the maximum frequency $f_\text{max}$ in a continuous-time signal must satisfy:

$$
2f_\text{max} < f_\text{s}
$$

## Quantisation
Quantisation is the process of rounding the signal values to a finite number of levels so they can be stored on a computer.

### Signal-to-Noise Ratio (SNR)
The SNR characterizes the quantisation quality:

$$
\text{SNR} \approx 6\beta \text{ dB}
$$

where $\beta$ is the number of bits.
