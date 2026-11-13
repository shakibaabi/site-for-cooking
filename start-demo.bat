@echo off
setlocal
cd /d "%~dp0"
where node >nul 2>nul
if errorlevel 1 (
  echo Please install Node.js 20 or later first.
  pause
  exit /b 1
)
if not exist node_modules (
  call npm ci
  if errorlevel 1 exit /b 1
)
if not exist dist\index.html (
  call npm run build
  if errorlevel 1 exit /b 1
)
echo Demo: http://localhost:3000
echo Admin: admin / demo12345
call npm run demo
