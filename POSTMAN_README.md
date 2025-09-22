# Colección de Postman - Reto Arquitectura Microservicios

Este directorio contiene los archivos necesarios para importar y usar la colección completa de endpoints en Postman.

## 📁 Archivos incluidos

- `postman_collection.json` - Colección completa de endpoints organizados por microservicio
- `postman_environment.json` - Variables de entorno con las URLs base configuradas
- `POSTMAN_README.md` - Este archivo de instrucciones

## 🚀 Importación en Postman

### Opción 1: Importar desde archivos locales
1. Abre Postman
2. Haz clic en "Import" (botón superior izquierdo)
3. Selecciona "Upload Files"
4. Importa ambos archivos:
   - `postman_collection.json`
   - `postman_environment.json`

### Opción 2: Importar desde URLs
Si tienes los archivos en un repositorio público, puedes usar las URLs directas:
- Colección: `https://raw.githubusercontent.com/Exloz/reto-sst-orches/main/postman_collection.json`
- Environment: `https://raw.githubusercontent.com/Exloz/reto-sst-orches/main/postman_environment.json`

## ⚙️ Configuración

### 1. Seleccionar Environment
- En Postman, selecciona el environment "Reto Arquitectura Microservicios"
- Esto cargará las variables `base_url_users` y `base_url_transactions`

### 2. Variables de Entorno
- `base_url_users`: `http://localhost:8080` (Microservicio de usuarios)
- `base_url_transactions`: `http://localhost:8081` (Microservicio de transacciones)

### 3. Modificar URLs si es necesario
Si tus servicios corren en puertos diferentes, actualiza las variables:
- Ve a "Environments" en Postman
- Edita los valores de las variables según tus necesidades

## 📋 Endpoints Organizados

### Microservicio Users (ms-users) - Puerto 8080
#### Personas
- `GET /personas` - Obtener todas las personas
- `GET /personas/{identificacion}` - Obtener persona por ID
- `POST /personas` - Crear nueva persona
- `PUT /personas/{identificacion}` - Actualizar persona
- `DELETE /personas/{identificacion}` - Eliminar persona

#### Clientes
- `GET /clientes` - Obtener todos los clientes
- `GET /clientes/{clienteId}` - Obtener cliente por ID
- `GET /clientes/estado/{estado}` - Obtener clientes por estado
- `POST /clientes` - Crear nuevo cliente
- `PUT /clientes/{clienteId}` - Actualizar cliente
- `DELETE /clientes/{clienteId}` - Eliminar cliente

### Microservicio Transactions (ms-transactions) - Puerto 8081
#### Cuentas
- `GET /cuentas` - Obtener todas las cuentas
- `GET /cuentas/{cuentaId}` - Obtener cuenta por ID
- `POST /cuentas` - Crear nueva cuenta
- `PUT /cuentas/{cuentaId}` - Actualizar cuenta
- `DELETE /cuentas/{cuentaId}` - Eliminar cuenta

#### Movimientos
- `GET /movimientos` - Obtener todos los movimientos
- `GET /movimientos/{movimientoId}` - Obtener movimiento por ID
- `POST /movimientos` - Crear nuevo movimiento
- `PUT /movimientos/{movimientoId}` - Actualizar movimiento
- `DELETE /movimientos/{movimientoId}` - Eliminar movimiento

#### Reportes
- `GET /reportes?clienteId={id}&startDate={yyyy-mm-dd}&endDate={yyyy-mm-dd}` - Generar estado de cuenta

## 🏃‍♂️ Uso

### 1. Iniciar los servicios
```bash
# Desde el directorio raíz del proyecto
docker compose build
docker compose up
```

### 2. Probar endpoints
- Los endpoints están preconfigurados con datos de ejemplo
- Modifica los parámetros según necesites
- Los cuerpos de las peticiones POST/PUT ya incluyen JSON de ejemplo

### 3. Variables en URLs
- Las URLs que contienen variables (ej: `{identificacion}`) se pueden editar directamente en Postman
- Haz clic en "Params" para ver y modificar las variables

## 🔧 Personalización

### Modificar datos de ejemplo
- Edita los cuerpos de las peticiones en la pestaña "Body"
- Cambia los valores de las variables en "Params"

### Agregar nuevos endpoints
- Si agregas nuevos endpoints a los microservicios, actualiza la colección
- Exporta la colección actualizada desde Postman
- Reemplaza el archivo `postman_collection.json`

## 📝 Notas importantes

- Los servicios deben estar ejecutándose para que las peticiones funcionen
- Asegúrate de que Docker Compose esté ejecutándose correctamente
- Los puertos pueden variar si tienes conflictos, actualiza las variables de entorno
- Para desarrollo local, los servicios usan perfiles específicos (`dev` para ms-users, `docker` para ambos)

## 🆘 Solución de problemas

### Error de conexión
- Verifica que los servicios estén ejecutándose: `docker compose ps`
- Comprueba los puertos: `docker compose port ms-users` y `docker compose port ms-transactions`
- Actualiza las variables de entorno si los puertos son diferentes

### Datos no encontrados
- Algunos endpoints requieren datos existentes
- Crea primero las entidades básicas (personas, clientes, cuentas) antes de usar endpoints dependientes

### Errores de validación
- Revisa los códigos de estado HTTP en las respuestas
- Los endpoints incluyen validaciones que pueden devolver errores 400 o 404