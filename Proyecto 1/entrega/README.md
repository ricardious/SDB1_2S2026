# Proyecto 1 — Comercial La Estrella

Entrega de **Alex Ricardo Castañeda Rodríguez**, carné **202300476**, para Bases de Datos 1.

## Registro de ejecución

1. Se estableció una conexión a un esquema Oracle vacío en SQL Developer.
2. `03_creacion_DB.sql` creó las 19 tablas y sus restricciones.
3. La información del Excel se cargó en orden de dependencias y los conteos sumaron 9,068 filas.
4. `06_conteos_carga.sql` reprodujo la conciliación de las 19 tablas.
5. `04_Consulta1.sql` a `04_Consulta8.sql` produjeron resultados representativos.
6. `05_validaciones.sql` produjo cuatro conteos iguales a cero.

El archivo `Modelo_Comercial_La_Estrella.dmd` se entrega junto a su carpeta asociada
`Modelo_Comercial_La_Estrella`. Las exportaciones vectoriales se encuentran en `modelos`.

La carga conserva los identificadores del Excel y sus 45 correos nulos. Las fechas se
convierten explícitamente con `TO_DATE` y el script desactiva sustitución con `SET DEFINE OFF`.
