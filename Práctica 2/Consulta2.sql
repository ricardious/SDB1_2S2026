-- Universidad de San Carlos de Guatemala
-- Curso: Bases de Datos 1
-- Práctica 2 - Consulta 2
-- Nombre: Alex Ricardo Castañeda Rodríguez
-- Carné: 202300476
-- Sección: B
--
-- Oferta de plazas por empresa.
-- Cuenta las plazas de cada empresa y muestra primero las que ofrecen más.

SELECT empresa.nombre AS nombre_empresa,
       COUNT(plaza.id_plaza) AS cantidad_total_plazas
FROM empresa
LEFT JOIN plaza
  ON plaza.id_empresa = empresa.id_empresa
GROUP BY empresa.id_empresa,
         empresa.nombre
ORDER BY cantidad_total_plazas DESC,
         empresa.nombre;
