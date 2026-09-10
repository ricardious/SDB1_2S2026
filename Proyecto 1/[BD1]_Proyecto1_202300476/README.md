# Proyecto 1 — Comercial La Estrella

Entrega de **Alex Ricardo Castañeda Rodríguez**, carné **202300476**, para Bases de Datos 1.

## Orden de ejecución

1. Abrir una conexión a un esquema Oracle vacío en SQL Developer.
2. Ejecutar `03_creacion_DB.sql` con **Run Script (F5)**.
3. Ejecutar `03_carga_datos.sql` con **Run Script (F5)**. El resumen debe sumar 9,068 filas.
4. Ejecutar `04_Consulta1.sql` a `04_Consulta8.sql` individualmente.
5. Ejecutar `05_validaciones.sql`; sus cuatro conteos deben ser cero.

El archivo `Modelo_Comercial_La_Estrella.dmd` debe mantenerse junto a la carpeta
`Modelo_Comercial_La_Estrella`. Los PNG/SVG exportados se encuentran en `modelos`.

La carga conserva los identificadores del Excel y sus 45 correos nulos. Las fechas se
convierten explícitamente con `TO_DATE` y el script desactiva sustitución con `SET DEFINE OFF`.
