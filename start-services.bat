@echo off
REM Spring Cloud Services Startup Script for Windows
REM This script starts the Eureka server first, then the other services

echo 🚀 Starting Spring Cloud Services...

REM Create logs directory if it doesn't exist
if not exist logs mkdir logs

REM Start Eureka Server
echo 📡 Starting Eureka Server...
cd eureka
start "Eureka Server" cmd /c "gradlew.bat bootRun > ..\logs\eureka.log 2>&1"
cd ..

REM Wait for Eureka to start
timeout /t 10 /nobreak > nul

REM Start Sample Module
echo 🔧 Starting Sample Module...
cd sample-module
start "Sample Module" cmd /c "gradlew.bat bootRun > ..\logs\sample-module.log 2>&1"
cd ..

REM Wait for Sample Module to start
timeout /t 5 /nobreak > nul

REM Start Sample Service
echo 🌐 Starting Sample Service...
cd sample-service
start "Sample Service" cmd /c "gradlew.bat bootRun > ..\logs\sample-service.log 2>&1"
cd ..

REM Wait for Sample Service to start
timeout /t 5 /nobreak > nul

echo.
echo 🎉 All services started!
echo.
echo 📊 Service Status:
echo    Eureka Server:    http://localhost:8761
echo    Sample Module:    http://localhost:9000
echo    Sample Service:   http://localhost:9001
echo.
echo 📝 Logs are available in the logs\ directory
echo 🛑 To stop all services, run: stop-services.bat
echo.
echo Press any key to exit...
pause > nul 