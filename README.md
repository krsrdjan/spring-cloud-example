# spring-cloud-example
Spring cloud microservice repo example

## Technology Stack
- **Java**: 21
- **Spring Boot**: 3.2.0
- **Spring Cloud**: 2023.0.0
- **Gradle**: 8.5

## Quick Start

### Option 1: Using Startup Scripts (Recommended)

#### Linux/Mac:
```bash
# Start all services
./start-services.sh

# Stop all services
./stop-services.sh
```

#### Windows:
```cmd
# Start all services
start-services.bat

# Stop all services
stop-services.bat
```

### Option 2: Manual Startup

1. **Start Eureka Server:**
   ```bash
   cd eureka
   ./gradlew bootRun
   ```
   Then goto http://localhost:8761 to see the Eureka dashboard.

2. **Start Book Store:**
   ```bash
   cd book-store
   ./gradlew bootRun
   ```

3. **Start Sample Service:**
   ```bash
   cd sample-service
   ./gradlew bootRun
   ```

## Modules
- **eureka**: Service discovery server (port 8761)
- **sample-service**: REST microservice with circuit breaker (port 9001)
  - `GET /api/v1/hello` - Returns "Hello World!"
  - `GET /api/v1/user` - Returns personalized greeting
  - `GET /api/v1/test-broken-service` - Circuit breaker demo
- **book-store**: Spring Boot application with H2 database (port 9000)
  - H2 Console: http://localhost:9000/h2-console
  - Database: In-memory H2 database
  - Username: `sa` (default)
  - Password: (empty)
  - REST Endpoints:
    - `GET /api/v1/books` - Get all books
    - `GET /api/v1/books/{id}` - Get book by ID
    - `POST /api/v1/books` - Create new book
    - `PUT /api/v1/books/{id}` - Update book
    - `DELETE /api/v1/books/{id}` - Delete book
    - `GET /api/v1/books/health` - Health check

## Service Discovery
All modules (except eureka server) are configured to register with the Eureka service discovery server. They will automatically register themselves when started and can be discovered by other services.

## Scripts
- `start-services.sh` / `start-services.bat` - Starts all services in the correct order
- `stop-services.sh` / `stop-services.bat` - Stops all services and cleans up
- Logs are saved in the `logs/` directory when using the startup scripts

