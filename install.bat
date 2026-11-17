@echo off
setlocal enabledelayedexpansion

echo ========================================================
echo   AW Schedule Manager - Antigravity Plugin Installer
echo ========================================================
echo.

set "SOURCE_DIR=%~dp0"
set "TARGET_DIR=%USERPROFILE%\.gemini\config\plugins\aw-schedule-manager"

echo [*] Installing to: %TARGET_DIR%
if not exist "%USERPROFILE%\.gemini\config\plugins" (
    mkdir "%USERPROFILE%\.gemini\config\plugins" 2>nul
)

echo [*] Copying plugin files...
xcopy "%SOURCE_DIR%*" "%TARGET_DIR%\" /E /I /Y /Q /EXCLUDE:%SOURCE_DIR%exclude.txt >nul 2>&1
if errorlevel 1 (
    xcopy "%SOURCE_DIR%*" "%TARGET_DIR%\" /E /I /Y /Q >nul
)

echo [*] Configuring MCP paths...
powershell -NoProfile -Command ^
  "$path = '%TARGET_DIR%\mcp_config.json'; " ^
  "$json = Get-Content $path -Raw | ConvertFrom-Json; " ^
  "$exe = Join-Path '%TARGET_DIR%' 'server\aw-schedule-manager.exe'; " ^
  "$json.mcpServers.'aw-schedule-manager'.command = $exe; " ^
  "$json | ConvertTo-Json -Depth 10 | Set-Content $path -Encoding utf8"

echo.
echo [OK] AW Schedule Manager plugin installed successfully!
echo [OK] Restart Google Antigravity to begin managing your Primavera P6 schedules.
echo.
pause
