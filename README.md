# Reto Arquitectura de Microservicios

Este proyecto implementa una arquitectura de microservicios con dos servicios principales:
- **ms-users**: Servicio de gestión de usuarios
- **ms-transactions**: Servicio de gestión de transacciones

## 🚀 Clonación del Proyecto

Para clonar el proyecto completo incluyendo todos los microservicios, ejecuta:

```bash
git clone --recursive https://github.com/Exloz/reto-sst-orches.git
```

## 📁 Estructura del Proyecto

 ```
reto-sst-orches/
├── ms-users/              # Servicio de usuarios
├── ms-transactions/       # Servicio de transacciones
├── docker-compose.yml     # Configuración de Docker Compose
├── BaseDatos.sql         # Script de base de datos
├── postman_collection.json # Colección de Postman
├── postman_environment.json # Variables de entorno Postman
└── README.md             # Este archivo
```

## 🛠️ Tecnologías Utilizadas

- **Java** con Spring Boot
- **Gradle** para la gestión de dependencias
- **Docker** para containerización
- **Git Submodules** para la organización de microservicios

## 🚦 Inicio Rápido

1. Clona el proyecto usando el comando anterior
2. Asegúrate de tener Docker y Docker Compose instalados
3. Construye y ejecuta el proyecto:

```bash
# Construir las imágenes primero (necesario)
docker compose build

# Ejecutar todos los servicios
 docker compose up
```

## 🧪 Testing con Postman

### Importación
1. Importar en Postman: `postman_collection.json` + `postman_environment.json`
2. Seleccionar environment: "Reto Arquitectura Microservicios"
3. Variables: `base_url_users:8080`, `base_url_transactions:8081`

### Endpoints Disponibles

#### ms-users (Puerto 8080)
**Personas:** GET, POST, PUT, DELETE /personas
**Clientes:** GET, POST, PUT, DELETE /clientes + GET /clientes/estado/{estado}

#### ms-transactions (Puerto 8081)
**Cuentas:** GET, POST, PUT, DELETE /cuentas
**Movimientos:** GET, POST, PUT, DELETE /movimientos
**Reportes:** GET /reportes (clienteId, startDate, endDate)

### Uso
- Endpoints listos con datos de ejemplo
- Variables editables en Postman
- JSON de ejemplo en POST/PUT

## 📝 Notas Importantes

- Los microservicios están organizados como submódulos de Git
- Cada microservicio tiene su propio repositorio y puede desarrollarse independientemente
- Es obligatorio usar `--recursive` al clonar para obtener el código completo
- Si experimentas problemas con los submódulos, ejecuta `git submodule update --init --recursive`