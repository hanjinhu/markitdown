# Install markitdown from local clone into the current repo's venv (or system Python).
#
# Usage:
#   From any repo root:  & "C:\Repos\markitdown\install_markitdown.ps1"
#   With explicit pip:   & "C:\Repos\markitdown\install_markitdown.ps1" -PipPath "C:\Python312\Scripts\pip.exe"
#
# Skips [youtube-transcription] — youtube-transcript-api~=1.0.0 does not exist on PyPI.

param(
    [string]$PipPath = ""
)

$MARKITDOWN_SRC = "C:\Repos\markitdown\packages\markitdown"
$EXTRAS = "pdf,docx,pptx,xlsx,xls,outlook"

# Resolve pip to use
if ($PipPath -ne "") {
    $pip = $PipPath
} elseif (Test-Path ".\.venv\Scripts\pip.exe") {
    $pip = Resolve-Path ".\.venv\Scripts\pip.exe"
    Write-Host "Using local venv: $pip"
} elseif (Test-Path ".\.venv\bin\pip") {
    $pip = Resolve-Path ".\.venv\bin\pip"
    Write-Host "Using local venv: $pip"
} else {
    $pip = "pip"
    Write-Host "No .venv found — using system pip"
}

Write-Host ""
Write-Host "Installing markitdown[$EXTRAS] from $MARKITDOWN_SRC ..."
Write-Host ""

& $pip install -e "$MARKITDOWN_SRC[$EXTRAS]"

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Done. markitdown installed successfully."
} else {
    Write-Host ""
    Write-Host "Installation failed. Check the output above."
    exit 1
}
