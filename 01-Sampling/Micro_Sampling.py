"""
Micro_Sampling.py
Exercise: Extract and audit random segments from three audio files, then stitch them.
This script uses librosa for audio processing and numpy for signal manipulation.
"""

import os
import glob
import numpy as np
import librosa
import matplotlib.pyplot as plt

def get_segment(path, length=16384):
    """
    Loads an audio file, converts to mono, removes DC offset, 
    normalizes by RMS, and extracts a random segment of specified length.
    """
    try:
        # Load audio (mono=True ensures a 1D array)
        y, sr = librosa.load(path, sr=None, mono=True)
    except Exception as e:
        print(f"Error loading {path}: {e}")
        # Return silence if file loading fails
        return np.zeros(length), 44100
    
    # 1. Remove DC offset
    y = y - np.mean(y)
    
    # 2. Normalize by RMS
    rms = np.sqrt(np.mean(y**2))
    if rms > 1e-6:
        y = y / rms
        
    # 3. Extract random segment
    if len(y) < length:
        # Pad with zeros if the file is too short
        y = np.pad(y, (0, length - len(y)))
        start_idx = 0
    else:
        max_start = len(y) - length
        start_idx = np.random.randint(0, max_start + 1)
        
    return y[start_idx : start_idx + length], sr

def microsample(f1, f2, f3):
    """
    Stitches three audio segments according to the formula:
    y = ((s2*3 + s1)*3) + s3*7 + s1
    Where multiplications represent repetitions (concatenations).
    """
    L = 16384
    s1, sr = get_segment(f1, L)
    s2, _  = get_segment(f2, L)
    s3, _  = get_segment(f3, L)
    
    # Formula components:
    # part_a = (s2 repeated 3 times) followed by s1
    part_a = np.concatenate([np.tile(s2, 3), s1])
    
    # part_b = part_a repeated 3 times
    part_b = np.tile(part_a, 3)
    
    # part_c = s3 repeated 7 times
    part_c = np.tile(s3, 7)
    
    # Final assembly: part_b + part_c + s1
    y = np.concatenate([part_b, part_c, s1])
    
    return y, sr

def main():
    # 1. Find audio files in the SPIS repository
    # We look for .wav files in the current and parent directories
    search_path = os.path.join("..", "**", "*.wav")
    files = glob.glob(search_path, recursive=True)
    
    if len(files) < 3:
        print("Not enough .wav files found in the repository.")
        print("Please ensure you have at least 3 .wav files available.")
        return

    # 2. Select 3 random files
    selected = np.random.choice(files, 3, replace=False)
    print("Selected files for micro-sampling:")
    for i, f in enumerate(selected, 1):
        print(f"{i}: {os.path.basename(f)}")
        
    # 3. Generate the composition
    y, sr = microsample(selected[0], selected[1], selected[2])
    
    # 4. Visualization
    plt.figure(figsize=(12, 5))
    plt.plot(y, color='#1f77b4', linewidth=0.5)
    plt.title(r"Micro-Sampling Masterpiece: $((s_2 \times 3 + s_1) \times 3) + s_3 \times 7 + s_1$")
    plt.xlabel("Samples [n]")
    plt.ylabel("Amplitude (RMS Normalized)")
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()
    
    # 5. Playback (optional)
    try:
        import sounddevice as sd
        print("Playing the creation...")
        sd.play(y, sr)
        sd.wait()
    except (ImportError, Exception):
        print("\nPlayback skipped. To hear the result, ensure 'sounddevice' is installed:")
        print("pip install sounddevice")

if __name__ == "__main__":
    main()
