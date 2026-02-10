---
title: Hello SPIS
content_includes_title: true
kernelspec:
  name: python3
  display_name: Python 3
parts: {}
authors:
  - nameParsed:
      literal: Cumhur Erkut
      given: Cumhur
      family: Erkut
    name: Cumhur Erkut
    id: contributors-myst-generated-uid-0
github: https://github.com/SMC-AAU-CPH/SPIS
copyright: '2026  '
source_url: https://github.com/SMC-AAU-CPH/SPIS/blob/main/02-Compute/HelloSPIS.ipynb
edit_url: https://github.com/SMC-AAU-CPH/SPIS/edit/main/02-Compute/HelloSPIS.ipynb
---
+++
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/SMC-AAU-CPH/SPIS/blob/main/02-Compute/HelloSPIS.ipynb)

+++
# Hello SPIS

This is a Markdown cell. Double-click it to edit it or execute it (Shift + Ctrl) to save it. Markdown can be quite nice for any additional figures or documentation you wish to accompany your code with!

+++
```python
# Install Python packages, the "!" means that this command will be executed as a
# shell command, instead of Python code. YOU CAN SKIP THIS CELL ON COLAB: librosa is installed there by default.
!pip install librosa
```



+++
```python
# Import python Packages
import numpy as np
```



+++
```python
# Declare an array and compute the mean
myArray = [1, 2, 3, 4]
myMean = np.mean(myArray)
print(myMean)
```



+++
## Common pattern for a bug

Due to the sequential nature of Colab, as you’re prototyping and running different cells multiple times, you may accidentally create state overwrites without realizing it! Execute only the following cell multiple times and observe how the assertion fails upon the 2nd execution of the cell!

Think about why this occurs and how you can mitigate it. From a software engineering perspective this code may benefit from restructuring. If that is not possible, then for this particular example you have three options:

*   Rerun the cell that declares this array (reset the variable declaration)
*   Rerun the notebook from the start (all states will be re-written). (*Runtime -> Run All*)
*   Restart your Jupyter kernel. Your session will be completley reset and you are starting from a clean slate. (*Runtime -> Restart Session*)

+++
```python
# Add more data and re-compute the mean
myArray.append(5)
myMean = np.mean(myArray)
print(f"Value of myMean: {myMean}")

assert np.isclose(myMean, 3.0)
```



+++
# Time-Frequency Analysis with librosa

**Problem**: analyzing a trumpet signal
Suppose that we record a trumpet signal {math}`s_n` for {math}`n=0,1,2,\ldots,N-1`.

```{image} https://github.com/SMC-AAU-CPH/med4-ap-jupyter/blob/main/lecture7_Fourer_Transfom/figures/trumpet.jpg?raw=1
:width: 50%
:align: center
:alt: Trumpet
```

+++
```python
import librosa
filename = librosa.example('trumpet')
s, sr = librosa.load(filename)

import matplotlib.pyplot as plt
plt.plot(s)
```



+++
```python
#play the audio
import IPython.display as ipd
ipd.Audio(s, rate=sr)
```



+++
```python
# @title TF Analysis with Librosa
# calculate the STFT of the trumpet signal using librosa

D = librosa.stft(s)  # STFT of y
S_db = librosa.amplitude_to_db(np.abs(D), ref=np.max)

plt.figure(figsize=(14,6))
# Change y axis up to 10kHz
plt.ylim(0,10000)
librosa.display.specshow(S_db, sr=sr, x_axis='time', y_axis='linear',cmap='jet')
plt.colorbar()
```

+++
# Bilingual Analysis (Python/MATLAB)

::::{tab-set}
:::{tab-item} Python
:sync: python

```python
import librosa
import numpy as np
import matplotlib.pyplot as plt

# Load sample
s, sr = librosa.load(librosa.example('trumpet'))

# STFT and DB conversion
D = librosa.stft(s)
S_db = librosa.amplitude_to_db(np.abs(D), ref=np.max)

# Plotting
plt.figure(figsize=(10, 4))
librosa.display.specshow(S_db, sr=sr, x_axis='time', y_axis='hz')
plt.colorbar()
plt.title('Trumpet STFT (Librosa)')
plt.show()
```
:::

:::{tab-item} MATLAB
:sync: matlab

```matlab
% MATLAB equivalent (requires Signal Processing Toolbox)
fs = 22050; % standard for this example
[s, fs] = webread('https://github.com/librosa/librosa/raw/main/tests/data/test1_22050.wav');

% STFT parameters
window = hamming(1024);
noverlap = 512;
nfft = 1024;

[S, F, T] = stft(s, fs, 'Window', window, 'OverlapLength', noverlap, 'FFTLength', nfft);
S_db = 20*log10(abs(S));

% Plotting
figure;
imagesc(T, F, S_db);
axis xy; 
xlabel('Time (s)'); 
ylabel('Frequency (Hz)');
colorbar;
title('Trumpet STFT (MATLAB)');
```
:::
::::