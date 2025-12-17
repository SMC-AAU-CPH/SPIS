import json
import os
import re
import sys

def parse_img_attrs(img_tag):
    """
    Parses attributes from an HTML img tag.
    Returns a dict of attributes.
    """
    attrs = {}
    # keys we care about
    keys = ['src', 'alt', 'width', 'height', 'align']
    
    for key in keys:
        # Match key="value" or key='value'
        pattern = f'{key}=[\'"]([^\'"]*)[\'"]'
        match = re.search(pattern, img_tag, re.IGNORECASE)
        if match:
            attrs[key] = match.group(1)
            
    return attrs

def convert_to_myst(attrs):
    """
    Converts attribute dict to MyST directive lines.
    """
    src = attrs.get('src')
    if not src:
        return None
        
    lines = []
    lines.append(f"```{{image}} {src}\n")
    
    if 'alt' in attrs:
        lines.append(f":alt: {attrs['alt']}\n")
    if 'width' in attrs:
        lines.append(f":width: {attrs['width']}\n")
    if 'height' in attrs:
        lines.append(f":height: {attrs['height']}\n")
        
    # We assume center alignment if we are wrapped in <center>
    lines.append(":align: center\n")
    
    lines.append("```\n")
    return lines

def process_file(file_path):
    print(f"Processing {file_path}...")
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            nb = json.load(f)
    except Exception as e:
        print(f"Failed to load {file_path}: {e}")
        return

    changed_file = False
    
    for cell in nb.get('cells', []):
        if cell.get('cell_type') != 'markdown':
            continue
            
        source = cell.get('source', [])
        new_source = []
        i = 0
        while i < len(source):
            line = source[i].strip()
            
            # Check for <center>
            # We look ahead for <img ...> and </center>
            # Pattern expected:
            # i: <center>
            # i+1: <img ...>
            # i+2: </center>
            
            # Sometimes lines might be split differently or have extra newlines, but let's try the strict line sequence first
            # as seen in the examples.
            
            is_match = False
            if line == "<center>":
                # Look ahead
                if i + 2 < len(source):
                    img_line = source[i+1].strip()
                    end_line = source[i+2].strip()
                    
                    if img_line.startswith("<img") and end_line == "</center>":
                        # Found the block
                        attrs = parse_img_attrs(img_line)
                        myst_lines = convert_to_myst(attrs)
                        
                        if myst_lines:
                            new_source.extend(myst_lines)
                            i += 3 # skip these 3 lines
                            is_match = True
                            changed_file = True
                        else:
                            # Failed to parse attrs or no src, keep original
                            pass
            
            if not is_match:
                # Just append the line as is
                new_source.append(source[i])
                i += 1
        
        if len(new_source) != len(source):
             # Deep check if content essentially changed, though length might differ
             pass
             
        cell['source'] = new_source

    if changed_file:
        print(f"  Writing changes to {file_path}")
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(nb, f, indent=1)
    else:
        print(f"  No changes needed for {file_path}")

if __name__ == "__main__":
    files = [
        "03-Fourier-Transform/SPIS03.ipynb",
        "03-Fourier-Transform/03-MED-EEG.ipynb",
        "06-Pitch-Basics/SPIS-06-PitchBasics.ipynb",
        "00-Course-intro/00-Sampling.ipynb",
        "02-Compute/HelloSPIS.ipynb"
    ]
    
    # Resolve absolute paths
    base_dir = os.getcwd()
    files = [os.path.join(base_dir, f) for f in files]
    
    for f in files:
        if os.path.exists(f):
            process_file(f)
        else:
            print(f"File not found: {f}")
