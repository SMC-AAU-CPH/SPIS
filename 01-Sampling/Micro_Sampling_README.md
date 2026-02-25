# Walkthrough: Micro-Sampling Exercise

I have added a new micro-sampling exercise to the `01-Sampling` directory. This exercise is implemented in both MATLAB and Python, demonstrating how to manipulate audio signals by extracting and stitching segments.

## Changes Made
### 1. MATLAB Implementation: [Micro_Sampling.m](./Micro_Sampling.m)
- Extracts a random 16384-sample segment from three different audio files.
- Processes each segment:
    - Converts to mono.
    - Removes DC offset.
    - Normalizes by RMS.
- Stitches the segments according to the formula: `((s2*3 + s1)*3) + s3*7 + s1`.
- Plots and plays the result.

### 2. Python Implementation: [Micro_Sampling.py](Micro_Sampling.py)
- Uses `librosa` for audio loading and `numpy` for signal processing.
- Follows the same logic as the MATLAB script, ensuring consistent output across platforms.
- Includes a fallback mechanism to use random noise if no `.wav` files are found in the repository.

## Verification

### Logic Check
The formula `((s2*3 + s1)*3) + s3*7 + s1` results in a total of 20 segments:
- `s2*3 + s1` = 4 segments.
- `(s2*3 + s1)*3` = 12 segments.
- `s3*7` = 7 segments (total cumulative).
- `+ s1` = 1 segment (total 20).

Each segment is 16384 samples, resulting in a total signal length of 327,680 samples.

### Python Verification
I verified that the Python script correctly finds audio files in the repository and executes the stitching logic without errors.

```python
# Segment breakdown
part_a = np.concatenate([np.tile(s2, 3), s1])  # 3*s2 + 1*s1 = 4
part_b = np.tile(part_a, 3)                   # 4 * 3 = 12
part_c = np.tile(s3, 7)                       # 7*s3 = 7
y = np.concatenate([part_b, part_c, s1])      # 12 + 7 + 1 = 20 segments
```

## How to Run

### MATLAB
1. Open MATLAB and navigate to `01-Sampling`.
2. Run `Micro_Sampling.m`.
3. The script will try to use base MATLAB audio samples or prompt you to select a directory.

### Python
1. Ensure `librosa`, `numpy`, and `matplotlib` are installed.
2. Run `python Micro_Sampling.py`.
3. If `sounddevice` is installed, the audio will play automatically.
