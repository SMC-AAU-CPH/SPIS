Signal Processing for Interactive Systems
================

Cumhur Erkut, Anders Bargum, and Ernests Lavrinovits.

With previous material from Jesper R Jensen and Jesper K Nielsen.

A graduate course in Aalborg University Medialogy and Sound & Music Computing programs.

Modern multimedia systems often make use of numerous sensors to capture inputs from the user(s) for interaction with the system. 
However, the real-life environment around such systems is typically dynamic, noisy, and unpredictable. 
This hinders direct application of data-driven methods to infer the desired user interaction.

This course introduces signal processing theory and methods for analyzing and processing sensor data, e.g., to facilitate robust feature extraction and data clean-up for subsequent machine learning. The following topics provide the basis of our exploration.

1. **Spectral Analysis**: Examining the frequency content of signals.
   Techniques like the Fourier Transform or Short-Time Fourier Transform help reveal the underlying frequencies in a signal.
2. **Signal Modeling**: Signal models describe how real-world signals behave.
   Examples include harmonic summation and  sinusoidal models.
3. **Parameter Estimation**: We often need to estimate unknown signal or model parameters from observed data. 
   Methods like Maximum Likelihood Estimation (MLE) or Least Squares Estimation (LSE) come into play here.
4. **Signal Enhancement**: Enhancing signals involves improving their quality by reducing noise, sharpening edges, or enhancing specific features. Adaptive filters, wavelet denoising, and Wiener filtering are commonly used techniques.

# CONTENT (as run in 2024 course)

* [./01-Intro-librosa](./01-Intro-librosa/)
* [./02-Compute](./02-Compute/)
* [./03-Fourier-Transform](./03-Fourier-Transform/)
* [./04-Spectral-Chromogram-Motiongram](./04-Spectral-Chromogram-Motiongram/)
* [./05-FAST-NLS-F0](./05-FAST-NLS-F0/)
* [./06-Pitch-Basics](./06-Pitch-Basics/)
* [./07-Torch](./07-Torch/)
* [./08-Workshop](./08-Workshop/)
* [./Appendix-1: More Torch](./A1-More%20Torch/)
* fastF0Nls   After [&amp;Nielsen-2017](&Nielsen-2017), contains
  * cpp, matlab, and python implementations
    * cpp compiled for linux and mac m1
    * TODO compile fastF0Nls for windows and mac intel.

# References

Nielsen, Jesper Kjær, Jensen, Tobias Lindström, Jensen, J. R., Christensen, Mads Græsbøll, & Jensen, Søren Holdt (2017). Fast fundamental frequency estimation: making a statistically efficient estimator computationally efficient. Signal Processing, 135(), 188–197. [http://dx.doi.org/10.1016/j.sigpro.2017.01.011](http://dx.doi.org/10.1016/j.sigpro.2017.01.011)
