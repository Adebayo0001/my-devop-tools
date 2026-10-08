# ==============================================================================
# SYNC-SKILLS.PS1 - Master AI IDE Skills Synchronization Engine
# Synchronizes your DevOps Skills Suite from My DevOp Tools to all Agentic IDEs
# Supported IDEs: Antigravity, Claude Code, Cursor, Windsurf, Codex
# ==============================================================================

[CmdletBinding()]
param(
    [switch]$SkipGitPull
)

# Resolve source skills directory relative to this script
$RepoRoot = $PSScriptRoot
if (-not $RepoRoot) {
    $RepoRoot = Get-Location
}
$Source = Join-Path $RepoRoot 'skills'

if (-not (Test-Path $Source)) {
    Write-Error "Source skills directory not found at $Source"
    exit 1
}

Write-Host '==========================================================' -ForegroundColor Cyan
Write-Host ' Master DevOps Skills Suite - Synchronization Engine' -ForegroundColor Cyan
Write-Host " Source: $Source" -ForegroundColor Gray
Write-Host '==========================================================' -ForegroundColor Cyan

# 0. Check for Git Upstream Updates (if in a Git clone)
if (-not $SkipGitPull -and (Test-Path (Join-Path $RepoRoot '.git'))) {
    Write-Host "Checking for latest updates from remote Git repository..." -ForegroundColor Yellow
    try {
        $pullOutput = git -C "$RepoRoot" pull --ff-only 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host " [OK] Local repository is up to date with remote." -ForegroundColor Green
        } else {
            Write-Host " [!] Git pull notice: $pullOutput" -ForegroundColor DarkYellow
        }
    } catch {
        Write-Warning " [!] Git check skipped: $_"
    }
}

# 1. Google Antigravity IDE (Gemini CLI / Antigravity IDE)
$AntigravityTarget = Join-Path $HOME '.gemini\config\skills'
try {
    if (-not (Test-Path $AntigravityTarget)) {
        New-Item -ItemType Directory -Force -Path $AntigravityTarget | Out-Null
    }
    cmd.exe /c xcopy /E /I /Y "$Source" "$AntigravityTarget" | Out-Null
    Write-Host " [OK] Antigravity IDE synced -> $AntigravityTarget" -ForegroundColor Green
} catch {
    Write-Warning " [!] Failed to sync to Antigravity: $_"
}

# 2. Claude Code CLI
$ClaudeTarget = Join-Path $HOME '.claude\skills'
try {
    if (-not (Test-Path $ClaudeTarget)) {
        New-Item -ItemType Directory -Force -Path $ClaudeTarget | Out-Null
    }
    cmd.exe /c xcopy /E /I /Y "$Source" "$ClaudeTarget" | Out-Null
    Write-Host " [OK] Claude Code synced -> $ClaudeTarget" -ForegroundColor Green
} catch {
    Write-Warning " [!] Failed to sync to Claude Code: $_"
}

# 3. Cursor Rules Global
$CursorTarget = Join-Path $HOME '.cursor\rules'
try {
    if (-not (Test-Path $CursorTarget)) {
        New-Item -ItemType Directory -Force -Path $CursorTarget | Out-Null
    }
    cmd.exe /c xcopy /E /I /Y "$Source" "$CursorTarget" | Out-Null
    Write-Host " [OK] Cursor Rules synced -> $CursorTarget" -ForegroundColor Green
} catch {
    Write-Warning " [!] Failed to sync to Cursor: $_"
}

# 4. Windsurf Global Rules / Skills
$WindsurfTarget = Join-Path $HOME '.codeium\windsurf\skills'
try {
    if (-not (Test-Path $WindsurfTarget)) {
        New-Item -ItemType Directory -Force -Path $WindsurfTarget | Out-Null
    }
    cmd.exe /c xcopy /E /I /Y "$Source" "$WindsurfTarget" | Out-Null
    Write-Host " [OK] Windsurf synced -> $WindsurfTarget" -ForegroundColor Green
} catch {
    Write-Warning " [!] Failed to sync to Windsurf: $_"
}

Write-Host '==========================================================' -ForegroundColor Cyan
Write-Host ' All 9 skills successfully synchronized across your AI IDEs!' -ForegroundColor Cyan
Write-Host '  1. /kickoff                  (Discovery, UX research, 4-tier context generator)' -ForegroundColor White
Write-Host '  2. /intake                   (Tier 4 codebase audit and live site redesign)' -ForegroundColor White
Write-Host '  3. /architect                (Spec-first blueprint, Atomic decomposition, APM)' -ForegroundColor White
Write-Host '  4. /imprint                  (Living UI registry compiler and token check)' -ForegroundColor White
Write-Host '  5. /review                   (QA, zero-trust security and observability gate)' -ForegroundColor White
Write-Host '  6. /recover                  (Circuit breaker on 1st failed bugfix)' -ForegroundColor White
Write-Host '  7. /remember                 (Cold session persistence to memory.md)' -ForegroundColor White
Write-Host '  8. /broadcast                (Proof-of-work 4 daily posts generator)' -ForegroundColor White
Write-Host '  9. adebayo-authority-engine  (Positioning, commercial offers and voice rules)' -ForegroundColor White
Write-Host '==========================================================' -ForegroundColor Cyan
