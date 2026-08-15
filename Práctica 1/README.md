# Práctica 1 - Base de Datos 1

## Descripción

Este proyecto contiene el diseño de una base de datos para administrar las prácticas estudiantiles de EPS. El sistema permite registrar institutos, estudiantes, empresas, plazas, colocaciones, bitácoras y evaluaciones.

El modelo fue diseñado para Oracle Database 11g.

## Entidades

| Entidad | Descripción |
| --- | --- |
| `EMPRESA` | Almacena las empresas afiliadas al programa. |
| `CONTACTO_EMPRESARIAL` | Registra a los supervisores externos de cada empresa. |
| `PLAZA` | Contiene las plazas de práctica ofrecidas por las empresas. |
| `INSTITUTO` | Almacena los institutos técnicos participantes. |
| `CATEDRATICO_SUPERVISOR` | Registra a los catedráticos encargados de supervisar estudiantes. |
| `ESTUDIANTE` | Contiene los datos de los estudiantes que realizan la práctica. |
| `COLOCACION` | Representa la asignación de un estudiante a una plaza. |
| `BITACORA` | Guarda las actividades y horas trabajadas durante la práctica. |
| `EVALUACION` | Registra las evaluaciones parciales y finales. |
| `CRITERIO_EVALUACION` | Define los criterios utilizados para evaluar. |
| `DETALLE_EVALUACION` | Almacena la puntuación obtenida en cada criterio. |

## Relaciones principales

- Una empresa puede tener varios contactos empresariales y ofrecer varias plazas.
- Un instituto puede registrar varios estudiantes y catedráticos supervisores.
- Una colocación relaciona a un estudiante, una plaza y un catedrático supervisor.
- Una colocación puede tener varias entradas de bitácora y varias evaluaciones.
- Una evaluación se divide en criterios mediante el detalle de evaluación.

## Claves

- `PK`: clave primaria que identifica de forma única cada registro.
- `FK`: clave foránea que relaciona una tabla con otra.
- `UK`: clave única que evita valores duplicados.

Las claves únicas del modelo son:

- Carné del estudiante.
- Identificación del catedrático.
- Código de autorización del instituto.
- Nombre del criterio de evaluación.

## Archivos del proyecto

| Archivo | Contenido |
| --- | --- |
| `MODELO_RELACIONAL_EPS.ddl` | Instrucciones SQL para crear las tablas y sus relaciones en Oracle. |
| `Practica1_EPS.dmd` | Modelo creado con Oracle SQL Developer Data Modeler. |
| `ModeloConceptual.dot` | Código fuente Graphviz del modelo conceptual (notación Chen). |
| `ModeloConceptual.svg` | Diagrama conceptual en formato vectorial. |
| `ModeloConceptual.png` | Diagrama conceptual en formato de imagen. |
| `DiccionarioDatos.csv` | Diccionario de datos en formato CSV. |
| `Diccionario.pdf` | Diccionario de datos y análisis visual del enunciado. |
| `Practica1.pdf` | Documento con las instrucciones de la práctica. |

## Creación de la base de datos

Para crear la estructura de la base de datos:

1. Abrir Oracle SQL Developer.
2. Conectarse a una base de datos Oracle.
3. Abrir el archivo `MODELO_RELACIONAL_EPS.ddl`.
4. Ejecutar el script completo.
5. Verificar que se hayan creado las 11 tablas y sus restricciones.

## Consideraciones

- Los campos marcados como `NOT NULL` son obligatorios.
- Las fechas se almacenan con el tipo `DATE` de Oracle.
- Las puntuaciones de evaluación utilizan valores de 1 a 5.
- Una evaluación puede ser parcial o final.
- La fecha de finalización de una colocación puede quedar vacía mientras la práctica esté activa.
