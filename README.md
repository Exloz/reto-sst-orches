# Reto Arquitectura de Microservicios

Este proyecto implementa una arquitectura de microservicios con dos servicios principales:
- **ms-users**: Servicio de gestión de usuarios
- **ms-transactions**: Servicio de gestión de transacciones

## 🚀 Clonación del Proyecto

### Opción 1: Clonación con submódulos (Recomendada)
Para clonar el proyecto completo incluyendo todos los microservicios, ejecuta:

```bash
git clone --recursive https://github.com/Exloz/reto-sst-orches.git
```

### Opción 2: Clonación paso a paso
Si ya clonaste el repositorio sin la opción `--recursive`:

```bash
# 1. Clonar el repositorio principal
git clone https://github.com/Exloz/reto-sst-orches.git

# 2. Entrar al directorio del proyecto
cd reto-sst-orches

# 3. Inicializar y actualizar los submódulos
git submodule init
git submodule update
```

### Opción 3: Actualizar submódulos existentes
Si los submódulos ya están inicializados pero necesitas actualizarlos:

```bash
git submodule update --init --recursive
```

## 📁 Estructura del Proyecto

```
reto-sst-orches/
├── ms-users/              # Servicio de usuarios
├── ms-transactions/       # Servicio de transacciones
├── docker-compose.yml     # Configuración de Docker Compose
├── BaseDatos.sql         # Script de base de datos
└── README.md             # Este archivo
```

## 🛠️ Tecnologías Utilizadas

- **Java** con Spring Boot
- **Gradle** para la gestión de dependencias
- **Docker** para containerización
- **Git Submodules** para la organización de microservicios

## 🚦 Inicio Rápido

1. Clona el proyecto usando la **Opción 1** recomendada
2. Asegúrate de tener Docker y Docker Compose instalados
3. Ejecuta el proyecto:

```bash
docker-compose up
```

## 📝 Notas Importantes

- Los microservicios están organizados como submódulos de Git
- Cada microservicio tiene su propio repositorio y puede desarrollarse independientemente
- Asegúrate de usar `--recursive` al clonar para obtener el código completo
- Si experimentas problemas con los submódulos, ejecuta `git submodule update --init --recursive`