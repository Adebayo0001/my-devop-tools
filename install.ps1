# ==============================================================================
# INSTALL.PS1 - Universal One-Line Installer & Sync for DevOps Skills Suite
# Run remotely: irm https://raw.githubusercontent.com/Adebayo0001/my-devop-tools/main/install.ps1 | iex
# Or run locally: powershell -ExecutionPolicy Bypass -File .\install.ps1
# ==============================================================================

[CmdletBinding()]
param(
    [string]$RepoUrl = "https://github.com/Adebayo0001/my-devop-tools.git",
    [string]$InstallDir = (Join-Path $HOME "My-DevOp-Tools")
)

Write-Host '==========================================================' -ForegroundColor Cyan
Write-Host ' Master DevOps Skills Suite - Universal Installer' -ForegroundColor Cyan
Write-Host '==========================================================' -ForegroundColor Cyan

# Check if running from within an existing clone
if ($PSScriptRoot -and (Test-Path (Join-Path $PSScriptRoot 'skills'))) {
    $SyncScript = Join-Path $PSScriptRoot 'sync-skills.ps1'
    Write-Host "Running local sync from $PSScriptRoot..." -ForegroundColor Green
    & $SyncScript
    exit 0
}

# Verify Git is available
$GitCmd = Get-Command git -ErrorAction SilentlyContinue
if (-not $GitCmd) {
    Write-Error "Git is required to install and keep the DevOps Skills Suite updated. Please install Git (https://git-scm.com/) and run this installer again."
    exit 1
}

# Clone or update the repository
if (-not (Test-Path $InstallDir)) {
    Write-Host "Cloning master DevOps tools into $InstallDir..." -ForegroundColor Yellow
    git clone $RepoUrl $InstallDir
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to clone repository from $RepoUrl."
        exit 1
    }
} else {
    Write-Host "Repository exists at $InstallDir. Pulling latest updates..." -ForegroundColor Yellow
    git -C $InstallDir pull --ff-only
}

# Run the synchronization script
$SyncScript = Join-Path $InstallDir 'sync-skills.ps1'
if (Test-Path $SyncScript) {
    & $SyncScript
} else {
    Write-Error "sync-skills.ps1 not found in $InstallDir"
    exit 1
}

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Green
Write-Host " Installation & Synchronization Complete!" -ForegroundColor Green
Write-Host " Whenever you need to update to the latest skills, run:" -ForegroundColor Cyan
Write-Host "   powershell -ExecutionPolicy Bypass -File `"$InstallDir\sync-skills.ps1`"" -ForegroundColor White
Write-Host "==========================================================" -ForegroundColor Green
