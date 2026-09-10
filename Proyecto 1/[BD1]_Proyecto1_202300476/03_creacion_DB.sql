-- Proyecto 1 - Comercial La Estrella
-- Creacion completa para Oracle Database desde un esquema vacio.
-- Ejecutar con Run Script (F5) antes de 03_carga_datos.sql.

WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK;

CREATE TABLE pais (
    id_pais NUMBER(10) CONSTRAINT pk_pais PRIMARY KEY,
    nombre VARCHAR2(80) CONSTRAINT nn_pais_nombre NOT NULL,
    CONSTRAINT uq_pais_nombre UNIQUE (nombre)
);

CREATE TABLE departamento (
    id_departamento NUMBER(10) CONSTRAINT pk_departamento PRIMARY KEY,
    nombre VARCHAR2(80) CONSTRAINT nn_dep_nombre NOT NULL,
    id_pais NUMBER(10) CONSTRAINT nn_dep_pais NOT NULL,
    CONSTRAINT uq_dep_pais_nombre UNIQUE (id_pais, nombre),
    CONSTRAINT fk_dep_pais FOREIGN KEY (id_pais) REFERENCES pais (id_pais)
);

CREATE TABLE municipio (
    id_municipio NUMBER(10) CONSTRAINT pk_municipio PRIMARY KEY,
    nombre VARCHAR2(80) CONSTRAINT nn_mun_nombre NOT NULL,
    id_departamento NUMBER(10) CONSTRAINT nn_mun_dep NOT NULL,
    CONSTRAINT uq_mun_dep_nombre UNIQUE (id_departamento, nombre),
    CONSTRAINT fk_mun_dep FOREIGN KEY (id_departamento)
        REFERENCES departamento (id_departamento)
);

CREATE TABLE tipo_tienda (
    id_tipo_tienda NUMBER(10) CONSTRAINT pk_tipo_tienda PRIMARY KEY,
    nombre VARCHAR2(80) CONSTRAINT nn_tip_tie_nombre NOT NULL,
    CONSTRAINT uq_tip_tie_nombre UNIQUE (nombre)
);

CREATE TABLE tipo_identificacion (
    id_tipo_identificacion NUMBER(10) CONSTRAINT pk_tipo_id PRIMARY KEY,
    nombre VARCHAR2(50) CONSTRAINT nn_tipo_id_nombre NOT NULL,
    CONSTRAINT uq_tipo_id_nombre UNIQUE (nombre)
);

CREATE TABLE cargo (
    id_cargo NUMBER(10) CONSTRAINT pk_cargo PRIMARY KEY,
    nombre VARCHAR2(80) CONSTRAINT nn_cargo_nombre NOT NULL,
    CONSTRAINT uq_cargo_nombre UNIQUE (nombre)
);

CREATE TABLE categoria (
    id_categoria NUMBER(10) CONSTRAINT pk_categoria PRIMARY KEY,
    nombre VARCHAR2(80) CONSTRAINT nn_cat_nombre NOT NULL,
    CONSTRAINT uq_cat_nombre UNIQUE (nombre)
);

CREATE TABLE marca (
    id_marca NUMBER(10) CONSTRAINT pk_marca PRIMARY KEY,
    nombre VARCHAR2(80) CONSTRAINT nn_marca_nombre NOT NULL,
    CONSTRAINT uq_marca_nombre UNIQUE (nombre)
);

CREATE TABLE estado_venta (
    id_estado_venta NUMBER(10) CONSTRAINT pk_estado_venta PRIMARY KEY,
    nombre VARCHAR2(30) CONSTRAINT nn_est_ven_nombre NOT NULL,
    CONSTRAINT uq_est_ven_nombre UNIQUE (nombre),
    CONSTRAINT ck_est_ven_nombre CHECK (nombre IN ('REGISTRADA', 'PAGADA', 'ANULADA'))
);

CREATE TABLE metodo_pago (
    id_metodo_pago NUMBER(10) CONSTRAINT pk_metodo_pago PRIMARY KEY,
    nombre VARCHAR2(80) CONSTRAINT nn_met_pag_nombre NOT NULL,
    CONSTRAINT uq_met_pag_nombre UNIQUE (nombre)
);

CREATE TABLE persona (
    id_persona NUMBER(10) CONSTRAINT pk_persona PRIMARY KEY,
    nombres VARCHAR2(100) CONSTRAINT nn_per_nombres NOT NULL,
    apellidos VARCHAR2(100) CONSTRAINT nn_per_apellidos NOT NULL,
    telefono VARCHAR2(25) CONSTRAINT nn_per_telefono NOT NULL,
    correo VARCHAR2(150),
    direccion VARCHAR2(200) CONSTRAINT nn_per_direccion NOT NULL,
    id_municipio NUMBER(10) CONSTRAINT nn_per_municipio NOT NULL,
    CONSTRAINT uq_persona_correo UNIQUE (correo),
    CONSTRAINT fk_persona_mun FOREIGN KEY (id_municipio)
        REFERENCES municipio (id_municipio)
);

CREATE TABLE tienda (
    id_tienda NUMBER(10) CONSTRAINT pk_tienda PRIMARY KEY,
    nombre VARCHAR2(120) CONSTRAINT nn_tienda_nombre NOT NULL,
    direccion VARCHAR2(200) CONSTRAINT nn_tienda_dir NOT NULL,
    telefono VARCHAR2(25) CONSTRAINT nn_tienda_tel NOT NULL,
    id_municipio NUMBER(10) CONSTRAINT nn_tienda_mun NOT NULL,
    id_tipo_tienda NUMBER(10) CONSTRAINT nn_tienda_tipo NOT NULL,
    CONSTRAINT uq_tienda_nombre UNIQUE (nombre),
    CONSTRAINT fk_tienda_mun FOREIGN KEY (id_municipio)
        REFERENCES municipio (id_municipio),
    CONSTRAINT fk_tienda_tipo FOREIGN KEY (id_tipo_tienda)
        REFERENCES tipo_tienda (id_tipo_tienda)
);

CREATE TABLE empleado (
    id_empleado NUMBER(10) CONSTRAINT pk_empleado PRIMARY KEY,
    fecha_contratacion DATE CONSTRAINT nn_emp_fecha NOT NULL,
    id_tienda NUMBER(10) CONSTRAINT nn_emp_tienda NOT NULL,
    id_cargo NUMBER(10) CONSTRAINT nn_emp_cargo NOT NULL,
    id_persona NUMBER(10) CONSTRAINT nn_emp_persona NOT NULL,
    CONSTRAINT uq_emp_persona UNIQUE (id_persona),
    CONSTRAINT uq_emp_tienda UNIQUE (id_empleado, id_tienda),
    CONSTRAINT fk_emp_tienda FOREIGN KEY (id_tienda) REFERENCES tienda (id_tienda),
    CONSTRAINT fk_emp_cargo FOREIGN KEY (id_cargo) REFERENCES cargo (id_cargo),
    CONSTRAINT fk_emp_persona FOREIGN KEY (id_persona) REFERENCES persona (id_persona)
);

CREATE TABLE cliente (
    id_cliente NUMBER(10) CONSTRAINT pk_cliente PRIMARY KEY,
    id_tipo_identificacion NUMBER(10) CONSTRAINT nn_cli_tipo_id NOT NULL,
    numero_identificacion VARCHAR2(30) CONSTRAINT nn_cli_num_id NOT NULL,
    id_persona NUMBER(10) CONSTRAINT nn_cli_persona NOT NULL,
    CONSTRAINT uq_cli_identificacion UNIQUE (id_tipo_identificacion, numero_identificacion),
    CONSTRAINT uq_cli_persona UNIQUE (id_persona),
    CONSTRAINT fk_cli_tipo_id FOREIGN KEY (id_tipo_identificacion)
        REFERENCES tipo_identificacion (id_tipo_identificacion),
    CONSTRAINT fk_cli_persona FOREIGN KEY (id_persona) REFERENCES persona (id_persona)
);

CREATE TABLE producto (
    id_producto NUMBER(10) CONSTRAINT pk_producto PRIMARY KEY,
    nombre VARCHAR2(120) CONSTRAINT nn_prod_nombre NOT NULL,
    descripcion VARCHAR2(300) CONSTRAINT nn_prod_desc NOT NULL,
    id_categoria NUMBER(10) CONSTRAINT nn_prod_cat NOT NULL,
    id_marca NUMBER(10) CONSTRAINT nn_prod_marca NOT NULL,
    CONSTRAINT fk_prod_cat FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria),
    CONSTRAINT fk_prod_marca FOREIGN KEY (id_marca) REFERENCES marca (id_marca)
);

CREATE TABLE catalogo_producto (
    precio_vigente NUMBER(12,2) CONSTRAINT nn_cat_prod_precio NOT NULL,
    existencia_actual NUMBER(10) CONSTRAINT nn_cat_prod_exist NOT NULL,
    id_tienda NUMBER(10) CONSTRAINT nn_cat_prod_tienda NOT NULL,
    id_producto NUMBER(10) CONSTRAINT nn_cat_prod_producto NOT NULL,
    CONSTRAINT pk_catalogo_producto PRIMARY KEY (id_tienda, id_producto),
    CONSTRAINT ck_cat_prod_precio CHECK (precio_vigente > 0),
    CONSTRAINT ck_cat_prod_exist CHECK (existencia_actual >= 0),
    CONSTRAINT fk_cat_prod_tienda FOREIGN KEY (id_tienda) REFERENCES tienda (id_tienda),
    CONSTRAINT fk_cat_prod_producto FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
);

CREATE TABLE venta (
    id_venta NUMBER(10) CONSTRAINT pk_venta PRIMARY KEY,
    fecha_venta DATE CONSTRAINT nn_venta_fecha NOT NULL,
    id_tienda NUMBER(10) CONSTRAINT nn_venta_tienda NOT NULL,
    id_empleado NUMBER(10) CONSTRAINT nn_venta_emp NOT NULL,
    id_cliente NUMBER(10) CONSTRAINT nn_venta_cli NOT NULL,
    id_estado_venta NUMBER(10) CONSTRAINT nn_venta_estado NOT NULL,
    CONSTRAINT fk_venta_emp_tienda FOREIGN KEY (id_empleado, id_tienda)
        REFERENCES empleado (id_empleado, id_tienda),
    CONSTRAINT fk_venta_cli FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
    CONSTRAINT fk_venta_estado FOREIGN KEY (id_estado_venta)
        REFERENCES estado_venta (id_estado_venta)
);

CREATE TABLE detalle_venta (
    cantidad NUMBER(10) CONSTRAINT nn_det_cantidad NOT NULL,
    precio_unitario NUMBER(12,2) CONSTRAINT nn_det_precio NOT NULL,
    subtotal NUMBER(12,2) CONSTRAINT nn_det_subtotal NOT NULL,
    id_venta NUMBER(10) CONSTRAINT nn_det_venta NOT NULL,
    id_producto NUMBER(10) CONSTRAINT nn_det_producto NOT NULL,
    CONSTRAINT pk_detalle_venta PRIMARY KEY (id_venta, id_producto),
    CONSTRAINT ck_det_cantidad CHECK (cantidad > 0),
    CONSTRAINT ck_det_precio CHECK (precio_unitario > 0),
    CONSTRAINT ck_det_subtotal CHECK (subtotal = cantidad * precio_unitario),
    CONSTRAINT fk_det_venta FOREIGN KEY (id_venta) REFERENCES venta (id_venta),
    CONSTRAINT fk_det_producto FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
);

CREATE TABLE pago (
    id_pago NUMBER(10) CONSTRAINT pk_pago PRIMARY KEY,
    monto NUMBER(12,2) CONSTRAINT nn_pago_monto NOT NULL,
    id_metodo_pago NUMBER(10) CONSTRAINT nn_pago_metodo NOT NULL,
    id_venta NUMBER(10) CONSTRAINT nn_pago_venta NOT NULL,
    CONSTRAINT ck_pago_monto CHECK (monto > 0),
    CONSTRAINT fk_pago_metodo FOREIGN KEY (id_metodo_pago)
        REFERENCES metodo_pago (id_metodo_pago),
    CONSTRAINT fk_pago_venta FOREIGN KEY (id_venta) REFERENCES venta (id_venta)
);

PROMPT Estructura creada: 19 tablas.
