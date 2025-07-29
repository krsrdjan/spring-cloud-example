#!/bin/bash

# Spring Cloud Services Stop Script
# This script stops all running services

echo "🛑 Stopping Spring Cloud Services..."

# Function to stop a service by PID file
stop_service() {
    local pid_file=$1
    local service_name=$2
    
    if [ -f "$pid_file" ]; then
        local pid=$(cat "$pid_file")
        if kill -0 "$pid" 2>/dev/null; then
            echo "🛑 Stopping $service_name (PID: $pid)..."
            kill "$pid"
            sleep 2
            if kill -0 "$pid" 2>/dev/null; then
                echo "⚠️  Force killing $service_name..."
                kill -9 "$pid"
            fi
            rm "$pid_file"
            echo "✅ $service_name stopped"
        else
            echo "ℹ️  $service_name is not running"
            rm "$pid_file"
        fi
    else
        echo "ℹ️  No PID file found for $service_name"
    fi
}

# Stop all services
stop_service "logs/eureka.pid" "Eureka Server"
stop_service "logs/book-store.pid" "Book Store"
stop_service "logs/sample-service.pid" "Sample Service"

# Clean up any remaining processes by port
echo "🧹 Cleaning up any remaining processes..."

# Kill processes on specific ports
for port in 8761 9000 9001; do
    pid=$(lsof -ti:$port 2>/dev/null)
    if [ ! -z "$pid" ]; then
        echo "🛑 Killing process on port $port (PID: $pid)"
        kill -9 "$pid" 2>/dev/null
    fi
done

echo "✅ All services stopped"
echo "🧹 Cleaning up logs directory..."
rm -rf logs/

echo "🎉 Cleanup complete!" 