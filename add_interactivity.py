import json
import os

notebook_path = '/Users/cer/Downloads/SPIS/01-Sampling/00-Sampling.ipynb'

with open(notebook_path, 'r', encoding='utf-8') as f:
    nb = json.load(f)

# The target cell is a code cell with a specific beginning
target_start = "%matplotlib inline\nimport numpy as np\nimport matplotlib.pyplot as plt"

new_source = [
    "%matplotlib inline\n",
    "import numpy as np\n",
    "import matplotlib.pyplot as plt\n",
    "from ipywidgets import interact\n",
    "\n",
    "def sinusoid(samplingIndices, digitalFreq):\n",
    "    '''Compute a cosine'''\n",
    "    return np.cos(2*np.pi*digitalFreq*samplingIndices)\n",
    "\n",
    "def plot_aliasing(samplingFreq=100):\n",
    "    nData = 100\n",
    "    samplingTime = 1/samplingFreq # s\n",
    "    samplingIndices = np.arange(nData)\n",
    "    time = samplingIndices*samplingTime\n",
    "    freqA = 10 # Hz\n",
    "    freqB = samplingFreq - freqA # Hz\n",
    "\n",
    "    # plot the results\n",
    "    plt.figure(figsize=(10,6))\n",
    "    plt.plot(time, sinusoid(samplingIndices,freqA/samplingFreq), linewidth=2, marker='o', label=f\"$x(t)$, f={freqA}Hz\")\n",
    "    plt.plot(time, sinusoid(samplingIndices,freqB/samplingFreq), linewidth=2, marker='o', label=f\"$y(t)$, f={freqB}Hz\")\n",
    "    plt.legend()\n",
    "    plt.xlim((time[0],time[nData-1])), plt.ylim((-1.5,1.5))\n",
    "    plt.xlabel('time [s]'), plt.ylabel('Amplitude [.]')\n",
    "    plt.title(f'Sampling Frequency: {samplingFreq} Hz')\n",
    "    plt.show()\n",
    "\n",
    "interact(plot_aliasing, samplingFreq=(50, 150, 1));"
]

found = False
for cell in nb['cells']:
    if cell['cell_type'] == 'code' and "".join(cell['source']).startswith("%matplotlib inline"):
        cell['source'] = new_source
        found = True
        break

if found:
    with open(notebook_path, 'w', encoding='utf-8') as f:
        json.dump(nb, f, indent=2, ensure_ascii=False)
    print("Successfully updated the notebook cell.")
else:
    print("Target cell not found.")
