-- Universidad de San Carlos de Guatemala
-- Curso: Bases de Datos 1
-- Práctica 2 - Consulta 4
-- Nombre: Alex Ricardo Castañeda Rodríguez
-- Carné: 202300476
-- Sección: B
--
-- Estudiantes en repitencia.
-- Muestra su instituto, contacto empresarial y estado de colocación.

SELECT estudiante.nombre_completo AS nombre_estudiante,
       instituto.nombre AS nombre_instituto,
       contacto_empresarial.nombre AS nombre_contacto,
       estado_colocacion.nombre AS estado_actual_colocacion
FROM estudiante
JOIN instituto
  ON instituto.id_instituto = estudiante.id_instituto
JOIN colocacion
  ON colocacion.id_estudiante = estudiante.carne
JOIN estado_colocacion
  ON estado_colocacion.id_estado = colocacion.id_estado
JOIN plaza
  ON plaza.id_plaza = colocacion.id_plaza
JOIN contacto_empresarial
  ON contacto_empresarial.id_contacto = plaza.id_contacto
WHERE estudiante.es_repitencia = 1
ORDER BY estudiante.nombre_completo;
