import json

notebook_path = '/Users/cer/Downloads/SPIS/01-Sampling/00-Sampling.ipynb'

with open(notebook_path, 'r', encoding='utf-8') as f:
    nb = json.load(f)

# Add the required widgets metadata structure
if 'metadata' not in nb:
    nb['metadata'] = {}

if 'widgets' not in nb['metadata']:
    nb['metadata']['widgets'] = {}

# Add the 'state' key to widgets metadata
nb['metadata']['widgets']['state'] = {}

with open(notebook_path, 'w', encoding='utf-8') as f:
    json.dump(nb, f, indent=2, ensure_ascii=False)

print("Successfully added 'state' key to metadata.widgets")
