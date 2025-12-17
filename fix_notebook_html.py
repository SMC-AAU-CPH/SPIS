import json
import os

file_path = '/Users/cer/vc/SPIS/SPIS-Book/00-Course-intro/00-Sampling.ipynb'

try:
    with open(file_path, 'r') as f:
        nb = json.load(f)

    # Target the first cell which is markdown
    cell = nb['cells'][0]
    source = cell['source']

    # We expect the block at indices 4, 5, 6
    # 4: <center>\n
    # 5: <img ...
    # 6: </center>\n
    
    if len(source) > 6 and source[4].strip() == "<center>" and source[6].strip() == "</center>":
        print("Found target HTML block.")
        
        # New MyST content
        new_block = [
            "```{image} https://github.com/SMC-AAU-CPH/med4-ap-jupyter/blob/main/lecture3_Digital_Audio_Signals/figures/apOverview.png?raw=1\n",
            ":alt: Course overview\n",
            ":width: 100%\n",
            ":align: center\n",
            "```\n"
        ]
        
        # Replace
        cell['source'] = source[:4] + new_block + source[7:]
        
        with open(file_path, 'w') as f:
            json.dump(nb, f, indent=1)
        print("Successfully updated notebook.")
    else:
        print("Target block not found. Dumping first 10 lines of source for debugging:")
        for i, line in enumerate(source[:10]):
            print(f"{i}: {repr(line)}")
            
except Exception as e:
    print(f"Error: {e}")
