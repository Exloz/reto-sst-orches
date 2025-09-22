-- Esquema unificado para ms-users y ms-transactions

CREATE TABLE IF NOT EXISTS personas (
    identificacion VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    genero VARCHAR(10) NOT NULL,
    edad INT CHECK (edad >= 0 AND edad <= 150),
    direccion VARCHAR(200),
    telefono VARCHAR(20)
);

CREATE SEQUENCE IF NOT EXISTS cliente_id_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE IF NOT EXISTS clientes (
    identificacion VARCHAR(20) PRIMARY KEY REFERENCES personas(identificacion) ON DELETE CASCADE,
    cliente_id BIGINT UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    estado BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS cuentas (
    cuenta_id BIGSERIAL PRIMARY KEY,
    numero_cuenta VARCHAR(50) UNIQUE NOT NULL,
    tipo_cuenta VARCHAR(50) NOT NULL,
    saldo_inicial NUMERIC(19,2) NOT NULL,
    saldo_actual NUMERIC(19,2),
    estado BOOLEAN NOT NULL,
    cliente_id BIGINT NOT NULL REFERENCES clientes(cliente_id)
);

CREATE TABLE IF NOT EXISTS movimientos (
    movimiento_id BIGSERIAL PRIMARY KEY,
    fecha DATE NOT NULL,
    tipo_movimiento VARCHAR(50) NOT NULL,
    valor NUMERIC(19,2) NOT NULL,
    saldo NUMERIC(19,2) NOT NULL,
    cuenta_id BIGINT NOT NULL REFERENCES cuentas(cuenta_id)
);

CREATE INDEX IF NOT EXISTS idx_cuentas_cliente_id ON cuentas(cliente_id);
CREATE INDEX IF NOT EXISTS idx_movimientos_cuenta_id_fecha ON movimientos(cuenta_id, fecha);
