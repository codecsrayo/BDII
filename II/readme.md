[Atrás](../readme.md)

# S30 - Evidencia de aprendizaje 2. Creación de una base de datos de Staging

## Introducción

Este documento presenta el análisis de la base de datos Jardinería y el proceso de creación de una nueva base de datos Staging. El objetivo es identificar los datos relevantes en Jardinería y diseñar una estructura optimizada para la base de datos Staging.

## Objetivos

1. Analizar la estructura y datos de la base de datos Jardinería.
2. Identificar los datos relevantes para la base de datos Staging.
3. Diseñar la estructura de la base de datos Staging.
4. Crear consultas para transferir datos de Jardinería a Staging.
5. Validar la correcta transferencia de datos.
6. Generar copias de seguridad de ambas bases de datos.

## Planteamiento del problema

La base de datos Jardinería contiene información detallada sobre una empresa de jardinería, incluyendo datos de oficinas, empleados, productos, clientes, pedidos y pagos. Es necesario extraer y organizar esta información en una nueva base de datos Staging para facilitar el análisis y la generación de informes.

## Análisis del problema

### Estructura de la base de datos Jardinería

La base de datos Jardinería consta de las siguientes tablas:

1. oficina
2. empleado
3. Categoria_producto
4. cliente
5. pedido
6. producto
7. detalle_pedido
8. pago

### Datos relevantes para la base de datos Staging

Después de analizar la estructura y los datos de Jardinería, se ha determinado que los siguientes datos son relevantes para la base de datos Staging:

1. Información de ventas (pedidos y detalles de pedidos)
2. Datos de clientes
3. Información de productos y categorías
4. Datos de empleados y oficinas (para análisis de rendimiento de ventas)

## Propuesta de la solución

### Diseño de la base de datos Staging

La base de datos Staging tendrá la siguiente estructura:

1. Dim_Cliente
2. Dim_Producto
3. Dim_Categoria
4. Dim_Empleado
5. Dim_Oficina
6. Fact_Ventas

#### Consultas para crear las tablas en la base de datos Staging

[anexo](./queries/1.create-database-staging.sql)

#### Consultas para poblar las tablas de la base de datos Staging
[anexo](./queries/2.insert-all-data-from-jardineri-to-staging.sql)


### Validación de datos

Después de ejecutar las consultas, es importante validar que los datos se hayan transferido correctamente. Algunas consultas de validación podrían ser:

[anexo](./queries/3.test.sql)


### Creación de copias de seguridad

Para crear copias de seguridad de ambas bases de datos, se pueden utilizar los siguientes comandos T-SQL:

```sql
-- Backup de la base de datos Jardineria
BACKUP DATABASE Jardineria
TO DISK = '/var/backups/Jardineria_Backup.bak'
WITH FORMAT, INIT, NAME = 'Jardineria Full Backup';

-- Backup de la base de datos Staging
BACKUP DATABASE Staging
TO DISK = '/var/backups/Staging_Backup.bak'
WITH FORMAT, INIT, NAME = 'Staging Full Backup';
```

## Conclusiones

La creación de la base de datos Staging a partir de Jardinería permite una mejor organización de los datos para análisis y generación de informes. La estructura dimensional facilita las consultas de rendimiento de ventas, análisis de productos y evaluación del desempeño de empleados.

## backups

1. Archivo de backup de la base de datos Jardinería: Jardineria_Backup.bak
2. Archivo de backup de la base de datos Staging: Staging_Backup.bak
3. Script SQL para la creación y población de la base de datos Staging: Staging_Creation_Script.sql

## Bibliografía

1. Microsoft. (2024). SQL Server Documentation. https://docs.microsoft.com/en-us/sql/sql-server/
2. Kimball, R., & Ross, M. (2013). The Data Warehouse Toolkit: The Definitive Guide to Dimensional Modeling (3rd ed.). Wiley.
3. Date, C. J. (2003). An Introduction to Database Systems (8th ed.). Addison-Wesley.
