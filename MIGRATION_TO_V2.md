# Migration to Jupyter Book v2

This document describes the migration from Jupyter Book v1 to v2.

## Key Changes

### Configuration Files

**Removed:**
- `_config.yml` - v1 configuration file (backed up as `_config.yml.bak`)
- `_toc.yml` - v1 table of contents file (backed up as `_toc.yml.bak`)

**Added:**
- `myst.yml` - v2 configuration file that combines project settings, site options, and table of contents

### Build System

**Jupyter Book v1:**
```bash
jupyter-book build . --all
```

**Jupyter Book v2:**
```bash
jupyter book build --html
```

### Configuration Structure

The new `myst.yml` file uses a different structure:

- **Project settings**: Title, authors, copyright, GitHub repo, bibliography
- **Table of contents**: Nested structure with titles and children
- **Site options**: Logo, favicon, template
- **Exports**: PDF and other export formats

### GitHub Actions Workflow

Updated `.github/workflows/deploy-book.yml`:
- Changed build command to `jupyter book build --html`
- Updated trigger branch to `jupyter-book-v2`
- Set BASE_URL to `/SPISv2` for deployment path
- Output is still in `_build/html`

### Dependencies

Updated `requirements.txt`:
- Changed from `jupyter-book` to `jupyter-book>=2.0.0`

## Deployment

The book is configured to be deployed to: **https://med-aau-cph.github.io/SPISv2**

**Note**: The deployment URL uses the `med-aau-cph` organization, which is different from the repository's `SMC-AAU-CPH` organization. This may require additional GitHub Pages configuration or a separate deployment setup outside of this repository.

When changes are pushed to the `jupyter-book-v2` branch, GitHub Actions will:
1. Install dependencies (including jupyter-book v2)
2. Build the book using MyST
3. Deploy to GitHub Pages

## Local Development

To build the book locally:

1. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

2. Build the HTML version:
   ```bash
   jupyter book build --html
   ```

3. The built site will be in `_build/html/`

4. To preview locally, you can use:
   ```bash
   jupyter book start
   ```

## Additional Resources

- [MyST Documentation](https://mystmd.org)
- [Jupyter Book v2 Documentation](https://jupyterbook.org)
- [Migration Guide](https://mystmd.org/guide/quickstart-jupyter-book-classic)

## Notes

- All content files remain unchanged - only configuration has been migrated
- The table of contents structure has been preserved
- Bibliography support is maintained through `cerkut.bib`
- External links (like Librosa documentation) are still supported
