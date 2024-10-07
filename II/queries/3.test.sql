use staging;
-- Verificar el número de registros en cada tabla
SELECT 'Dim_Cliente' AS Tabla, COUNT(*) AS NumRegistros FROM Dim_Cliente
UNION ALL
SELECT 'Dim_Producto', COUNT(*) FROM Dim_Producto
UNION ALL
SELECT 'Dim_Categoria', COUNT(*) FROM Dim_Categoria
UNION ALL
SELECT 'Dim_Empleado', COUNT(*) FROM Dim_Empleado
UNION ALL
SELECT 'Dim_Oficina', COUNT(*) FROM Dim_Oficina
UNION ALL
SELECT 'Fact_Ventas', COUNT(*) FROM Fact_Ventas;


-- Verificar la integridad de los datos en Fact_Ventas
SELECT COUNT(*) AS Ventas_Sin_Cliente
FROM Fact_Ventas fv
LEFT JOIN Dim_Cliente dc ON fv.ID_Cliente = dc.ID_Cliente
WHERE dc.ID_Cliente IS NULL;

-- Comparar totales de ventas entre Jardineria y Staging
SELECT SUM(cantidad * precio_unidad) AS Total_Ventas_Jardineria
FROM Jardineria.dbo.detalle_pedido;

SELECT SUM(Total_Linea) AS Total_Ventas_Staging
FROM Fact_Ventas;