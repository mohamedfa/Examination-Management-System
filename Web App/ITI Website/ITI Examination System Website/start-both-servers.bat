@echo off
:: ========================================
:: Starting ITI Examination System Servers
:: ========================================
::
:: This will start both backend and frontend servers
:: Backend: http://localhost:3000
:: Frontend: http://localhost:5500 (from new-version)
::
:: Press any key to continue...
pause >nul

REM Check if we're in the correct directory
if not exist "backend\package.json" (
    echo Error: package.json not found in backend directory
    echo Please run this script from the ITI Examination System Website directory
    pause
    exit /b 1
)

if not exist "new-version\index.html" (
    echo Error: index.html not found in new-version directory
    echo Please make sure the new-version folder exists and contains the frontend files
    pause
    exit /b 1
)

echo Starting backend server in a new window...
start "ITI Backend Server" cmd /k "cd /d %~dp0backend && npm start"

echo Waiting 3 seconds for backend to start...
timeout /t 3 /nobreak >nul

echo Starting frontend server in a new window (from new-version)...
start "ITI Frontend Server" cmd /k "cd /d %~dp0new-version && npx http-server -p 5500 -o"

echo.
echo Both servers are starting...
echo Backend: http://localhost:3000
echo Frontend: http://localhost:5500 (from new-version)
echo.
echo Close the command windows to stop the servers
echo.
pause 