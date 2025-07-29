# spring-cloud-example
Spring cloud microservice repo example

## Technology Stack
- **Java**: 21
- **Spring Boot**: 3.2.0
- **Spring Cloud**: 2023.0.0
- **Gradle**: 8.5

## Getting Started
To start Eureka server, run the following command in eureka folder:

```
./gradlew bootRun
```
Then, goto http://localhost:8761 to see the Eureka dashboard.

## Modules
- **eureka**: Service discovery server (port 8761)
- **sample-service**: REST microservice with circuit breaker (port 9001)
  - `GET /api/v1/hello` - Returns "Hello World!"
  - `GET /api/v1/user` - Returns personalized greeting
  - `GET /api/v1/test-broken-service` - Circuit breaker demo
- **sample-module**: Spring Boot application with security (port 9000)
- **docker-module**: Docker-ready Spring Boot application (port 8080)
  - `GET /api/v1/docker` - Returns Docker module info
  - `GET /health` - Health check endpoint

## Service Discovery
All modules (except eureka server) are configured to register with the Eureka service discovery server. They will automatically register themselves when started and can be discovered by other services.

