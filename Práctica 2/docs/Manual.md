# Manual de carga de datos y consultas

## Práctica 2 — Base de Datos 1

**Universidad de San Carlos de Guatemala**  
**Facultad de Ingeniería**  
**Escuela de Ciencias y Sistemas**

| Dato | Información |
|---|---|
| Nombre | Alex Ricardo Castañeda Rodríguez |
| Carné | 202300476 |
| Sección | B |
| Esquema utilizado | `RICARDIOUS` |
| Fecha | 27 de agosto de 2026 |

---

## 1. Objetivo

Implementar el modelo físico del Sistema de Gestión de Prácticas Profesionales
Supervisadas en Oracle Database, cargar los datos proporcionados respetando la
integridad referencial y elaborar los cinco reportes solicitados mediante consultas
SQL con uniones, agrupaciones y funciones de agregación.

## 2. Ambiente utilizado

- Oracle Database XE.
- Oracle SQL Developer.
- Script de creación `Practica2.ddl`.
- Libro de datos `data/Dataset_Practica2.xlsx`.
- Esquema personal `RICARDIOUS`, identificado en SQL Developer mediante la conexión
  `BD1 Práctica 2`.

La conexión se configuró con el usuario `ricardious`, servidor `localhost`, puerto
`1521` y servicio `XEPDB1`. La prueba de conexión devolvió el estado **Correcto**.

![Conexión correcta a Oracle](<evidencias/01_estructura/00_conexion_oracle.png>)

## 3. Creación de la estructura

Se abrió `Practica2.ddl` en Oracle SQL Developer, se seleccionó la conexión personal
`BD1 Práctica 2` y se ejecutó el archivo completo como script. El DDL contiene la
creación de las 16 tablas y posteriormente agrega sus llaves primarias, únicas y
foráneas.

La salida final confirmó la creación y modificación de las tablas sin mostrar errores
`ORA-`.

![Ejecución del DDL](<evidencias/01_estructura/01_ddl_ejecutado.png>)

Después se consultó `USER_TABLES` para comprobar la estructura creada:

```sql
SELECT table_name
FROM user_tables
ORDER BY table_name;
```

El resultado mostró las 16 tablas esperadas.

![Verificación de las 16 tablas](<evidencias/01_estructura/02_lista_16_tablas.png>)

## 4. Orden de importación

Los datos se importaron desde las hojas de `Dataset_Practica2.xlsx`. Se respetó el
siguiente orden para asegurar que cada registro padre existiera antes de insertar sus
registros dependientes:

| Orden | Tabla | Dependencia | Filas esperadas |
|---:|---|---|---:|
| 1 | `SECTOR_ECONOMICO` | Ninguna | 5 |
| 2 | `DEPARTAMENTO` | Ninguna | 4 |
| 3 | `ESTADO_COLOCACION` | Ninguna | 3 |
| 4 | `TIPO_EVALUACION` | Ninguna | 2 |
| 5 | `CRITERIO` | Ninguna | 5 |
| 6 | `INSTITUTO` | Ninguna | 3 |
| 7 | `MUNICIPIO` | `DEPARTAMENTO` | 8 |
| 8 | `EMPRESA` | `SECTOR_ECONOMICO` | 5 |
| 9 | `CATEDRATICO` | `INSTITUTO` | 5 |
| 10 | `CONTACTO_EMPRESARIAL` | `EMPRESA` | 7 |
| 11 | `ESTUDIANTE` | `MUNICIPIO`, `INSTITUTO` | 7 |
| 12 | `PLAZA` | `EMPRESA`, `CONTACTO_EMPRESARIAL` | 7 |
| 13 | `COLOCACION` | `ESTUDIANTE`, `PLAZA`, `CATEDRATICO`, `ESTADO_COLOCACION` | 7 |
| 14 | `BITACORA` | `COLOCACION`, `CONTACTO_EMPRESARIAL` | 9 |
| 15 | `EVALUACION` | `COLOCACION`, `CATEDRATICO`, `TIPO_EVALUACION` | 4 |
| 16 | `DETALLE_EVALUACION` | `EVALUACION`, `CRITERIO` | 17 |

Este orden evita errores de integridad referencial como `ORA-02291`, los cuales
ocurren cuando se intenta insertar una llave foránea cuyo registro padre todavía no
existe.

## 5. Procedimiento de importación

Para cada tabla se realizó el siguiente procedimiento:

1. Se localizó la tabla dentro de la conexión `BD1 Práctica 2`.
2. Se seleccionó la opción **Import Data**.
3. Se eligió `Dataset_Practica2.xlsx` y la hoja con el mismo nombre de la tabla.
4. Se indicó que la primera fila contenía los encabezados.
5. Se seleccionó el método **Insertar**.
6. Se verificó que cada encabezado del Excel correspondiera con la columna Oracle del
   mismo nombre.
7. Se finalizó la importación y se comprobó el contenido de la tabla.
8. Se confirmó la transacción cuando fue necesario.

La sección siguiente presenta las dos evidencias previstas para cada tabla: la vista
previa del asistente de importación y el resultado almacenado en Oracle.

## 6. Evidencias de importación por tabla

Para documentar el procedimiento completo se incluyeron dos evidencias por cada una
de las 16 tablas, para un total de 32 capturas: la vista previa de importación y el
resultado almacenado en Oracle.

### 6.1 `SECTOR_ECONOMICO`

**Importación:**

![Importación de SECTOR_ECONOMICO](<evidencias/02_importacion/01_sector_economico/importacion.png>)

**Resultado:**

![Resultado de SECTOR_ECONOMICO](<evidencias/02_importacion/01_sector_economico/resultado.png>)

### 6.2 `DEPARTAMENTO`

**Importación:**

![Importación de DEPARTAMENTO](<evidencias/02_importacion/02_departamento/importacion.png>)

**Resultado:**

![Resultado de DEPARTAMENTO](<evidencias/02_importacion/02_departamento/resultado.png>)

### 6.3 `ESTADO_COLOCACION`

**Importación:**

![Importación de ESTADO_COLOCACION](<evidencias/02_importacion/03_estado_colocacion/importacion.png>)

**Resultado:**

![Resultado de ESTADO_COLOCACION](<evidencias/02_importacion/03_estado_colocacion/resultado.png>)

### 6.4 `TIPO_EVALUACION`

**Importación:**

![Importación de TIPO_EVALUACION](<evidencias/02_importacion/04_tipo_evaluacion/importacion.png>)

**Resultado:**

![Resultado de TIPO_EVALUACION](<evidencias/02_importacion/04_tipo_evaluacion/resultado.png>)

### 6.5 `CRITERIO`

**Importación:**

![Importación de CRITERIO](<evidencias/02_importacion/05_criterio/importacion.png>)

**Resultado:**

![Resultado de CRITERIO](<evidencias/02_importacion/05_criterio/resultado.png>)

### 6.6 `INSTITUTO`

**Importación:**

![Importación de INSTITUTO](<evidencias/02_importacion/06_instituto/importacion.png>)

**Resultado:**

![Resultado de INSTITUTO](<evidencias/02_importacion/06_instituto/resultado.png>)

### 6.7 `MUNICIPIO`

**Importación:**

![Importación de MUNICIPIO](<evidencias/02_importacion/07_municipio/importacion.png>)

**Resultado:**

![Resultado de MUNICIPIO](<evidencias/02_importacion/07_municipio/resultado.png>)

### 6.8 `EMPRESA`

**Importación:**

![Importación de EMPRESA](<evidencias/02_importacion/08_empresa/importacion.png>)

**Resultado:**

![Resultado de EMPRESA](<evidencias/02_importacion/08_empresa/resultado.png>)

### 6.9 `CATEDRATICO`

**Importación:**

![Importación de CATEDRATICO](<evidencias/02_importacion/09_catedratico/importacion.png>)

**Resultado:**

![Resultado de CATEDRATICO](<evidencias/02_importacion/09_catedratico/resultado.png>)

### 6.10 `CONTACTO_EMPRESARIAL`

**Importación:**

![Importación de CONTACTO_EMPRESARIAL](<evidencias/02_importacion/10_contacto_empresarial/importacion.png>)

**Resultado:**

![Resultado de CONTACTO_EMPRESARIAL](<evidencias/02_importacion/10_contacto_empresarial/resultado.png>)

### 6.11 `ESTUDIANTE`

**Importación:**

![Importación de ESTUDIANTE](<evidencias/02_importacion/11_estudiante/importacion.png>)

**Resultado:**

![Resultado de ESTUDIANTE](<evidencias/02_importacion/11_estudiante/resultado.png>)

### 6.12 `PLAZA`

**Importación:**

![Importación de PLAZA](<evidencias/02_importacion/12_plaza/importacion.png>)

**Resultado:**

![Resultado de PLAZA](<evidencias/02_importacion/12_plaza/resultado.png>)

### 6.13 `COLOCACION`

**Importación:**

![Importación de COLOCACION](<evidencias/02_importacion/13_colocacion/importacion.png>)

**Resultado:**

![Resultado de COLOCACION](<evidencias/02_importacion/13_colocacion/resultado.png>)

### 6.14 `BITACORA`

**Importación:**

![Importación de BITACORA](<evidencias/02_importacion/14_bitacora/importacion.png>)

**Resultado:**

![Resultado de BITACORA](<evidencias/02_importacion/14_bitacora/resultado.png>)

### 6.15 `EVALUACION`

**Importación:**

![Importación de EVALUACION](<evidencias/02_importacion/15_evaluacion/importacion.png>)

**Resultado:**

![Resultado de EVALUACION](<evidencias/02_importacion/15_evaluacion/resultado.png>)

### 6.16 `DETALLE_EVALUACION`

**Importación:**

![Importación de DETALLE_EVALUACION](<evidencias/02_importacion/16_detalle_evaluacion/importacion.png>)

**Resultado:**

![Resultado de DETALLE_EVALUACION](<evidencias/02_importacion/16_detalle_evaluacion/resultado.png>)

### 6.17 Verificación general opcional

Como comprobación adicional puede ejecutarse el reporte de conteos de las 16 tablas
incluido en `Guia_Desarrollo_Practica_2.md`. Esta evidencia es opcional porque las 32
capturas anteriores ya muestran individualmente la importación y el contenido de
cada tabla.

## 7. Consulta 1 — Directorio de estudiantes activos

Esta consulta relaciona al estudiante con su colocación, plaza, empresa y estado. El
filtro conserva solamente las colocaciones con estado `Activa`.

```sql
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
```

El resultado esperado contiene cinco estudiantes: Diego López, María Aguilar, Sara
Pinzón, Fernando Cruz y Andrés Barrios.

![Resultado de la Consulta 1](<evidencias/03_consultas/01_directorio_estudiantes_activos.png>)

## 8. Consulta 2 — Oferta de plazas por empresa

Se utiliza `LEFT JOIN` para conservar todas las empresas y `COUNT` para contar las
plazas ofrecidas por cada una. La agrupación genera un total independiente por
empresa.

```sql
SELECT empresa.nombre AS nombre_empresa,
       COUNT(plaza.id_plaza) AS cantidad_total_plazas
FROM empresa
LEFT JOIN plaza
  ON plaza.id_empresa = empresa.id_empresa
GROUP BY empresa.id_empresa,
         empresa.nombre
ORDER BY cantidad_total_plazas DESC,
         empresa.nombre;
```

TechNova Solutions y FinTech Guatemala deben mostrar dos plazas cada una; las otras
tres empresas deben mostrar una plaza.

![Resultado de la Consulta 2](<evidencias/03_consultas/02_oferta_plazas_empresa.png>)

## 9. Consulta 3 — Carga de validación por contacto empresarial

La consulta suma las horas de las bitácoras validadas por cada contacto durante julio
y agosto de 2026. El límite superior excluye el 1 de septiembre y cubre los dos meses
completos incluso cuando una fecha contiene una hora.

```sql
SELECT contacto_empresarial.nombre AS nombre_contacto,
       empresa.nombre AS nombre_empresa,
       SUM(bitacora.horas_trabajadas) AS total_horas_validadas
FROM contacto_empresarial
JOIN empresa
  ON empresa.id_empresa = contacto_empresarial.id_empresa
JOIN bitacora
  ON bitacora.id_contacto_validador = contacto_empresarial.id_contacto
WHERE bitacora.fecha >= DATE '2026-07-01'
  AND bitacora.fecha < DATE '2026-09-01'
GROUP BY contacto_empresarial.id_contacto,
         contacto_empresarial.nombre,
         empresa.id_empresa,
         empresa.nombre
ORDER BY total_horas_validadas DESC,
         contacto_empresarial.nombre;
```

Los totales esperados son 16 horas para Ana Morales, Mario Pineda y Sofía Valdez;
14 horas para Carlos Fuentes; y 6 horas para Diana Rosales.

![Resultado de la Consulta 3](<evidencias/03_consultas/03_carga_validacion_contacto.png>)

## 10. Consulta 4 — Estudiantes en repitencia

La condición `ES_REPITENCIA = 1` identifica a los estudiantes repitentes. El contacto
se obtiene mediante la plaza asignada, lo cual permite incluir al estudiante aunque no
tenga registros de bitácora.

```sql
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
```

El resultado esperado es Pedro Samayoa, procedente del Instituto Técnico de
Computación, con Jorge Cifuentes como contacto y una colocación finalizada.

![Resultado de la Consulta 4](<evidencias/03_consultas/04_estudiantes_repitencia.png>)

## 11. Consulta 5 — Auditoría de bitácoras

Se consideran únicamente las colocaciones activas. El `LEFT JOIN` busca bitácoras del
último mes sin eliminar las colocaciones que no tengan registros, y `HAVING` conserva
los grupos cuyo conteo de bitácoras recientes sea cero.

```sql
SELECT colocacion.id_colocacion AS numero_colocacion,
       estudiante.nombre_completo AS nombre_estudiante,
       catedratico.nombre AS nombre_catedratico_supervisor,
       estado_colocacion.nombre AS estado_actual
FROM colocacion
JOIN estudiante
  ON estudiante.carne = colocacion.id_estudiante
JOIN catedratico
  ON catedratico.id_catedratico = colocacion.id_catedratico
JOIN estado_colocacion
  ON estado_colocacion.id_estado = colocacion.id_estado
LEFT JOIN bitacora
  ON bitacora.id_colocacion = colocacion.id_colocacion
 AND bitacora.fecha >= ADD_MONTHS(TRUNC(SYSDATE), -1)
WHERE estado_colocacion.nombre = 'Activa'
GROUP BY colocacion.id_colocacion,
         estudiante.nombre_completo,
         catedratico.nombre,
         estado_colocacion.nombre
HAVING COUNT(bitacora.id_bitacora) = 0
ORDER BY colocacion.id_colocacion;
```

La consulta se ejecutó el 28 de agosto de 2026 interpretando “último mes” como el
periodo transcurrido desde el 28 de julio de 2026. Se localizaron tres colocaciones
activas sin bitácoras durante ese periodo: Diego López, María Aguilar y Sara Pinzón.

![Resultado de la Consulta 5](<evidencias/03_consultas/05_consulta_auditoria_ultimo_mes.png>)

## 12. Conclusiones

1. El orden de carga es indispensable para mantener la integridad referencial entre
   las tablas del modelo.
2. El asistente de importación permite asociar las columnas del Excel con las columnas
   Oracle y comprobar los datos antes de insertarlos.
3. Las uniones permiten reunir información normalizada que se encuentra distribuida
   entre estudiantes, empresas, plazas, colocaciones, contactos y catálogos.
4. Las funciones `COUNT` y `SUM`, junto con `GROUP BY` y `HAVING`, permiten obtener
   los reportes estadísticos y de auditoría solicitados.

---

## Preparación final del PDF

- [x] Incorporar las 32 evidencias correspondientes a las 16 tablas.
- [x] Incorporar la conexión correcta a Oracle.
- [x] Incorporar y verificar los resultados de las cinco consultas.
- [ ] Exportar el documento con el nombre exacto `Manual.pdf`.
