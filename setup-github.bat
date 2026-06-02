@echo off
cd /d "%~dp0"

echo Cleaning up any stale git locks...
if exist .git\config.lock del /f .git\config.lock
if exist .git\index.lock del /f .git\index.lock

echo Checking git status...
git status >nul 2>&1
if errorlevel 128 (
  echo Initializing git repo...
  git init
)

echo Configuring git...
git config user.email "manumaidana988@gmail.com"
git config user.name "Manu"

echo Staging all files...
git add -A

echo Committing...
git commit -m "Initial commit" 2>nul || echo (nothing new to commit, continuing)

echo Creating GitHub repo and pushing...
gh repo create burgas --public --source=. --remote=origin --push

echo.
echo Done! Check the output above for your repo URL.
pause
