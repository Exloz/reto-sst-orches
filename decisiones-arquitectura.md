# Decisiones de Arquitectura para Prueba Técnica Microservicios

## Tecnologías Base
- **Framework:** Spring Boot 3.x con Gradle y Java 21.
- **Base de Datos:** PostgreSQL (primaria), H2 para testing.
- **ORM:** Spring Data JPA para persistencia.
- **Construcción:** Gradle para dependencias y builds.
- **Control de Versiones:** Git para repositorio.

## Arquitectura de Microservicios
- **Número de MS:** 2 microservicios para semiSenior.
  - **MS1 (Cliente/Persona):** Maneja entidades Cliente y Persona. Incluye CRUD básico (F1).
  - **MS2 (Cuenta/Movimientos):** Maneja Cuenta y Movimientos. Incluye registro de movimientos (F2-F3) y reportes (F4).
- **Comunicación:** Asíncrona usando Spring Cloud Stream con Apache Kafka (para eventos entre MS, ej. notificar movimientos).
- **API Gateway (Opcional):** Usa Spring Cloud Gateway si escalas a más MS.
- **Configuración:** Centralizada con Spring Cloud Config para propiedades.

## Programación Reactiva
- **Decisión:** Usar Spring WebFlux (reactivo) para MS2 (Cuenta/Movimientos) debido a alta concurrencia en transacciones. Spring MVC para MS1 (Cliente/Persona) por simplicidad inicial.
- **Pros:** Mejor escalabilidad y manejo de I/O no bloqueante.
- **Cons:** Curva de aprendizaje mayor; usa solo si hay necesidad de alto rendimiento.
- **Alternativa:** Comienza con MVC y migra a reactivo si se requiere.

## Dependencias (Gradle)
```gradle
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'
    implementation 'org.springframework.boot:spring-boot-starter-validation'
    runtimeOnly 'org.postgresql:postgresql'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
    implementation 'org.springframework.cloud:spring-cloud-starter-stream-kafka'
    implementation 'org.springdoc:springdoc-openapi-starter-webmvc-ui:2.2.0'
}
```

## Arquitectura Interna de Proyectos
- **Recomendación Final:**
  - **MS1 (Cliente/Persona):** Usa Layered Architecture (Controllers, Services, Repositories, Entities) por simplicidad.
  - **MS2 (Cuenta/Movimientos):** Usa Clean Architecture con capas de dominio, aplicación e infraestructura para desacoplamiento y escalabilidad.

## Plan de Implementación
1. Configura proyecto base con Gradle.
2. Define entidades JPA y repositorios.
3. Implementa F1-F4 en MS respectivos.
4. Agrega comunicación asíncrona y pruebas.
5. Despliegue con Docker.

Este documento se actualizará con avances.