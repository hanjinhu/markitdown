# Installing markitdown into a project

`install_markitdown.ps1` installs this local clone of markitdown into whichever
Python environment you're targeting — no need to repeat the install steps for
each repo.

## Prerequisites

- Windows PowerShell 5.1+ or PowerShell 7+
- The repo cloned at `C:\Repos\markitdown` (already done if you're reading this)
- Python 3.10+

```powershell
pip install -e "C:\Repos\markitdown\packages\markitdown[pdf,docx,pptx,xlsx,xls,outlook]"
```

If PowerShell blocks the script on first run, allow local scripts once:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

## Usage

### Install into a repo's `.venv` (most common)

Navigate to the repo root, then run the script. It detects `.venv` automatically.

```powershell
cd C:\Repos\your-repo
& "C:\Repos\markitdown\install_markitdown.ps1"
```

### Install into a specific pip

Use `-PipPath` to target any pip executable directly.

```powershell
& "C:\Repos\markitdown\install_markitdown.ps1" -PipPath "C:\Python312\Scripts\pip.exe"
```

### Install into system Python (no venv)

Run from any directory that does **not** have a `.venv` folder:

```powershell
cd C:\
& "C:\Repos\markitdown\install_markitdown.ps1"
```

## What gets installed

The script installs these extras (covers most document types):

| Extra     | File types                        |
| :-------- | :-------------------------------- |
| `pdf`     | `.pdf`                            |
| `docx`    | `.docx`, `.doc` (Word)            |
| `pptx`    | `.pptx` (PowerPoint)              |
| `xlsx`    | `.xlsx` (Excel)                   |
| `xls`     | `.xls` (older Excel)              |
| `outlook` | `.msg` (Outlook messages)         |

`[youtube-transcription]` is intentionally excluded — `youtube-transcript-api~=1.0.0`
does not exist on PyPI (versions skip from 0.6.x to 1.2.x).

To add more extras later (e.g. audio transcription):

```powershell
pip install -e "C:\Repos\markitdown\packages\markitdown[audio-transcription]"
```

## Verifying the install

```python
from markitdown import MarkItDown

md = MarkItDown()
result = md.convert(r"C:\path\to\file.pdf")
print(result.markdown)
```
