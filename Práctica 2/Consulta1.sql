-- Universidad de San Carlos de Guatemala
-- Curso: Bases de Datos 1
-- Práctica 2 - Consulta 1
-- Nombre: Alex Ricardo Castañeda Rodríguez
-- Carné: 202300476
-- Sección: B
--
-- Directorio de estudiantes con colocación activa.
-- Muestra el carné, estudiante, empresa y especialidad de la plaza.

SELECT estudiante.carne AS carne_estudiante,
       estudiante.nombre_completo AS nombre_estudiante,
       empresa.nombre AS nombre_empresa,
       plaza.especialidad_tecnica AS especialidad_plaza
FROM estudiante
JOIN colocacion
  ON colocacion.id_estudiante = estudiante.carne
JOIN plaza
  ON plaza.id_plaza = colocacion.id_plaza
JOIN empresa
  ON empresa.id_empresa = plaza.id_empresa
JOIN estado_colocacion
  ON estado_colocacion.id_estado = colocacion.id_estado
WHERE estado_colocacion.nombre = 'Activa'
ORDER BY estudiante.carne;
