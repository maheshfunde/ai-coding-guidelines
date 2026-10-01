<#
.SYNOPSIS
    Universal AI Skills Installer for Windows PowerShell.
.DESCRIPTION
    Installs UI/UX and Backend Architecture skills for Antigravity, Claude Code, Cursor, Copilot, Windsurf, or Cline.
#>
param(
    [string]$Target = "interactive",
    [string]$WorkspacePath = (Get-Location).Path
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not (Test-Path "$ScriptDir\skills")) {
    $ScriptDir = Get-Location
}

function Show-Header {
    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "       Universal AI Skills & Architecture Installer        " -ForegroundColor Yellow
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "Works with: Antigravity, Claude Code, Cursor, Copilot, Windsurf" -ForegroundColor Gray
    Write-Host ""
}

function Install-Antigravity {
    $dest = "$env:USERPROFILE\.gemini\config\skills"
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    Copy-Item -Path "$ScriptDir\skills\*" -Destination $dest -Recurse -Force
    Write-Host "[✓] Installed for Antigravity IDE globally: $dest" -ForegroundColor Green
}

function Install-ClaudeCode {
    $dest = "$env:USERPROFILE\.claude\skills"
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    Copy-Item -Path "$ScriptDir\skills\*" -Destination $dest -Recurse -Force
    Write-Host "[✓] Installed for Claude Code globally: $dest" -ForegroundColor Green
}

function Install-Workspace {
    param([string]$path)
    if (-not (Test-Path $path)) {
        Write-Host "[!] Path does not exist: $path" -ForegroundColor Red
        return
    }

    # 1. Antigravity / Agent skills
    $agentsDir = Join-Path $path ".agents\skills"
    New-Item -ItemType Directory -Force -Path $agentsDir | Out-Null
    Copy-Item -Path "$ScriptDir\skills\*" -Destination $agentsDir -Recurse -Force

    # 2. Cursor rules
    $cursorDir = Join-Path $path ".cursor\rules"
    New-Item -ItemType Directory -Force -Path $cursorDir | Out-Null
    Copy-Item -Path "$ScriptDir\.cursor\rules\*.mdc" -Destination $cursorDir -Force
    Copy-Item -Path "$ScriptDir\.cursorrules" -Destination $path -Force

    # 3. Claude Code
    Copy-Item -Path "$ScriptDir\CLAUDE.md" -Destination $path -Force

    # 4. GitHub Copilot
    $githubDir = Join-Path $path ".github"
    New-Item -ItemType Directory -Force -Path $githubDir | Out-Null
    Copy-Item -Path "$ScriptDir\.github\copilot-instructions.md" -Destination $githubDir -Force

    # 5. Windsurf & Cline
    Copy-Item -Path "$ScriptDir\.windsurfrules" -Destination $path -Force
    Copy-Item -Path "$ScriptDir\.clinerules" -Destination $path -Force

    Write-Host "[✓] Configured project workspace: $path" -ForegroundColor Green
    Write-Host "    - Antigravity: .agents/skills/" -ForegroundColor DarkGray
    Write-Host "    - Cursor: .cursor/rules/ & .cursorrules" -ForegroundColor DarkGray
    Write-Host "    - Claude: CLAUDE.md" -ForegroundColor DarkGray
    Write-Host "    - GitHub Copilot: .github/copilot-instructions.md" -ForegroundColor DarkGray
    Write-Host "    - Windsurf & Cline: .windsurfrules, .clinerules" -ForegroundColor DarkGray
}

Show-Header

if ($Target -eq "all") {
    Install-Antigravity
    Install-ClaudeCode
    Install-Workspace -path $WorkspacePath
    Write-Host "`nAll AI targets configured successfully!" -ForegroundColor Cyan
    exit 0
}

if ($Target -eq "antigravity") { Install-Antigravity; exit 0 }
if ($Target -eq "claude") { Install-ClaudeCode; exit 0 }
if ($Target -eq "workspace") { Install-Workspace -path $WorkspacePath; exit 0 }

# Interactive menu
Write-Host "Select installation target:" -ForegroundColor White
Write-Host "  1) Antigravity IDE (Global ~/.gemini/config/skills)"
Write-Host "  2) Claude Code (Global ~/.claude/skills)"
Write-Host "  3) Current Project Workspace (Cursor, Claude, Copilot, Antigravity, Windsurf)"
Write-Host "  4) Everything (Global + Current Project)"
Write-Host "  q) Quit"
Write-Host ""
$choice = Read-Host "Enter option [1-4]"

switch ($choice) {
    "1" { Install-Antigravity }
    "2" { Install-ClaudeCode }
    "3" { Install-Workspace -path $WorkspacePath }
    "4" {
        Install-Antigravity
        Install-ClaudeCode
        Install-Workspace -path $WorkspacePath
    }
    Default { Write-Host "Exiting without changes." -ForegroundColor Yellow }
}
