# Práctica 2 — Bases de Datos 1

En esta práctica se implementó en Oracle una base de datos para gestionar el proceso
de Prácticas Profesionales Supervisadas (EPS). El sistema almacena información de
estudiantes, institutos, empresas, plazas, colocaciones, bitácoras y evaluaciones.

## Trabajo realizado

- Se diseñó el modelo relacional en Oracle SQL Developer Data Modeler.
- Se creó el script `Practica2.ddl` con 16 tablas y sus respectivas llaves primarias,
  foráneas y restricciones de unicidad.
- Se cargó la información de `data/Dataset_Practica2.xlsx`, respetando las
  dependencias entre las tablas.
- Se verificaron la estructura creada y los registros importados.
- Se desarrollaron cinco consultas para analizar la información almacenada.
- Se documentó el procedimiento mediante un manual y capturas de evidencia.

## Consultas desarrolladas

1. Directorio de estudiantes que tienen una colocación activa.
2. Cantidad total de plazas ofrecidas por cada empresa.
3. Total de horas validadas por contacto empresarial durante julio y agosto de 2026.
4. Estudiantes en repitencia, junto con su instituto, contacto empresarial y estado
   de colocación.
5. Colocaciones activas sin bitácoras registradas durante el último mes.

## Organización

```text
Práctica 2/
├── data/                 Archivos utilizados para la carga de datos
├── docs/                 Manual, guía, enunciado y evidencias
├── Modelo_Data_Modeler/  Modelo de la base de datos
├── Consulta1.sql
├── Consulta2.sql
├── Consulta3.sql
├── Consulta4.sql
├── Consulta5.sql
└── Practica2.ddl
```

El desarrollo completo se encuentra explicado en el
[manual de la práctica](./docs/Manual.pdf).
