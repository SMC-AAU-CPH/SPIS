import json
import re
import sys

def convert_myst_to_html(content):
    # Regex to capture the whole {image} block
    # It looks for ```{image} URL followed by optional lines starting with : and ending with ```
    pattern = r"```{image}\s+(.*?)\n((?::.*?\n)*)```"
    
    def replace_func(match):
        url = match.group(1).strip()
        options_text = match.group(2)
        
        options = {}
        for line in options_text.strip().split('\n'):
            if line.startswith(':'):
                parts = line[1:].split(':', 1)
                if len(parts) == 2:
                    key = parts[0].strip()
                    value = parts[1].strip()
                    options[key] = value
        
        alt = options.get('alt', '')
        width = options.get('width', '')
        align = options.get('align', 'center')
        
        img_tag = f'<img src="{url}"'
        if alt:
            img_tag += f' alt="{alt}"'
        if width:
            img_tag += f' width="{width}"'
        img_tag += '>'
        
        if align:
            return f'<div align="{align}">\n  {img_tag}\n</div>'
        else:
            return img_tag

    return re.sub(pattern, replace_func, content, flags=re.DOTALL)

def process_notebook(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        nb = json.load(f)
    
    changed = False
    for cell in nb.get('cells', []):
        if cell.get('cell_type') == 'markdown':
            source = "".join(cell.get('source', []))
            new_source = convert_myst_to_html(source)
            if new_source != source:
                # Jupyter expects a list of strings ending with \n
                # but it also accepts a single string. 
                # To be safe and consistent with common formats:
                split_source = [line + '\n' for line in new_source.split('\n')]
                # Fix the last line's \n if it was empty
                if split_source and split_source[-1] == '\n':
                    split_source.pop()
                elif split_source and not split_source[-1].endswith('\n'):
                    # This happens if there's no trailing newline in new_source
                    pass
                else:
                    # Clean up trailing \n issue
                    if split_source:
                        split_source[-1] = split_source[-1].rstrip('\n')

                cell['source'] = [line + '\n' for line in new_source.splitlines()]
                # Actually, many notebooks just use a list of lines including the \n
                # Let's do it exactly:
                new_source_lines = []
                lines = new_source.split('\n')
                for i, line in enumerate(lines):
                    if i < len(lines) - 1:
                        new_source_lines.append(line + '\n')
                    else:
                        new_source_lines.append(line)
                cell['source'] = new_source_lines
                changed = True
    
    if changed:
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(nb, f, indent=1)
        print(f"Successfully updated {filepath}")
    else:
        print(f"No changes made to {filepath}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python convert.py <notebook_path>")
    else:
        process_notebook(sys.argv[1])
