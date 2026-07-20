# Installs every skill folder under skills/ into Codex's user skills directory.
$src = Join-Path $PSScriptRoot "..\skills"
$dest = Join-Path $env:USERPROFILE ".codex\skills"

New-Item -ItemType Directory -Force -Path $dest | Out-Null

Get-ChildItem -Path $src -Directory | ForEach-Object {
    $target = Join-Path $dest $_.Name
    Write-Host "Installing $($_.Name) -> $target"
    Copy-Item -Path $_.FullName -Destination $target -Recurse -Force
}

Write-Host "Done. Installed to $dest"
