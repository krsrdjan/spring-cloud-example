#!/bin/bash

# Spring Cloud Services Startup Script
# This script starts the Eureka server first, then the other services

echo "🚀 Starting Spring Cloud Services..."

# Function to check if a service is running on a specific port
check_service() {
    local port=$1
    local service_name=$2
    local max_attempts=30
    local attempt=1
    
    echo "⏳ Waiting for $service_name to be ready on port $port..."
    
    while [ $attempt -le $max_attempts ]; do
        if curl -s http://localhost:$port > /dev/null 2>&1; then
            echo "✅ $service_name is ready on port $port"
            return 0
        fi
        echo "   Attempt $attempt/$max_attempts - waiting..."
        sleep 2
        ((attempt++))
    done
    
    echo "❌ $service_name failed to start on port $port"
    return 1
}

# Start Eureka Server
echo "📡 Starting Eureka Server..."
cd eureka
./gradlew bootRun > ../logs/eureka.log 2>&1 &
EUREKA_PID=$!
cd ..

# Wait for Eureka to be ready
sleep 5
if check_service 8761 "Eureka Server"; then
    echo "✅ Eureka Server started successfully"
else
    echo "❌ Eureka Server failed to start"
    exit 1
fi

# Start Book Store
echo "📚 Starting Book Store..."
cd book-store
./gradlew bootRun > ../logs/book-store.log 2>&1 &
BOOK_STORE_PID=$!
cd ..

# Wait for Book Store to be ready
sleep 3
if check_service 9000 "Book Store"; then
    echo "✅ Book Store started successfully"
else
    echo "❌ Book Store failed to start"
fi

# Start Sample Service
echo "🌐 Starting Sample Service..."
cd sample-service
./gradlew bootRun > ../logs/sample-service.log 2>&1 &
SAMPLE_SERVICE_PID=$!
cd ..

# Wait for Sample Service to be ready
sleep 3
if check_service 9001 "Sample Service"; then
    echo "✅ Sample Service started successfully"
else
    echo "❌ Sample Service failed to start"
fi

# Create logs directory if it doesn't exist
mkdir -p logs

# Save PIDs for cleanup
echo $EUREKA_PID > logs/eureka.pid
echo $BOOK_STORE_PID > logs/book-store.pid
echo $SAMPLE_SERVICE_PID > logs/sample-service.pid

echo ""
echo "🎉 All services started!"
echo ""
echo "📊 Service Status:"
echo "   Eureka Server:    http://localhost:8761"
echo "   Book Store:       http://localhost:9000"
echo "   Sample Service:   http://localhost:9001"
echo ""
echo "📝 Logs are available in the logs/ directory"
echo "🛑 To stop all services, run: ./stop-services.sh"
echo ""
echo "Press Ctrl+C to stop all services"

# Function to cleanup on exit
cleanup() {
    echo ""
    echo "🛑 Stopping all services..."
    
    if [ -f logs/eureka.pid ]; then
        kill $(cat logs/eureka.pid) 2>/dev/null
        rm logs/eureka.pid
    fi
    
    if [ -f logs/book-store.pid ]; then
        kill $(cat logs/book-store.pid) 2>/dev/null
        rm logs/book-store.pid
    fi
    
    if [ -f logs/sample-service.pid ]; then
        kill $(cat logs/sample-service.pid) 2>/dev/null
        rm logs/sample-service.pid
    fi
    
    echo "✅ All services stopped"
    exit 0
}

# Set trap to cleanup on script exit
trap cleanup SIGINT SIGTERM

# Keep script running
wait 