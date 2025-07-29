@echo off
REM Spring Cloud Services Stop Script for Windows
REM This script stops all running services

echo 🛑 Stopping Spring Cloud Services...

REM Kill Java processes that might be our services
echo 🛑 Stopping Java processes...
taskkill /f /im java.exe 2>nul

REM Kill processes on specific ports
echo 🧹 Cleaning up processes on service ports...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :8761') do taskkill /f /pid %%a 2>nul
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :9000') do taskkill /f /pid %%a 2>nul
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :9001') do taskkill /f /pid %%a 2>nul

REM Clean up logs directory
echo 🧹 Cleaning up logs directory...
if exist logs rmdir /s /q logs

echo ✅ All services stopped
echo 🎉 Cleanup complete!
pause 