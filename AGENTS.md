# AGENTS.md - Microservicios Architecture Guide

## Project Documentation References

This guide is based on the project's core documentation:

- **[REQUIREMENTS.md](REQUIREMENTS.md)**: Contains detailed functional requirements, entity specifications, API endpoints, and use cases for the financial microservices system
- **[decisiones-arquitectura.md](decisiones-arquitectura.md)**: Documents architectural decisions including technology stack, microservices design, reactive programming approach, and implementation plan

### Key Project Context
- **Domain**: Financial services with entities: Persona, Cliente, Cuenta, Movimientos
- **Architecture**: 2 microservices (ms-users for Cliente/Persona, ms-transactions for Cuenta/Movimientos)
- **Technology**: Spring Boot 3.x with Java 21, PostgreSQL, Spring Cloud Stream + Kafka
- **Approach**: Layered Architecture for ms-users, Clean Architecture for ms-transactions
- **Communication**: Async event-driven with Kafka for inter-service communication

## Build/Lint/Test Commands

### General Commands (Root Directory)
- **Build all services**: `./gradlew build` or `gradle build`
- **Clean build**: `./gradlew clean build`
- **Run tests**: `./gradlew test`
- **Run single test**: `./gradlew test --tests "*TestClassName*"`
- **Run tests with coverage**: `./gradlew test jacocoTestReport`

### Service-Specific Commands
- **ms-users service**:
  - Build: `cd ms-users && ./gradlew build`
  - Run: `cd ms-users && ./gradlew bootRun`
  - Test: `cd ms-users && ./gradlew test`
  - Run with Docker: `cd ms-users && docker-compose up`

- **ms-transactions service**:
  - Build: `cd ms-transactions && ./gradlew build`
  - Run: `cd ms-transactions && ./gradlew bootRun`
  - Test: `cd ms-transactions && ./gradlew test`

### Database Setup
- **PostgreSQL**: `docker run --name postgres -e POSTGRES_PASSWORD=secret -e POSTGRES_DB=mydatabase -p 5432:5432 -d postgres`
- **H2 (testing)**: Configured automatically in test profiles

## Code Style Guidelines

### Java Conventions
- **Language**: Java 21 with Spring Boot 3.5.6
- **Package structure**: `com.sofka.{service_name}` (e.g., `com.sofka.ms_users`)
- **Class naming**: PascalCase (e.g., `UserService`, `AccountController`)
- **Method naming**: camelCase (e.g., `findById()`, `createAccount()`)
- **Variable naming**: camelCase (e.g., `userId`, `accountBalance`)

### Import Organization
```java
// Standard Java libraries first
import java.util.List;
import java.util.Optional;

// Spring Framework imports
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

// Third-party libraries
import lombok.Data;
import lombok.NoArgsConstructor;

// Local project imports last
import com.sofka.ms_users.model.User;
```

### Code Structure
- **Controllers**: REST endpoints in `controller` package
- **Services**: Business logic in `service` package
- **Repositories**: Data access in `repository` package
- **Models/Entities**: Domain objects in `model` or `entity` package
- **DTOs**: Data transfer objects in `dto` package
- **Exceptions**: Custom exceptions in `exception` package

### Error Handling
- Use `@RestControllerAdvice` for global exception handling
- Custom exceptions should extend `RuntimeException`
- HTTP status codes: 200 (OK), 201 (Created), 400 (Bad Request), 404 (Not Found), 500 (Internal Server Error)
- Validation: Use `@Valid` annotation with `@RequestBody`

### Testing Standards
- **Unit tests**: Test business logic in isolation
- **Integration tests**: Test with Spring context (`@SpringBootTest`)
- **Test naming**: `ClassNameTest` or `ClassNameTests`
- **Test methods**: `shouldXXX_whenYYY()` pattern
- **Coverage**: Minimum 80% code coverage required

### API Documentation
- **OpenAPI/Swagger**: Available at `/swagger-ui.html` when running
- **Annotations**: Use `@Operation`, `@ApiResponse` for documentation
- **Response format**: Consistent JSON structure with proper HTTP codes

### Configuration
- **application.properties**: Main configuration file
- **Database**: PostgreSQL for production, H2 for testing
- **Profiles**: Use `application-{profile}.properties` for different environments
- **External config**: Spring Cloud Config for centralized configuration

### Async Communication
- **Spring Cloud Stream**: For event-driven architecture
- **Kafka**: Message broker for inter-service communication
- **Event naming**: Use domain events (e.g., `UserCreatedEvent`, `TransactionCompletedEvent`)

### Security
- **Authentication**: JWT tokens for API access
- **Authorization**: Role-based access control
- **Password encryption**: BCrypt for password hashing
- **HTTPS**: Required for production deployments

### Dependencies
- **Lombok**: For reducing boilerplate code
- **Spring Data JPA**: For ORM and repository pattern
- **Spring Validation**: For input validation
- **Spring WebFlux**: Used in ms-transactions for reactive programming
- **Spring Cloud Stream**: For event streaming with Kafka

### Git Conventions
- **Branch naming**: `feature/`, `develop`, `main`
- **Commit messages**: Clear, descriptive messages following conventional commits
- **Pull requests**: Require code review and passing tests

## Implementation Plan

### Overview
This phased plan outlines the development of the microservices based on REQUIREMENTS.md and decisiones-arquitectura.md. Each phase focuses on one service (starting with ms-users as requested). Work will proceed one phase at a time, with testing and validation at each step. Async communication via Kafka will be integrated as needed.

### Phases for ms-users Service (Layered Architecture)
**Phase 1: Setup and Configuration**
- Configure Spring Boot project with dependencies (Spring Data JPA, Spring Web, Spring Cloud Stream, Kafka, Lombok, Validation).
- Set up PostgreSQL database and H2 for testing.
- Create application.properties with profiles for dev/test/prod.
- Verify build and run commands.

**Phase 2: Entity and Model Creation**
- Define JPA entities: Persona, Cliente.
- Create DTOs for request/response (e.g., PersonaDTO, ClienteDTO).
- Implement validation annotations.
- Ensure proper package structure and imports.

**Phase 3: Repository Layer**
- Create repositories: PersonaRepository, ClienteRepository.
- Add custom query methods as needed.
- Test basic database operations.

**Phase 4: Service Layer**
- Implement business logic in services: PersonaService, ClienteService.
- Handle CRUD operations and domain rules.
- Add error handling and validation.

**Phase 5: Controller Layer**
- Create REST controllers: PersonaController, ClienteController.
- Define endpoints for CRUD operations (GET, POST, PUT, DELETE).
- Add error handling with @RestControllerAdvice.
- Test endpoints manually.

**Phase 6: Event Handling**
- Set up Kafka producer for events (e.g., ClienteCreatedEvent).
- Configure Spring Cloud Stream bindings.
- Test event publishing.

**Phase 7: Testing**
- Write unit tests for services and controllers.
- Write integration tests with @SpringBootTest.
- Ensure 80%+ code coverage.
- Run tests and fix issues.

**Phase 8: Documentation and Security**
- Add OpenAPI annotations for API docs.
- Implement basic JWT authentication if required.
- Generate Swagger documentation.
- Update README with usage instructions.

**Phase 9: Build and Deployment**
- Build with Gradle.
- Create Docker configuration.
- Test locally with docker-compose.
- Prepare for production deployment.

### Phases for ms-transactions Service (Clean Architecture) - Future
(Phases for ms-transactions will be defined after ms-users completion.)

### Integration and Final Steps
1. **Inter-Service Communication**: Test Kafka event flow between services.
2. **End-to-End Testing**: Run full system tests.
3. **Deployment Preparation**: Update Docker configurations.
4. **Review and Optimization**: Code review and final testing.

### ms-transactions Service (Clean Architecture with Reactive Programming)
1. **Setup and Configuration**:
   - Configure Spring Boot with WebFlux for reactive programming.
   - Add dependencies: Spring WebFlux, Spring Cloud Stream, Kafka, R2DBC, Lombok, Slf4j, etc.
   - Set up database and profiles for reactive flows.

2. **Domain Layer**:
   - Define domain entities: Cuenta, Movimientos.
   - Create domain services and repositories interfaces.
   - Use interfaces for decoupled architecture.

3. **Use Case Layer**:
   - Implement use cases (e.g., CreateCuentaUseCase, GetMovimientosUseCase).
   - Handle business logic and orchestration with reactive flows.
   - Use constructor dependency injection with Lombok.

4. **Infrastructure Layer**:
   - Implement R2DBC repositories and external adapters.
   - Set up Kafka consumer for events from ms-users.
   - Add Slf4j logging throughout.

5. **Presentation Layer**:
   - Create reactive controllers with WebFlux.
   - Define REST endpoints for Cuenta and Movimientos.
   - Use constructor injection and interfaces.

6. **Event Handling**:
   - Configure Kafka consumer for incoming events.
   - Publish events (e.g., TransactionCompletedEvent).
   - Use reactive streams for event processing.

7. **Testing**:
   - Write unit tests for domain and use cases.
   - Write integration tests for reactive components.
   - Achieve 80%+ coverage.

8. **Documentation and Security**:
   - Add OpenAPI annotations.
   - Implement reactive security if needed.
   - Generate API docs.

9. **Build and Deployment**:
   - Build with Gradle.
   - Test reactive endpoints.
   - Prepare Docker setup.

### Integration and Final Steps
1. **Inter-Service Communication**:
   - Test Kafka event flow between services.
   - Ensure async processing works correctly.

2. **End-to-End Testing**:
   - Run full system tests.
   - Validate API endpoints and data consistency.

3. **Deployment Preparation**:
   - Update Docker configurations.
   - Set up CI/CD if needed.
   - Document deployment instructions.

4. **Review and Optimization**:
   - Code review for adherence to guidelines.
   - Optimize performance and security.
   - Final testing and documentation updates.