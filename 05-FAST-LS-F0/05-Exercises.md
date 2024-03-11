# Exercise Set 5 

TODO: Python/Jupyter solutions 

At the  <./data> folder you will find the viola signal <kbd>09viola.flac</kbd> and the speech signal `roy.wav`. 
We would like to estimate the fundamental frequency / pitch of these signals.

a) Implement the harmonic summation pitch estimation method as a function in, e.g. MATLAB. 
	The function should have the following input

  - a segment of data
  - the lower and upper limits for the fundamental frequency in cycles/sample
  - the number of harmonic components.

  The output of the function should be the estimated fundamental frequency. 
  Optionally, you can also return the estimated amplitudes and initial phases of the harmonic components.

  Solution: See the MATLAB file `hsPitchEstimator.m`

The above function can estimate the fundamental frequency for a segment of data. 
We now wish to analyse entire audio files.

(b) Write a function that takes in an audio file and displays the estimated fundan1ental frequency track in cycles/second (Hz). 

The function should have the following input:

- Filename of the audio file,
- the segment length in seconds,
- the overlap between segments as a percentage,
- the lower and upper limits for the fundamental frequency in cycles/sample

The output of the function should be thte estin1ated fundamental frequencies as a function of time. 
Optionally, you can also return the estin1ated amplitudes and initial phases of the harmonic components as a function of time.

Solution: See the MATLAB file `extractPitchTrack.m`

(c) Extend to function above to take another input parameter specifying the algorithm used for estimating the fundamental frequency. Besides the correlation-based method and the harmonic summation method, it should also be possible to use the fast NLS method which you can find on Github https://github.com/jkjaer/fastFONls. Try one or several of the following experiments:

- adding noise using MATLAB's `awgn(data, SNR, 'measured')` function and compare how the different pitch estimators perform on noisy data
- transcribe a piece of monophonic music into notes
- create your own instrwnent tuner

Solution: See the MATLAB file `f0EstimationExample.m`



