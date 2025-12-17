Signal Processing for Interactive Systems
=========================================

Cumhur Erkut, Anders Bargum, and Signe T Henriksen

With previous material from Jesper R Jensen, Ernests Lavrinovits, Mubarik Jamal Muuse, and Jesper K Nielsen.

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

# APROACH

Time-frequency signal analysis/synthesis suitable for machine / deep learning tasks.

![Time-frequency relations](TF.png)

Mathematical theory: postponed to PhD level:

- [https://www.numerical-tours.com](https://www.numerical-tours.com)
- [https://mathematical-tours.github.io]()

# CONTENT

* Chapter 4 is based on "Introduction to Machine Learning Systems" (Shared Lab) licensed at [https://github.com/harvard-edge/cs249r_book]() under [Attribution-NonCommercial-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-nc-sa/4.0/) License.

## Building the Book

This book uses Jupyter Book v2 (powered by MyST). To build the book locally:

1. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

2. Build the HTML version:
   ```bash
   jupyter book build --html
   ```

3. The built site will be in `_build/html/`

For more information about Jupyter Book v2, see [mystmd.org](https://mystmd.org).
