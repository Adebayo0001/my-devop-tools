# ==============================================================================
# CLONE-EXTERNAL-REPOS.PS1 - Master Design Vault External Repositories Cloner
# Clones all 16 design intelligence and skill repositories locally to protect
# against upstream deletions, privatization, or breaking changes.
# ==============================================================================

[CmdletBinding()]
param(
    [string]$TargetDir,
    [switch]$FullHistory
)

$RepoRoot = $PSScriptRoot
if (-not $RepoRoot) {
    $RepoRoot = (Get-Location).Path
}

if (-not $TargetDir) {
    $TargetDir = Join-Path $RepoRoot "external-repos"
}

if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
}

$Repositories = @(
    @{ Name = "taste-skill";          Url = "https://github.com/Leonxlnx/taste-skill.git" },
    @{ Name = "mdxcn";                Url = "https://github.com/shadcn-labs/mdxcn.git" },
    @{ Name = "archify";              Url = "https://github.com/tt-a1i/archify.git" },
    @{ Name = "spectrum-ui";          Url = "https://github.com/arihantcodes/spectrum-ui.git" },
    @{ Name = "blocks-so";            Url = "https://github.com/ephraimduncan/blocks.git" },
    @{ Name = "superdesign-skill";    Url = "https://github.com/superdesigndev/superdesign-skill.git" },
    @{ Name = "better-design";        Url = "https://github.com/marvkr/better-design.git" },
    @{ Name = "design-taste";         Url = "https://github.com/madebymustafa/design-taste.git" },
    @{ Name = "canvas-ui";            Url = "https://github.com/DavidHDev/canvas-ui.git" },
    @{ Name = "paper-shaders";        Url = "https://github.com/paper-design/shaders.git" },
    @{ Name = "uilayouts";            Url = "https://github.com/ui-layouts/uilayouts.git" },
    @{ Name = "hyperiux-components";  Url = "https://github.com/Hyperiux-Immersion-Labs/hyperiux-components.git" },
    @{ Name = "cursify";              Url = "https://github.com/ui-layouts/cursify.git" },
    @{ Name = "trickle-UI-kit";       Url = "https://github.com/akaieuan/trickle-UI-kit.git" },
    @{ Name = "lucian-uxui";          Url = "https://github.com/Seokwoooo/lucian-uxui.git" },
    @{ Name = "ux-ui-agent-skills";   Url = "https://github.com/plugin87/ux-ui-agent-skills.git" }
)

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " Master Design Intelligence - Local Archive Cloner" -ForegroundColor Cyan
Write-Host " Destination Directory: $TargetDir" -ForegroundColor Gray
Write-Host " Total Repositories:    $($Repositories.Count)" -ForegroundColor Gray
Write-Host "==========================================================" -ForegroundColor Cyan

$SuccessCount = 0
$FailCount = 0

foreach ($repo in $Repositories) {
    $destination = Join-Path $TargetDir $repo.Name
    Write-Host ""
    Write-Host "[$($repo.Name)] Checking repository..." -ForegroundColor Yellow

    if (Test-Path $destination) {
        Write-Host " -> Folder exists. Pulling latest updates from $($repo.Url)..." -ForegroundColor DarkCyan
        try {
            $pull = git -C "$destination" pull --ff-only 2>&1
            Write-Host " [OK] Updated: $pull" -ForegroundColor Green
            $SuccessCount++
        } catch {
            Write-Warning " [!] Pull failed: $_"
            $FailCount++
        }
    } else {
        Write-Host " -> Cloning fresh copy from $($repo.Url)..." -ForegroundColor Cyan
        $cloneArgs = @("clone")
        if (-not $FullHistory) {
            $cloneArgs += "--depth"
            $cloneArgs += "1"
        }
        $cloneArgs += $repo.Url
        $cloneArgs += $destination

        $cloneOutput = & git $cloneArgs 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host " [OK] Successfully cloned $($repo.Name) to $destination" -ForegroundColor Green
            $SuccessCount++
        } else {
            Write-Warning " [!] Failed to clone $($repo.Name): $cloneOutput"
            $FailCount++
        }
    }
}

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " Archiving Summary: $SuccessCount succeeded, $FailCount failed." -ForegroundColor $(if ($FailCount -eq 0) { "Green" } else { "Yellow" })
Write-Host " All cloned source files are safely stored at: $TargetDir" -ForegroundColor Gray
Write-Host "==========================================================" -ForegroundColor Cyan
