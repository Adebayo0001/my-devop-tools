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
$VaultSource = Join-Path $RepoRoot 'design-vault'

if (-not (Test-Path $Source)) {
    Write-Error "Source skills directory not found at $Source"
    exit 1
}

Write-Host '==========================================================' -ForegroundColor Cyan
Write-Host ' Master DevOps Skills & Design Vault Synchronization' -ForegroundColor Cyan
Write-Host " Skills Source: $Source" -ForegroundColor Gray
if (Test-Path $VaultSource) {
    Write-Host " Vault Source:  $VaultSource" -ForegroundColor Gray
}
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
$AntigravityVault = Join-Path $HOME '.gemini\config\design-vault'
$AntigravityRules = Join-Path $HOME '.gemini\config\rules'
$MasterRuleFile = Join-Path $RepoRoot '05-Global-IDE-Master-Rule\GLOBAL_IDE_MASTER_RULE.md'

try {
    if (-not (Test-Path $AntigravityTarget)) {
        New-Item -ItemType Directory -Force -Path $AntigravityTarget | Out-Null
    }
    cmd.exe /c xcopy /E /I /Y "$Source" "$AntigravityTarget" | Out-Null
    if (Test-Path $VaultSource) {
        if (-not (Test-Path $AntigravityVault)) {
            New-Item -ItemType Directory -Force -Path $AntigravityVault | Out-Null
        }
        cmd.exe /c xcopy /E /I /Y "$VaultSource" "$AntigravityVault" | Out-Null
    }
    if (Test-Path $MasterRuleFile) {
        if (-not (Test-Path $AntigravityRules)) {
            New-Item -ItemType Directory -Force -Path $AntigravityRules | Out-Null
        }
        Copy-Item -Force "$MasterRuleFile" (Join-Path $AntigravityRules 'GEMINI.md')
        Copy-Item -Force "$MasterRuleFile" (Join-Path $HOME '.gemini\config\GEMINI.md')
    }
    Write-Host " [OK] Antigravity IDE synced (Skills, Rules & Vault) -> $AntigravityTarget" -ForegroundColor Green
} catch {
    Write-Warning " [!] Failed to sync to Antigravity: $_"
}

# 2. Claude Code CLI
$ClaudeTarget = Join-Path $HOME '.claude\skills'
$ClaudeVault = Join-Path $HOME '.claude\design-vault'
$ClaudeRules = Join-Path $HOME '.claude'
try {
    if (-not (Test-Path $ClaudeTarget)) {
        New-Item -ItemType Directory -Force -Path $ClaudeTarget | Out-Null
    }
    cmd.exe /c xcopy /E /I /Y "$Source" "$ClaudeTarget" | Out-Null
    if (Test-Path $VaultSource) {
        if (-not (Test-Path $ClaudeVault)) {
            New-Item -ItemType Directory -Force -Path $ClaudeVault | Out-Null
        }
        cmd.exe /c xcopy /E /I /Y "$VaultSource" "$ClaudeVault" | Out-Null
    }
    if (Test-Path $MasterRuleFile) {
        Copy-Item -Force "$MasterRuleFile" (Join-Path $ClaudeRules 'CLAUDE.md')
    }
    Write-Host " [OK] Claude Code synced (Skills, Rules & Vault) -> $ClaudeTarget" -ForegroundColor Green
} catch {
    Write-Warning " [!] Failed to sync to Claude Code: $_"
}

# 3. Cursor Rules Global
$CursorTarget = Join-Path $HOME '.cursor\rules'
$CursorVault = Join-Path $HOME '.cursor\design-vault'
try {
    if (-not (Test-Path $CursorTarget)) {
        New-Item -ItemType Directory -Force -Path $CursorTarget | Out-Null
    }
    cmd.exe /c xcopy /E /I /Y "$Source" "$CursorTarget" | Out-Null
    if (Test-Path $VaultSource) {
        if (-not (Test-Path $CursorVault)) {
            New-Item -ItemType Directory -Force -Path $CursorVault | Out-Null
        }
        cmd.exe /c xcopy /E /I /Y "$VaultSource" "$CursorVault" | Out-Null
    }
    if (Test-Path $MasterRuleFile) {
        Copy-Item -Force "$MasterRuleFile" (Join-Path $CursorTarget 'global-master-rule.mdc')
    }
    Write-Host " [OK] Cursor synced (Rules & Vault) -> $CursorTarget" -ForegroundColor Green
} catch {
    Write-Warning " [!] Failed to sync to Cursor: $_"
}

# 4. Windsurf Global Rules / Skills
$WindsurfTarget = Join-Path $HOME '.codeium\windsurf\skills'
$WindsurfVault = Join-Path $HOME '.codeium\windsurf\design-vault'
$WindsurfRules = Join-Path $HOME '.codeium\windsurf\rules'
try {
    if (-not (Test-Path $WindsurfTarget)) {
        New-Item -ItemType Directory -Force -Path $WindsurfTarget | Out-Null
    }
    cmd.exe /c xcopy /E /I /Y "$Source" "$WindsurfTarget" | Out-Null
    if (Test-Path $VaultSource) {
        if (-not (Test-Path $WindsurfVault)) {
            New-Item -ItemType Directory -Force -Path $WindsurfVault | Out-Null
        }
        cmd.exe /c xcopy /E /I /Y "$VaultSource" "$WindsurfVault" | Out-Null
    }
    if (Test-Path $MasterRuleFile) {
        if (-not (Test-Path $WindsurfRules)) {
            New-Item -ItemType Directory -Force -Path $WindsurfRules | Out-Null
        }
        Copy-Item -Force "$MasterRuleFile" (Join-Path $WindsurfRules 'global.windsurfrules')
    }
    Write-Host " [OK] Windsurf synced (Skills, Rules & Vault) -> $WindsurfTarget" -ForegroundColor Green
} catch {
    Write-Warning " [!] Failed to sync to Windsurf: $_"
}

# 5. Local Repo .agents/ Architecture Shim
$LocalAgentsDir = Join-Path $RepoRoot '.agents'
$LocalAgentsRules = Join-Path $LocalAgentsDir 'rules'
try {
    if (-not (Test-Path $LocalAgentsRules)) {
        New-Item -ItemType Directory -Force -Path $LocalAgentsRules | Out-Null
    }
    if (Test-Path $MasterRuleFile) {
        Copy-Item -Force "$MasterRuleFile" (Join-Path $LocalAgentsRules 'AGENTS.md')
        Copy-Item -Force "$MasterRuleFile" (Join-Path $LocalAgentsRules 'GEMINI.md')
    }
    # Multi-IDE Root Shims
    $ClaudeShim = Join-Path $RepoRoot 'CLAUDE.md'
    $CursorShim = Join-Path $RepoRoot '.cursorrules'
    $WindsurfShim = Join-Path $RepoRoot '.windsurfrules'
    $GeminiShim = Join-Path $RepoRoot 'GEMINI.md'
    if (Test-Path $MasterRuleFile) {
        if (-not (Test-Path $ClaudeShim)) { Copy-Item -Force "$MasterRuleFile" $ClaudeShim }
        if (-not (Test-Path $CursorShim)) { Copy-Item -Force "$MasterRuleFile" $CursorShim }
        if (-not (Test-Path $WindsurfShim)) { Copy-Item -Force "$MasterRuleFile" $WindsurfShim }
        if (-not (Test-Path $GeminiShim)) { Copy-Item -Force "$MasterRuleFile" $GeminiShim }
    }
    Write-Host " [OK] Local .agents/ architecture configured -> $LocalAgentsDir" -ForegroundColor Green
} catch {
    Write-Warning " [!] Failed to configure local .agents: $_"
}

Write-Host '==========================================================' -ForegroundColor Cyan
Write-Host ' All 14 skills successfully synchronized across your AI IDEs!' -ForegroundColor Cyan
Write-Host '  1. /kickoff                  (Discovery, UX research, 4-tier context generator)' -ForegroundColor White
Write-Host '  2. /intake                   (Tier 4 codebase audit and live site redesign)' -ForegroundColor White
Write-Host '  3. /redesign                 (Surgical UI elevation & human designer polish under Logic Freeze)' -ForegroundColor White
Write-Host '  4. /architect                (Spec-first blueprint, Atomic decomposition, persistent specs)' -ForegroundColor White
Write-Host '  5. /imprint                  (Living UI registry compiler and token check)' -ForegroundColor White
Write-Host '  6. /test                     (Autonomous git-diff test generator & classifier)' -ForegroundColor White
Write-Host '  7. /check                    (Dual-mode runtime verification & code review gate)' -ForegroundColor White
Write-Host '  8. /review                   (QA, zero-trust security and observability release gate)' -ForegroundColor White
Write-Host '  9. /document                 (Grounded technical writer: PRs, changelog, releases, postmortems)' -ForegroundColor White
Write-Host ' 10. /sync                     (Post-merge progress tracker & spec status synchronizer)' -ForegroundColor White
Write-Host ' 11. /recover                  (Circuit breaker on 1st failed bugfix & 3-tier RCA)' -ForegroundColor White
Write-Host ' 12. /remember                 (Cold session persistence to memory.md)' -ForegroundColor White
Write-Host ' 13. /broadcast                (Proof-of-work authority marketing & case studies)' -ForegroundColor White
Write-Host ' 14. adebayo-authority-engine  (Positioning, commercial offers and voice rules)' -ForegroundColor White
Write-Host '==========================================================' -ForegroundColor Cyan
