-- Generado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   en:        2026-08-15 00:29:20 CST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE BITACORA 
    ( 
     id_bitacora            NUMBER  NOT NULL , 
     correlativo            NUMBER (5)  NOT NULL , 
     fecha                  DATE  NOT NULL , 
     horas_trabajadas       NUMBER (6,2)  NOT NULL , 
     actividades_realizadas VARCHAR2 (1000)  NOT NULL , 
     observaciones          VARCHAR2 (1000) , 
     fecha_validacion       DATE , 
     id_contacto_validador  NUMBER  NOT NULL , 
     id_colocacion          NUMBER  NOT NULL 
    ) 
;

COMMENT ON TABLE BITACORA IS 'Entrada diaria de bitácora asociada a una colocación.'
;

ALTER TABLE BITACORA 
    ADD CONSTRAINT pk_bitacora PRIMARY KEY ( id_bitacora ) ;

CREATE TABLE CATEDRATICO_SUPERVISOR 
    ( 
     id_catedratico         NUMBER  NOT NULL , 
     nombre                 VARCHAR2 (150)  NOT NULL , 
     identificacion         VARCHAR2 (40)  NOT NULL , 
     telefono               VARCHAR2 (25)  NOT NULL , 
     especialidad_supervisa VARCHAR2 (120)  NOT NULL , 
     id_instituto           NUMBER  NOT NULL 
    ) 
;

COMMENT ON TABLE CATEDRATICO_SUPERVISOR IS 'Catedrático asignado por un instituto para supervisar estudiantes en práctica.'
;

ALTER TABLE CATEDRATICO_SUPERVISOR 
    ADD CONSTRAINT pk_catedratico PRIMARY KEY ( id_catedratico ) ;

ALTER TABLE CATEDRATICO_SUPERVISOR 
    ADD CONSTRAINT uk_catedratico_ident UNIQUE ( identificacion ) ;

CREATE TABLE COLOCACION 
    ( 
     id_colocacion      NUMBER  NOT NULL , 
     fecha_inicio       DATE  NOT NULL , 
     fecha_finalizacion DATE , 
     estado             VARCHAR2 (12)  NOT NULL , 
     id_estudiante      NUMBER  NOT NULL , 
     id_catedratico     NUMBER  NOT NULL , 
     id_plaza           NUMBER  NOT NULL 
    ) 
;

COMMENT ON TABLE COLOCACION IS 'Asignación histórica de un estudiante a una plaza de práctica.'
;

ALTER TABLE COLOCACION 
    ADD CONSTRAINT pk_colocacion PRIMARY KEY ( id_colocacion ) ;

CREATE TABLE CONTACTO_EMPRESARIAL 
    ( 
     id_contacto NUMBER  NOT NULL , 
     nombre      VARCHAR2 (150)  NOT NULL , 
     telefono    VARCHAR2 (25)  NOT NULL , 
     correo      VARCHAR2 (150)  NOT NULL , 
     id_empresa  NUMBER  NOT NULL 
    ) 
;

COMMENT ON TABLE CONTACTO_EMPRESARIAL IS 'Contacto designado por una empresa que funge como supervisor externo.'
;

ALTER TABLE CONTACTO_EMPRESARIAL 
    ADD CONSTRAINT pk_contacto_empresarial PRIMARY KEY ( id_contacto ) ;

CREATE TABLE CRITERIO_EVALUACION 
    ( 
     id_criterio NUMBER  NOT NULL , 
     nombre      VARCHAR2 (120)  NOT NULL , 
     descripcion VARCHAR2 (500) 
    ) 
;

COMMENT ON TABLE CRITERIO_EVALUACION IS 'Criterio utilizado para calificar una evaluación, por ejemplo puntualidad, calidad, actitud o dominio técnico.'
;

ALTER TABLE CRITERIO_EVALUACION 
    ADD CONSTRAINT pk_criterio_evaluacion PRIMARY KEY ( id_criterio ) ;

ALTER TABLE CRITERIO_EVALUACION 
    ADD CONSTRAINT uk_criterio_nombre UNIQUE ( nombre ) ;

CREATE TABLE DETALLE_EVALUACION 
    ( 
     id_detalle    NUMBER  NOT NULL , 
     puntuacion    NUMBER (1)  NOT NULL , 
     id_criterio   NUMBER  NOT NULL , 
     id_evaluacion NUMBER  NOT NULL 
    ) 
;

COMMENT ON TABLE DETALLE_EVALUACION IS 'Puntuación de un criterio particular dentro de una evaluación específica.'
;

ALTER TABLE DETALLE_EVALUACION 
    ADD CONSTRAINT pk_detalle_evaluacion PRIMARY KEY ( id_detalle ) ;

CREATE TABLE EMPRESA 
    ( 
     id_empresa       NUMBER  NOT NULL , 
     nombre           VARCHAR2 (150)  NOT NULL , 
     direccion        VARCHAR2 (250)  NOT NULL , 
     sector_economico VARCHAR2 (20)  NOT NULL 
    ) 
;

COMMENT ON TABLE EMPRESA IS 'Empresa afiliada al programa EPS.'
;

ALTER TABLE EMPRESA 
    ADD CONSTRAINT pk_empresa PRIMARY KEY ( id_empresa ) ;

CREATE TABLE ESTUDIANTE 
    ( 
     id_estudiante           NUMBER  NOT NULL , 
     nombre_completo         VARCHAR2 (180)  NOT NULL , 
     carne                   VARCHAR2 (40)  NOT NULL , 
     carrera_tecnica         VARCHAR2 (120)  NOT NULL , 
     direccion               VARCHAR2 (250)  NOT NULL , 
     telefono                VARCHAR2 (25)  NOT NULL , 
     fecha_nacimiento        DATE  NOT NULL , 
     genero                  VARCHAR2 (40)  NOT NULL , 
     departamento_residencia VARCHAR2 (100)  NOT NULL , 
     municipio_residencia    VARCHAR2 (100)  NOT NULL , 
     tipo_practica           VARCHAR2 (12)  NOT NULL , 
     id_instituto            NUMBER  NOT NULL 
    ) 
;

COMMENT ON TABLE ESTUDIANTE IS 'Estudiante de instituto técnico que realiza una práctica EPS.'
;

ALTER TABLE ESTUDIANTE 
    ADD CONSTRAINT pk_estudiante PRIMARY KEY ( id_estudiante ) ;

ALTER TABLE ESTUDIANTE 
    ADD CONSTRAINT uk_estudiante_carne UNIQUE ( carne ) ;

CREATE TABLE EVALUACION 
    ( 
     id_evaluacion    NUMBER  NOT NULL , 
     tipo_evaluacion  VARCHAR2 (10)  NOT NULL , 
     fecha_evaluacion DATE  NOT NULL , 
     id_catedratico   NUMBER  NOT NULL , 
     id_colocacion    NUMBER  NOT NULL 
    ) 
;

COMMENT ON TABLE EVALUACION IS 'Evaluación parcial (100 horas) o final (200 horas) de una colocación.'
;

ALTER TABLE EVALUACION 
    ADD CONSTRAINT pk_evaluacion PRIMARY KEY ( id_evaluacion ) ;

CREATE TABLE INSTITUTO 
    ( 
     id_instituto                NUMBER  NOT NULL , 
     nombre                      VARCHAR2 (180)  NOT NULL , 
     direccion                   VARCHAR2 (250)  NOT NULL , 
     codigo_autorizacion_mineduc VARCHAR2 (80)  NOT NULL 
    ) 
;

COMMENT ON TABLE INSTITUTO IS 'Instituto técnico que envía estudiantes al programa EPS.'
;

ALTER TABLE INSTITUTO 
    ADD CONSTRAINT pk_instituto PRIMARY KEY ( id_instituto ) ;

ALTER TABLE INSTITUTO 
    ADD CONSTRAINT uk_instituto_mineduc UNIQUE ( codigo_autorizacion_mineduc ) ;

CREATE TABLE PLAZA 
    ( 
     id_plaza             NUMBER  NOT NULL , 
     especialidad_tecnica VARCHAR2 (120)  NOT NULL , 
     id_contacto          NUMBER  NOT NULL , 
     id_empresa           NUMBER  NOT NULL 
    ) 
;

COMMENT ON TABLE PLAZA IS 'Plaza de práctica ofrecida por una empresa para una especialidad técnica.'
;

ALTER TABLE PLAZA 
    ADD CONSTRAINT pk_plaza PRIMARY KEY ( id_plaza ) ;

ALTER TABLE BITACORA 
    ADD CONSTRAINT fk_bitacora_colocacion FOREIGN KEY 
    ( 
     id_colocacion
    ) 
    REFERENCES COLOCACION 
    ( 
     id_colocacion
    ) 
;

ALTER TABLE BITACORA 
    ADD CONSTRAINT fk_bitacora_contacto FOREIGN KEY 
    ( 
     id_contacto_validador
    ) 
    REFERENCES CONTACTO_EMPRESARIAL 
    ( 
     id_contacto
    ) 
;

ALTER TABLE CATEDRATICO_SUPERVISOR 
    ADD CONSTRAINT fk_catedratico_instituto FOREIGN KEY 
    ( 
     id_instituto
    ) 
    REFERENCES INSTITUTO 
    ( 
     id_instituto
    ) 
;

ALTER TABLE COLOCACION 
    ADD CONSTRAINT fk_colocacion_catedratico FOREIGN KEY 
    ( 
     id_catedratico
    ) 
    REFERENCES CATEDRATICO_SUPERVISOR 
    ( 
     id_catedratico
    ) 
;

ALTER TABLE COLOCACION 
    ADD CONSTRAINT fk_colocacion_estudiante FOREIGN KEY 
    ( 
     id_estudiante
    ) 
    REFERENCES ESTUDIANTE 
    ( 
     id_estudiante
    ) 
;

ALTER TABLE COLOCACION 
    ADD CONSTRAINT fk_colocacion_plaza FOREIGN KEY 
    ( 
     id_plaza
    ) 
    REFERENCES PLAZA 
    ( 
     id_plaza
    ) 
;

ALTER TABLE CONTACTO_EMPRESARIAL 
    ADD CONSTRAINT fk_contacto_empresa FOREIGN KEY 
    ( 
     id_empresa
    ) 
    REFERENCES EMPRESA 
    ( 
     id_empresa
    ) 
;

ALTER TABLE DETALLE_EVALUACION 
    ADD CONSTRAINT fk_detalle_criterio FOREIGN KEY 
    ( 
     id_criterio
    ) 
    REFERENCES CRITERIO_EVALUACION 
    ( 
     id_criterio
    ) 
;

ALTER TABLE DETALLE_EVALUACION 
    ADD CONSTRAINT fk_detalle_evaluacion FOREIGN KEY 
    ( 
     id_evaluacion
    ) 
    REFERENCES EVALUACION 
    ( 
     id_evaluacion
    ) 
;

ALTER TABLE ESTUDIANTE 
    ADD CONSTRAINT fk_estudiante_instituto FOREIGN KEY 
    ( 
     id_instituto
    ) 
    REFERENCES INSTITUTO 
    ( 
     id_instituto
    ) 
;

ALTER TABLE EVALUACION 
    ADD CONSTRAINT fk_evaluacion_catedratico FOREIGN KEY 
    ( 
     id_catedratico
    ) 
    REFERENCES CATEDRATICO_SUPERVISOR 
    ( 
     id_catedratico
    ) 
;

ALTER TABLE EVALUACION 
    ADD CONSTRAINT fk_evaluacion_colocacion FOREIGN KEY 
    ( 
     id_colocacion
    ) 
    REFERENCES COLOCACION 
    ( 
     id_colocacion
    ) 
;

ALTER TABLE PLAZA 
    ADD CONSTRAINT fk_plaza_contacto FOREIGN KEY 
    ( 
     id_contacto
    ) 
    REFERENCES CONTACTO_EMPRESARIAL 
    ( 
     id_contacto
    ) 
;

ALTER TABLE PLAZA 
    ADD CONSTRAINT fk_plaza_empresa FOREIGN KEY 
    ( 
     id_empresa
    ) 
    REFERENCES EMPRESA 
    ( 
     id_empresa
    ) 
;



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             0
-- ALTER TABLE                             29
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
