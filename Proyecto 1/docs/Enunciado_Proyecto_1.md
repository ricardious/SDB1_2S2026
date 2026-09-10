Universidad San Carlos de Guatemala Facultad de Ingeniería. Ingeniería en Ciencias y Sistemas 

![image](https://cdn-mineru.openxlab.org.cn/result/2026-09-11/781f3081-77a5-4119-aab4-5b2f8a92e886/5eec5ae7c82f45fbfbb3f4e0249f6b54a998edf01dfdd82efe8dbb77eeef3227.jpg)


![image](https://cdn-mineru.openxlab.org.cn/result/2026-09-11/781f3081-77a5-4119-aab4-5b2f8a92e886/0af26bf0510d7bf8d5f1f9dbfd8d2237eb74ce6472e59e4beffa3f7d989f077a.jpg)


![image](https://cdn-mineru.openxlab.org.cn/result/2026-09-11/781f3081-77a5-4119-aab4-5b2f8a92e886/3c4ceb4590fc4c0b444907bff5d86605c920a5a5278d4533c95eacf4396999dd.jpg)


![image](https://cdn-mineru.openxlab.org.cn/result/2026-09-11/781f3081-77a5-4119-aab4-5b2f8a92e886/1a9e977630cc9a3c97314963e261ea73e4c7fbe2b7efcb3b2848e782d7ac07d8.jpg)


# Proyecto 1 Diseño e implementación de una base de datos para el control de ventas

PONDERACIÓN: 35.71 

Tiempo estimado: 30 horas 

## Índice

1. MARCO FORMATIVO 3
1.1 Valor 3
1.2 Competencia(s) 3
1.3 Habilidades blandas a formar 3
2. RESULTADO DEL APRENDIZAJE 4
2.1 Objetivo SMART 4
3. ENUNCIADO DEL PROYECTO 5
3.1 Descripción del problema a resolver 5
3.2 Dataset de guía 5
3.3 Reglas del negocio 6
3.4 Alcance del proyecto 7
3.5 Actividades que deberá realizar 7
3.6 Requerimientos técnicos 8
4. ENTREGABLES 8
5. MATERIAL DE APOYO 9
6. RECURSOS Y HERRAMIENTAS 9
7. CRONOGRAMA 9
8. RÚBRICA DE CALIFICACIÓN 10
8.1 Requisitos para optar a la calificación 10
8.2 Resumen de puntuaciones 10
8.3 Detalle de la calificación 11 

## MARCO FORMATIVO


Valor


<table><tr><td>Nombre del valor</td><td>¿Cómo se aplica en el proyecto?</td></tr><tr><td>Integridad académica y responsabilidad profesional</td><td>El estudiante deberá construir y justificar su propio modelo de datos, scripts SQL y consultas. Puede consultar documentación y utilizar herramientas de apoyo, pero deberá reconocer las fuentes utilizadas y demostrar durante la revisión que comprende cada decisión de diseño, relación, restricción y consulta entregada.</td></tr></table>

## Competencia(s)

Diseña e implementa bases de datos relacionales normalizadas a partir de requerimientos de negocio, aplicando modelos de datos, restricciones de integridad y consultas SQL para obtener información útil. 

## Habilidades blandas a formar

El proyecto permitirá fortalecer las siguientes habilidades: 

• Pensamiento analítico para identificar entidades, atributos, relaciones y cardinalidades a partir de un caso de negocio. 

• Organización para documentar y entregar modelos, scripts y evidencias de ejecución de forma ordenada. 

• Resolución de problemas para traducir reglas de negocio en restricciones y consultas SQL. 

• Comunicación técnica para explicar las decisiones tomadas en el modelo de datos y durante la implementación. 

Integridad académica al elaborar individualmente el diseño, scripts y consultas, y defenderlos durante la revisión. 

## Resultado del Aprendizaje

## Objetivo SMART

El objetivo del proyecto se presenta mediante el enfoque SMART para relacionar el resultado esperado con una evidencia concreta y verificable. 

<table><tr><td>Específico(¿Qué?)</td><td>Medible(¿Cuánto?)</td><td>Alcanzable(¿Cómo?)</td><td>Realista (¿Para qué?)</td><td>A tiempo(¿Cuándo?)</td></tr><tr><td>Diseñar e implementar una base de datos relacional para administrar tiendas, empleados, clientes, productos, ventas y pagos.</td><td>Entregar modelos conceptual, lógico y relacional; diccionario de datos; script DDL; carga de datos; y ocho consultas de reportes.</td><td>Aplicando modelado entidad-relación, normalización hasta 3FN, DDL, DML y DQL en Oracle SQL.</td><td>Para desarrollar la capacidad de convertir requerimientos de un negocio comercial en una base de datos normalizada y consultar información útil para la toma de decisiones.</td><td>Dentro del plazo establecido en el cronograma oficial del proyecto.</td></tr></table>

## Resultados específicos esperados

● Identificar entidades, atributos, llaves, relaciones y cardinalidades a partir de un caso de negocio comercial. 

● Aplicar normalización hasta tercera forma normal para reducir redundancia y evitar inconsistencias en el diseño propuesto. 

● Implementar restricciones de integridad mediante llaves primarias, llaves foráneas, restricciones de unicidad, campos obligatorios y validaciones de dominio. 

● Cargar información consistente en la base de datos respetando las dependencias entre tablas. 

● Elaborar consultas SQL que integren información de varias tablas y generen reportes de ventas útiles para la empresa. 

● Documentar y justificar las decisiones principales del diseño y de la implementación. 

## Enunciado del Proyecto

## Descripción del problema a resolver

La empresa comercial Comercial La Estrella opera una red de tiendas dedicadas a la venta de productos de consumo general. La empresa requiere diseñar e implementar una base de datos relacional que permita administrar la información básica de sus tiendas, empleados, clientes, productos y ventas, así como obtener reportes que apoyen el análisis de sus operaciones comerciales. 

La empresa opera en distintos países. Cada país se identifica mediante un código y un nombre. Dentro de cada país existen varios departamentos y cada departamento agrupa varios municipios. Un departamento pertenece a un único país y un municipio pertenece a un único departamento. 

Cada tienda se identifica mediante un código único. De cada tienda se debe registrar su nombre, dirección, teléfono y municipio donde se encuentra ubicada. Además, cada tienda pertenece a un tipo de tienda, por ejemplo: tienda de conveniencia, supermercado, tienda mayorista o tienda especializada. Un tipo de tienda puede clasificar a varias tiendas, pero cada tienda pertenece a un único tipo. 

La empresa cuenta con empleados asignados a sus tiendas. De cada empleado se debe registrar un código, nombres, apellidos, correo electrónico, teléfono, fecha de contratación y tienda a la que pertenece. Cada empleado ocupa un cargo dentro de la empresa, por ejemplo: gerente de tienda, supervisor, vendedor o cajero. Un cargo puede estar asignado a varios empleados; sin embargo, un empleado tiene un único cargo y pertenece a una única tienda. 

Los clientes pueden realizar compras en cualquiera de las tiendas de la empresa. De cada cliente se debe almacenar un código, nombres, apellidos, tipo de identificación, número de identificación, teléfono, correo electrónico, dirección y municipio de residencia. Cada cliente registra un único tipo de identificación, mientras que un mismo tipo de identificación puede utilizarse para varios clientes. 

La empresa administra un catálogo de productos. Cada producto posee un código, nombre, descripción, precio vigente de venta y existencia actual. Los productos se clasifican por categoría y marca. Cada categoría y cada marca poseen un código y un nombre. Una categoría puede contener varios productos y una marca puede estar asociada con varios productos; cada producto pertenece a una única categoría y a una única marca. 

Las ventas se realizan en una tienda y son atendidas por un empleado. Cada venta debe registrar un número único, fecha, cliente, tienda, empleado responsable y estado actual. Los estados posibles de una venta incluyen, como mínimo: registrada, pagada y anulada. Un cliente puede realizar varias ventas; una tienda puede registrar muchas ventas; y un empleado puede atender varias ventas. 

Cada venta puede incluir uno o varios productos. Por cada producto vendido se debe registrar la cantidad, el precio unitario aplicado durante la venta y el subtotal. El precio unitario del detalle debe conservar el valor aplicado al momento de realizar la operación, aunque el precio vigente del producto cambie posteriormente. 

Una venta puede registrarse con uno o varios pagos. Para cada pago se debe indicar el método de pago utilizado y el monto pagado. La empresa maneja distintos métodos de pago, tales como efectivo, tarjeta de débito, tarjeta de crédito o transferencia. La suma de los pagos de una venta pagada debe corresponder al total de los detalles de la venta. 

La empresa necesita generar reportes sobre las ventas realizadas, los productos más vendidos, las categorías y marcas con mayor facturación, el desempeño de los empleados, las ventas por tienda y tipo de tienda, las compras realizadas por los clientes y los métodos de pago utilizados. 

## Reglas del negocio

## Ubicación

• Cada país debe poseer un código único y un nombre único. 

• Cada departamento debe pertenecer a un único país. 

• El nombre de un departamento no debe repetirse dentro del mismo país. 

• Cada municipio debe pertenecer a un único departamento. 

• El nombre de un municipio no debe repetirse dentro del mismo departamento. 

• Cada tienda debe estar ubicada en un único municipio. 

• Cada cliente debe registrar un único municipio de residencia. 

## Tiendas y empleados

• Cada tipo de tienda debe poseer un código único y un nombre único. 

• Cada tienda debe poseer un código único. 

• Cada tienda pertenece a un único tipo de tienda. 

• Una tienda puede tener cero, uno o varios empleados. 

• Cada cargo debe poseer un código único y un nombre único. 

• Cada empleado debe poseer un código único. 

• Cada empleado pertenece a una única tienda y ocupa un único cargo. 

• El correo electrónico de cada empleado debe ser único. 

• La fecha de contratación de un empleado no puede ser posterior a la fecha actual. 

## Clientes

• Cada tipo de identificación debe poseer un código único y un nombre único. 

• Cada cliente debe poseer un código único. 

• Cada cliente debe registrar un único tipo de identificación. 

• La combinación de tipo de identificación y número de identificación debe ser única. 

• El correo electrónico del cliente debe ser único cuando se encuentre registrado. 

## Productos

• Cada categoría debe poseer un código único y un nombre único. 

• Cada marca debe poseer un código único y un nombre único. 

• Cada producto debe poseer un código único. 

• Cada producto pertenece a una sola categoría y a una sola marca. 

• El precio vigente del producto debe ser mayor que cero. 

• La existencia actual no puede ser negativa. 

## Ventas y pagos

• Cada venta debe poseer un número único. 

Cada venta debe estar relacionada con una tienda, un cliente, un empleado y un estado. 

El empleado que atiende una venta debe pertenecer a la misma tienda en la que se registra la venta. 

• Una venta debe incluir al menos un detalle de venta. 

• Un producto no puede registrarse más de una vez en la misma venta. 

• La cantidad vendida debe ser mayor que cero. 

• El precio unitario registrado en el detalle debe ser mayor que cero. 

• El subtotal se obtiene de multiplicar cantidad por precio unitario. 

• Cada pago debe estar asociado con una única venta y un único método de pago. 

• El monto de un pago debe ser mayor que cero. 

• Las ventas en estado PAGADA deben tener pagos registrados cuya suma sea igual al total de la venta. 

• Las ventas en estado ANULADA no deben considerarse en los reportes de facturación, productos más vendidos ni desempeño de empleados. 

## Alcance del proyecto

El proyecto comprende el análisis del caso de negocio, el diseño de los modelos conceptual, lógico y relacional, la implementación de la base de datos en Oracle SQL, la carga de datos de prueba y la elaboración de consultas para generar reportes de ventas. La solución deberá aplicar normalización hasta tercera forma normal (3FN). Asimismo, deberá definir llaves primarias, llaves foráneas, campos obligatorios, restricciones de unicidad y validaciones de dominio necesarias de acuerdo con las reglas de negocio descritas. 

El modelo deberá cubrir todas las entidades, catálogos, relaciones y tablas asociativas que se desprendan del enunciado. Se espera que una solución correctamente normalizada incluya aproximadamente quince o más tablas. No se evaluará la cantidad de tablas de forma aislada; se evaluará la cobertura del problema, la calidad de la normalización, la integridad referencial y la coherencia entre el modelo, el script DDL, los datos cargados y las consultas entregadas. 

## No se encuentra dentro del alcance del proyecto:

● Gestión de proveedores. 

● Compras, órdenes de compra o abastecimiento. 

● Facturación electrónica, documentos tributarios, impuestos o crédito fiscal. 

● Devoluciones, notas de crédito o anulaciones con historial. 

● Control de inventario mediante movimientos de entrada y salida. 

● Autenticación, administración de usuarios, roles o permisos. 

● Desarrollo de aplicaciones web, móviles o API. 

● Triggers, procedimientos almacenados, funciones definidas por el usuario, cursores, paquetes o auditoría. 

● Dashboards, Power BI, visualizaciones o herramientas de inteligencia de negocios. 

Algunas reglas de consistencia dependen de información almacenada en más de una tabla. Para este proyecto no se solicita implementar triggers, procedimientos almacenados ni funciones. Cuando una regla no pueda garantizarse únicamente mediante restricciones declarativas, deberá documentarse y verificarse mediante una consulta SQL. 

Cualquier supuesto adicional deberá documentarse en el manual técnico y no podrá contradecir las reglas establecidas en este enunciado. 

## Actividades que deberá realizar

1. Analizar el enunciado e identificar las entidades, atributos, relaciones, cardinalidades y reglas de negocio correspondientes. 

2. Elaborar el modelo conceptual entidad–relación que represente el problema planteado. 

3. Elaborar el modelo lógico, identificando llaves primarias, llaves foráneas, atributos obligatorios, restricciones de unicidad y demás restricciones necesarias. 

4. Elaborar el modelo relacional, definiendo las tablas, columnas, tipos de datos y relaciones que se implementarán en Oracle SQL. 

5. Justificar brevemente la aplicación de primera, segunda y tercera forma normal en el diseño propuesto. 

6. Crear un script DDL que permita generar la estructura completa de la base de datos desde un esquema vacío. 

7. Elaborar la carga de datos del excel. 

8. Elaborar las ocho consultas solicitadas para generar los reportes de ventas y las consultas de validación indicadas. 

9. Elaborar un manual técnico breve que documente el orden de ejecución de los scripts, las herramientas utilizadas y las evidencias de funcionamiento. 

10. Prepararse para explicar durante la revisión las decisiones de diseño, las relaciones del modelo, las restricciones definidas y el funcionamiento de las consultas entregadas. 

## Requerimientos técnicos

● Motor de base de datos: Oracle Database. 

● Herramienta de consultas y ejecución: Oracle SQL Developer. 

● Herramienta de modelado: Oracle SQL Data Modeler. Se deberá entregar el archivo fuente del modelo y las imágenes exportadas de los modelos solicitados. 

● Lenguaje: sentencias SQL compatibles con Oracle para DDL, DML y DQL. 

● Nomenclatura: utilizar nombres descriptivos y consistentes. Se permite snake_case en minúsculas o nombres en mayúsculas; se deberá mantener un único estilo en toda la solución. 

● Integridad: definir llaves primarias, llaves foráneas, restricciones NOT NULL, UNIQUE y CHECK cuando correspondan a las reglas de negocio. 

● Scripts: los archivos SQL deberán incluir comentarios, mantener un orden lógico de ejecución y poder ejecutarse desde una base de datos vacía sin requerir correcciones manuales. 

Datos de prueba: la carga deberá incluir información suficiente para que todas las consultas solicitadas generen resultados representativos. No se aceptarán datos que violen las reglas del negocio ni registros huérfanos. 

## Consultas mínimas requeridas

Las consultas deberán entregarse archivos distintos SQL, numeradas y comentadas. Cada consulta debe mostrar únicamente las columnas necesarias, utilizar nombres de salida claros y aplicar ordenamiento cuando sea solicitado. 

1. Ventas por tienda y ubicación: tienda, municipio, departamento, país, cantidad de ventas y total facturado; excluir anuladas. 

2. Ventas por tipo de tienda: tipo de tienda, cantidad de tiendas, cantidad de ventas y monto facturado. 

3. Productos más vendidos: código, producto, categoría, marca, unidades vendidas y monto generado; excluir anuladas. 

4. Desempeño de empleados: empleado, cargo, tienda, cantidad de ventas atendidas y total facturado. 

5. Clientes con mayor compra: cliente, municipio de residencia, cantidad de ventas pagadas y monto total comprado. 

6. Facturación por categoría y marca: categoría, marca, unidades vendidas y total facturado. 

7. Uso de métodos de pago: método de pago, cantidad de pagos y monto total recibido. 

8. Ventas pendientes de pago: ventas con estado registrada, total de venta, total pagado —si existe— y diferencia pendiente. 

## Entregables

<table><tr><td>No.</td><td>Entregable</td><td>Descripción</td><td>Nombre sugerido</td></tr><tr><td>1</td><td>Diccionario de datos</td><td>Entidades, atributos, breve descripción, tipo/dominio propuesto, PK, FK, nulabilidad y restricciones principales</td><td>01_diccionarioDatos.pdf</td></tr><tr><td>2</td><td>Modelo conceptual</td><td>Diagrama entidad-relación conceptual</td><td>02_manual_tecnico.pdf</td></tr><tr><td>3</td><td>Modelo lógico</td><td>Modelo con entidades, atributos, relaciones y cardinalidades</td><td>02_manual_tecnico.pdf</td></tr><tr><td>4</td><td>Modelo relacional</td><td>Tablas, PK, FK y tipos de datos</td><td>02_manual_tecnico.pdf</td></tr><tr><td>5</td><td>Script de creación</td><td>DDL de tablas y restricciones</td><td>03_crecion_DB.sql</td></tr><tr><td>6</td><td>Script de consultas</td><td>Las consultas de reportes, numeradas y comentadas</td><td>04_Consulta1.sql04_Consulta2.sql......</td></tr><tr><td>7</td><td>Manual breve</td><td>Orden de ejecución, herramienta utilizada y capturas o evidencia de consultas ejecutadas</td><td>02_manual_tecnico.pdf</td></tr><tr><td>8</td><td>Archivo de Data Modeler</td><td>Archivo fuente del modelo, si se utiliza Oracle SQL Data Modeler</td><td>según extensión de la herramienta</td></tr></table>

Todos los archivos deberán colocarse en una carpeta comprimida con el formato [BD1]_Proyecto1_#carnet.zip. Ejemplo: [BD1]_Proyecto1_201902416.zip. 

## Material de apoyo

● Enunciado del proyecto y archivos de carga estructurados, si son proporcionados por el docente 

● Guías del curso sobre modelo entidad-relación, modelo relacional y normalización hasta 3FN. 

● Material de clase sobre DDL, DML, DQL, JOIN, GROUP BY, funciones de agregación y subconsultas. 

## Recursos y herramientas a utilizar

Listado de recursos que el estudiante deberá utilizar o investigar: 

● Software: Oracle SQL, DataModeler y SQLDeveloper. 

● Plataformas de entrega: uedi (auxiliar 1) – classroom (auxiliares de apoyo). 

● Equipo: computadora con capacidad para ejecutar Oracle SQL 

## Cronograma

<table><tr><td>Actividad</td><td>Fecha de inicio</td><td>Fecha de finalización</td></tr><tr><td>Asignación del proyecto</td><td>Viernes 28 de agosto</td><td>Jueves 17 de septiembre</td></tr><tr><td>Elaboración</td><td>Viernes 28 de agosto</td><td>Jueves 17 de septiembre</td></tr><tr><td>Entrega final UEDI - Classrom</td><td>Jueves 17 de septiembre</td><td>Jueves 17 de septiembre, 23:59 horas</td></tr><tr><td>Revisión y calificación</td><td>Viernes 18 de septiembre</td><td>Viernes 19 de septiembre</td></tr></table>

## 9.Rúbrica de Calificación

<table><tr><td>Área</td><td>Criterio</td><td>Puntos</td></tr><tr><td>Análisis y diseño</td><td>Diccionario de datos: completitud, claridad y coherencia</td><td>10</td></tr><tr><td>Análisis y diseño</td><td>Modelo conceptual: entidades, relaciones y cardinalidades</td><td>10</td></tr><tr><td>Análisis y diseño</td><td>Modelo lógico y normalización hasta 3FN</td><td>15</td></tr><tr><td>Análisis y diseño</td><td>Modelo relacional: atributos, PK, FK, tipos de datos y restricciones</td><td>15</td></tr><tr><td>Implementación</td><td>Script DDL: ejecución correcta y correspondencia con el modelo</td><td>15</td></tr><tr><td>Implementación</td><td>Script de carga: datos consistentes, suficientes y sin violaciones de integridad</td><td>10</td></tr><tr><td>Consultas</td><td>Ocho consultas de información correctas, claras y funcionales</td><td>16</td></tr><tr><td>Consultas</td><td>Dos consultas de validación correctas y funcionales</td><td>5</td></tr><tr><td>Documentación</td><td>Manual técnico, orden de archivos y evidencia de ejecución</td><td>4</td></tr><tr><td>Total</td><td></td><td>100</td></tr></table>