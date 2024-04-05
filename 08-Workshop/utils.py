from matplotlib import pyplot as plt
import torch
from torch.utils.data import Dataset
import numpy as np
import scipy.signal as signal
import numpy as np
from typing import List, Tuple
from timeit import timeit
from torch.profiler import profile, ProfilerActivity

# --- UTIL FUNCTIONS ----

def plot_graph(x_label, y_label, lim, array1, array2=None, legend=None):
    plt.figure(figsize=(6, 3))
    plt.plot(array1)
    if array2 is not None:
        plt.plot(array2)
    plt.xlabel(x_label)
    plt.ylabel(y_label)
    plt.ylim(lim)
    if legend is not None:
        plt.legend(legend)
    plt.show()

def get_sine(target_gain, freq, sr):
    return target_gain * torch.sin(torch.linspace(0, 2 * torch.pi * freq, sr // 2))

def plot_tf(
    title: str,
    fs: int,
    t: np.ndarray,
    ys: List[np.ndarray],
    imps: List[np.ndarray],
    labels: List[str] = None,
    xlim: Tuple[float, float] = None,
):
    fig = plt.figure(figsize=(9, 3))
    plt.subplot(1, 2, 1)
    for y, label in zip(ys, labels) if labels is not None else zip(ys, [None] * len(ys)):
        plt.plot(t, y, label=label)
    plt.xlabel("Time [s]")
    plt.ylabel("Amplitude")
    plt.title(title)
    
    if label is not None:
        plt.legend()
    if xlim is not None:
        plt.xlim(*xlim)
        
    plt.subplot(1, 2, 2)

    # Number of sample points
    N = fs
    T = 1.0 / N   
    x = np.linspace(0.0, N*T, N)
    
    for imp, label in zip(imps, labels) if labels is not None else zip(imps, [None] * len(imps)):
        yf = np.fft.fft(imp, n=N)
        magnitude = 20 * np.log10(np.abs(yf))
        plt.plot(x[:N//2], magnitude[:N//2], label=label)
        
    plt.xlabel("Frequency [Hz]")
    plt.ylabel("Magnitude [dB]")
    plt.ylim(-25, 5)
    plt.title("Magnitude spectrum")
    if labels is not None:
        plt.legend()
    plt.show()

# --- FOR DIFFERENTIABLE FILTER ----

class DIIRDataSet(Dataset):
    def __init__(self, input, target, sequence_length):
        self.input = input
        self.target = target
        self._sequence_length = sequence_length
        self.input_sequence = self.wrap_to_sequences(self.input, self._sequence_length)
        self.target_sequence = self.wrap_to_sequences(self.target, self._sequence_length)
        self._len = self.input_sequence.shape[0]

    def __len__(self):
        return self._len

    def __getitem__(self, index):
        return {'input': self.input_sequence[index, :, :]
               ,'target': self.target_sequence[index, :, :]}

    def wrap_to_sequences(self, data, sequence_length):
        num_sequences = int(np.floor(data.shape[0] / sequence_length))
        truncated_data = data[0:(num_sequences * sequence_length)]
        wrapped_data = truncated_data.reshape((num_sequences, sequence_length, 1))
        return np.float32(wrapped_data)
    
class DIIR_WRAPPER(torch.nn.Module):
    def __init__(self, filter_function):
        super(DIIR_WRAPPER, self).__init__()
        self.cell = filter_function

    def forward(self, input, initial_states=None):
        batch_size = input.shape[0]
        sequence_length = input.shape[1]

        if initial_states is None:
            states = self.cell.init_states(batch_size)
        else:
            states = initial_states

        out_sequence = torch.zeros(input.shape[:-1]).to(input.device)
        for s_idx in range(sequence_length):
            out_sequence[:, s_idx], states = self.cell(input[:, s_idx].view(-1), states)
        out_sequence = out_sequence.unsqueeze(-1)

        if initial_states is None:
            return out_sequence
        else:
            return out_sequence, states