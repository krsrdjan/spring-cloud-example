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
- **sample-module**: Basic Spring Boot application
- **docker-module**: Docker-ready Spring Boot application

