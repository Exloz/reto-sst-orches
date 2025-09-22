# Repository Guidelines

## Project Structure & Module Organization
- Root folders `ms-users` and `ms-transactions` hold the Spring Boot services; each sigue la convención `src/main/java` para código y `src/test/java` para pruebas.
- `ms-users` usa arquitectura en capas para Persona/Cliente; `ms-transactions` aplica Clean Architecture reactiva para Cuenta/Movimientos.
- Documentación compartida (`REQUIREMENTS.md`, `decisiones-arquitectura.md`), `docker-compose.yml` y el script de esquema `BaseDatos.sql` residen en la raíz; cada servicio mantiene su propio `compose.yaml`.
- Configuración vive en `src/main/resources/application-*.properties`; usa perfiles para overrides y mantén secretos fuera del repositorio.

## Build, Test, and Development Commands
- `./gradlew build` (root) compila ambos servicios y ejecuta sus pruebas.
- `cd ms-users && ./gradlew bootRun` arranca el servicio sincrónico; `./gradlew test` corre unitarias, controladores e integración.
- `cd ms-transactions && ./gradlew bootRun` inicia el servicio reactivo; `./gradlew test` ejecuta pruebas WebFlux con repositorios en memoria.
- `docker compose up` (desde la raíz) levanta PostgreSQL, Kafka y ambos servicios listos para flows end-to-end.

## Coding Style & Naming Conventions
- Target Java 21 with Spring Boot 3.5.x; use four-space indentation and omit wildcard imports.
- Packages siguen `com.sofka.<module>`; clases en PascalCase, métodos/atributos camelCase, constantes en MAYÚSCULAS.
- Anota controladores con rutas explícitas, valida DTOs con `@Valid` y publica eventos con Spring Cloud Stream usando bindings descriptivos (`clienteCreated-out-0`, `transactionCompleted-out-0`); en el consumidor reactivo configura `clienteCreatedConsumer-in-0` a través de `spring.cloud.function.definition=clienteCreatedConsumer` para recibir los `ClienteCreatedEvent`.
- Los productores verifican el resultado de `StreamBridge#send`; cualquier fallo levanta excepción y revierte la transacción correspondiente.

## Testing Guidelines
- Tests usan JUnit + soporte Spring; sigue el patrón `shouldAction_whenCondition()`.
- Mantén ≥80 % de cobertura; genera reportes con `./gradlew test jacocoTestReport` en la raíz.
- Stubbea Kafka mediante el test binder (`spring.cloud.stream.default-binder=test`) y reemplaza adaptadores externos en integración.

## Commit & Pull Request Guidelines
- Use conventional commits (`feat:`, `fix:`, `chore:`) referencing the module affected; group related changes into a single commit when practical.
- Branch from `main` using `feature/<ticket>` or `fix/<ticket>` naming.
- Pull requests should summarize scope, list tests executed, and link requirement IDs; include screenshots or curl samples for API changes when helpful.

## Security & Configuration Tips
- Nunca comprometas secretos; carga credenciales vía variables de entorno consumidas por los `application-*.properties`.
- Kafka y PostgreSQL deben usar TLS en producción; documenta cambios de tópicos/esquema en los PR.
- Observa los logs de `ClienteCreatedEvent`/`TransactionCompletedEvent` para asegurar el flujo asíncrono y ajusta dashboards o alertas en consecuencia.
- Aplica reglas JWT/roles de forma consistente y mantén los `@RestControllerAdvice` actuales para respuestas homogéneas.
