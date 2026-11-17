# AW Schedule Manager - Antigravity Plugin Installer for PowerShell
$ErrorActionPreference = "Stop"

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "  AW Schedule Manager - Antigravity Plugin Installer" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

$sourceDir = $PSScriptRoot
$targetDir = Join-Path $env:USERPROFILE ".gemini\config\plugins\aw-schedule-manager"

Write-Host "[*] Target directory: $targetDir" -ForegroundColor Yellow

if (-not (Test-Path (Join-Path $env:USERPROFILE ".gemini\config\plugins"))) {
    New-Item -ItemType Directory -Path (Join-Path $env:USERPROFILE ".gemini\config\plugins") -Force | Out-Null
}

Write-Host "[*] Copying plugin files..." -ForegroundColor Yellow
Copy-Item -Path "$sourceDir\*" -Destination $targetDir -Recurse -Force -Exclude ".git", "install.ps1", "install.bat"

Write-Host "[*] Configuring MCP server paths..." -ForegroundColor Yellow
$configPath = Join-Path $targetDir "mcp_config.json"
if (Test-Path $configPath) {
    $config = Get-Content $configPath -Raw | ConvertFrom-Json
    $exePath = Join-Path $targetDir "server\aw-schedule-manager.exe"
    $config.mcpServers.'aw-schedule-manager'.command = $exePath
    $config | ConvertTo-Json -Depth 10 | Set-Content $configPath -Encoding utf8
}

Write-Host ""
Write-Host "[OK] AW Schedule Manager installed successfully!" -ForegroundColor Green
Write-Host "[OK] Restart Google Antigravity to activate the plugin." -ForegroundColor Green
Write-Host ""
