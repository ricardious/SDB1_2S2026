-- Generado por Oracle SQL Developer Data Modeler 24.3.1.347.1153
--   en:        2026-08-27 23:59:24 CST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE bitacora (
    id_bitacora            NUMBER NOT NULL,
    correlativo_mensual    NUMBER(5) NOT NULL,
    fecha                  DATE NOT NULL,
    horas_trabajadas       NUMBER(6, 2) NOT NULL,
    actividades_realizadas VARCHAR2(1000) NOT NULL,
    observaciones          VARCHAR2(1000),
    id_colocacion          NUMBER NOT NULL,
    id_contacto_validador  NUMBER NOT NULL
);

COMMENT ON TABLE bitacora IS
    'Entrada de bitácora asociada a una colocación.';

ALTER TABLE bitacora ADD CONSTRAINT pk_bitacora PRIMARY KEY ( id_bitacora );

CREATE TABLE catedratico (
    id_catedratico NUMBER NOT NULL,
    identificacion VARCHAR2(40) NOT NULL,
    nombre         VARCHAR2(150) NOT NULL,
    telefono       VARCHAR2(25) NOT NULL,
    especialidad   VARCHAR2(120) NOT NULL,
    id_instituto   NUMBER NOT NULL
);

COMMENT ON TABLE catedratico IS
    'Catedrático asignado por un instituto para supervisar estudiantes.';

ALTER TABLE catedratico ADD CONSTRAINT pk_catedratico PRIMARY KEY ( id_catedratico );

ALTER TABLE catedratico ADD CONSTRAINT uk_catedratico_ident UNIQUE ( identificacion );

CREATE TABLE colocacion (
    id_colocacion      NUMBER NOT NULL,
    fecha_inicio       DATE NOT NULL,
    fecha_finalizacion DATE,
    id_estudiante      NUMBER(10) NOT NULL,
    id_plaza           NUMBER NOT NULL,
    id_catedratico     NUMBER NOT NULL,
    id_estado          NUMBER NOT NULL
);

COMMENT ON TABLE colocacion IS
    'Asignación histórica de un estudiante a una plaza de práctica.';

ALTER TABLE colocacion ADD CONSTRAINT pk_colocacion PRIMARY KEY ( id_colocacion );

CREATE TABLE contacto_empresarial (
    id_contacto NUMBER NOT NULL,
    nombre      VARCHAR2(150) NOT NULL,
    telefono    VARCHAR2(25) NOT NULL,
    correo      VARCHAR2(150) NOT NULL,
    id_empresa  NUMBER NOT NULL
);

COMMENT ON TABLE contacto_empresarial IS
    'Contacto designado por una empresa como supervisor externo.';

ALTER TABLE contacto_empresarial ADD CONSTRAINT pk_contacto_empresarial PRIMARY KEY ( id_contacto );

CREATE TABLE criterio (
    id_criterio NUMBER NOT NULL,
    nombre      VARCHAR2(120) NOT NULL
);

COMMENT ON TABLE criterio IS
    'Criterio utilizado para calificar una evaluación.';

ALTER TABLE criterio ADD CONSTRAINT pk_criterio PRIMARY KEY ( id_criterio );

ALTER TABLE criterio ADD CONSTRAINT uk_criterio_nombre UNIQUE ( nombre );

CREATE TABLE departamento (
    id_departamento NUMBER NOT NULL,
    nombre          VARCHAR2(100) NOT NULL
);

COMMENT ON TABLE departamento IS
    'Catálogo de departamentos de Guatemala.';

ALTER TABLE departamento ADD CONSTRAINT pk_departamento PRIMARY KEY ( id_departamento );

ALTER TABLE departamento ADD CONSTRAINT uk_departamento_nombre UNIQUE ( nombre );

CREATE TABLE detalle_evaluacion (
    id_evaluacion NUMBER NOT NULL,
    id_criterio   NUMBER NOT NULL,
    puntuacion    NUMBER(1) NOT NULL
);

COMMENT ON TABLE detalle_evaluacion IS
    'Puntuación obtenida en cada criterio de una evaluación.';

ALTER TABLE detalle_evaluacion ADD CONSTRAINT pk_detalle_evaluacion PRIMARY KEY ( id_evaluacion,
                                                                                  id_criterio );

CREATE TABLE empresa (
    id_empresa NUMBER NOT NULL,
    nombre     VARCHAR2(150) NOT NULL,
    direccion  VARCHAR2(250) NOT NULL,
    id_sector  NUMBER NOT NULL
);

COMMENT ON TABLE empresa IS
    'Empresa afiliada al programa EPS.';

ALTER TABLE empresa ADD CONSTRAINT pk_empresa PRIMARY KEY ( id_empresa );

CREATE TABLE estado_colocacion (
    id_estado NUMBER NOT NULL,
    nombre    VARCHAR2(30) NOT NULL
);

COMMENT ON TABLE estado_colocacion IS
    'Catálogo de estados posibles de una colocación.';

ALTER TABLE estado_colocacion ADD CONSTRAINT pk_estado_colocacion PRIMARY KEY ( id_estado );

ALTER TABLE estado_colocacion ADD CONSTRAINT uk_estado_colocacion_nombre UNIQUE ( nombre );

CREATE TABLE estudiante (
    carne            NUMBER(10) NOT NULL,
    nombre_completo  VARCHAR2(180) NOT NULL,
    carrera_tecnica  VARCHAR2(120) NOT NULL,
    direccion        VARCHAR2(250) NOT NULL,
    telefono         VARCHAR2(25) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero           VARCHAR2(20) NOT NULL,
    es_repitencia    NUMBER(1) NOT NULL,
    id_municipio     NUMBER NOT NULL,
    id_instituto     NUMBER NOT NULL
);

COMMENT ON TABLE estudiante IS
    'Estudiante de instituto técnico que realiza una práctica EPS.';

ALTER TABLE estudiante ADD CONSTRAINT pk_estudiante PRIMARY KEY ( carne );

CREATE TABLE evaluacion (
    id_evaluacion      NUMBER NOT NULL,
    fecha_evaluacion   DATE NOT NULL,
    id_colocacion      NUMBER NOT NULL,
    id_catedratico     NUMBER NOT NULL,
    id_tipo_evaluacion NUMBER NOT NULL
);

COMMENT ON TABLE evaluacion IS
    'Evaluación parcial o final de una colocación.';

ALTER TABLE evaluacion ADD CONSTRAINT pk_evaluacion PRIMARY KEY ( id_evaluacion );

CREATE TABLE instituto (
    id_instituto        NUMBER NOT NULL,
    nombre              VARCHAR2(180) NOT NULL,
    direccion           VARCHAR2(250) NOT NULL,
    codigo_autorizacion VARCHAR2(80) NOT NULL
);

COMMENT ON TABLE instituto IS
    'Instituto técnico que envía estudiantes al programa EPS.';

ALTER TABLE instituto ADD CONSTRAINT pk_instituto PRIMARY KEY ( id_instituto );

ALTER TABLE instituto ADD CONSTRAINT uk_instituto_autorizacion UNIQUE ( codigo_autorizacion );

CREATE TABLE municipio (
    id_municipio    NUMBER NOT NULL,
    nombre          VARCHAR2(100) NOT NULL,
    id_departamento NUMBER NOT NULL
);

COMMENT ON TABLE municipio IS
    'Catálogo de municipios agrupados por departamento.';

ALTER TABLE municipio ADD CONSTRAINT pk_municipio PRIMARY KEY ( id_municipio );

CREATE TABLE plaza (
    id_plaza             NUMBER NOT NULL,
    especialidad_tecnica VARCHAR2(120) NOT NULL,
    id_empresa           NUMBER NOT NULL,
    id_contacto          NUMBER NOT NULL
);

COMMENT ON TABLE plaza IS
    'Plaza de práctica ofrecida por una empresa.';

ALTER TABLE plaza ADD CONSTRAINT pk_plaza PRIMARY KEY ( id_plaza );

CREATE TABLE sector_economico (
    id_sector NUMBER NOT NULL,
    nombre    VARCHAR2(100) NOT NULL
);

COMMENT ON TABLE sector_economico IS
    'Catálogo de sectores económicos de las empresas.';

ALTER TABLE sector_economico ADD CONSTRAINT pk_sector_economico PRIMARY KEY ( id_sector );

ALTER TABLE sector_economico ADD CONSTRAINT uk_sector_economico_nombre UNIQUE ( nombre );

CREATE TABLE tipo_evaluacion (
    id_tipo_evaluacion NUMBER NOT NULL,
    nombre             VARCHAR2(30) NOT NULL
);

COMMENT ON TABLE tipo_evaluacion IS
    'Catálogo de tipos de evaluación.';

ALTER TABLE tipo_evaluacion ADD CONSTRAINT pk_tipo_evaluacion PRIMARY KEY ( id_tipo_evaluacion );

ALTER TABLE tipo_evaluacion ADD CONSTRAINT uk_tipo_evaluacion_nombre UNIQUE ( nombre );

ALTER TABLE bitacora
    ADD CONSTRAINT fk_bitacora_colocacion FOREIGN KEY ( id_colocacion )
        REFERENCES colocacion ( id_colocacion );

ALTER TABLE bitacora
    ADD CONSTRAINT fk_bitacora_contacto FOREIGN KEY ( id_contacto_validador )
        REFERENCES contacto_empresarial ( id_contacto );

ALTER TABLE catedratico
    ADD CONSTRAINT fk_catedratico_instituto FOREIGN KEY ( id_instituto )
        REFERENCES instituto ( id_instituto );

ALTER TABLE colocacion
    ADD CONSTRAINT fk_colocacion_catedratico FOREIGN KEY ( id_catedratico )
        REFERENCES catedratico ( id_catedratico );

ALTER TABLE colocacion
    ADD CONSTRAINT fk_colocacion_estado FOREIGN KEY ( id_estado )
        REFERENCES estado_colocacion ( id_estado );

ALTER TABLE colocacion
    ADD CONSTRAINT fk_colocacion_estudiante FOREIGN KEY ( id_estudiante )
        REFERENCES estudiante ( carne );

ALTER TABLE colocacion
    ADD CONSTRAINT fk_colocacion_plaza FOREIGN KEY ( id_plaza )
        REFERENCES plaza ( id_plaza );

ALTER TABLE contacto_empresarial
    ADD CONSTRAINT fk_contacto_empresa FOREIGN KEY ( id_empresa )
        REFERENCES empresa ( id_empresa );

ALTER TABLE detalle_evaluacion
    ADD CONSTRAINT fk_detalle_criterio FOREIGN KEY ( id_criterio )
        REFERENCES criterio ( id_criterio );

ALTER TABLE detalle_evaluacion
    ADD CONSTRAINT fk_detalle_evaluacion FOREIGN KEY ( id_evaluacion )
        REFERENCES evaluacion ( id_evaluacion );

ALTER TABLE empresa
    ADD CONSTRAINT fk_empresa_sector FOREIGN KEY ( id_sector )
        REFERENCES sector_economico ( id_sector );

ALTER TABLE estudiante
    ADD CONSTRAINT fk_estudiante_instituto FOREIGN KEY ( id_instituto )
        REFERENCES instituto ( id_instituto );

ALTER TABLE estudiante
    ADD CONSTRAINT fk_estudiante_municipio FOREIGN KEY ( id_municipio )
        REFERENCES municipio ( id_municipio );

ALTER TABLE evaluacion
    ADD CONSTRAINT fk_evaluacion_catedratico FOREIGN KEY ( id_catedratico )
        REFERENCES catedratico ( id_catedratico );

ALTER TABLE evaluacion
    ADD CONSTRAINT fk_evaluacion_colocacion FOREIGN KEY ( id_colocacion )
        REFERENCES colocacion ( id_colocacion );

ALTER TABLE evaluacion
    ADD CONSTRAINT fk_evaluacion_tipo FOREIGN KEY ( id_tipo_evaluacion )
        REFERENCES tipo_evaluacion ( id_tipo_evaluacion );

ALTER TABLE municipio
    ADD CONSTRAINT fk_municipio_departamento FOREIGN KEY ( id_departamento )
        REFERENCES departamento ( id_departamento );

ALTER TABLE plaza
    ADD CONSTRAINT fk_plaza_contacto FOREIGN KEY ( id_contacto )
        REFERENCES contacto_empresarial ( id_contacto );

ALTER TABLE plaza
    ADD CONSTRAINT fk_plaza_empresa FOREIGN KEY ( id_empresa )
        REFERENCES empresa ( id_empresa );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            16
-- CREATE INDEX                             0
-- ALTER TABLE                             42
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
