-- Queries para responder a las tres categorías específicas

-- 1. Identificar el producto más vendido
SELECT TOP 1 dp.nombre AS producto_mas_vendido, SUM(fv.cantidad_vendida) AS total_vendido
FROM Fact_Ventas fv
JOIN Dim_Producto dp ON fv.ID_producto = dp.ID_producto
GROUP BY dp.ID_producto, dp.nombre
ORDER BY total_vendido DESC;

-- 2. Identificar la categoría con más productos
SELECT TOP 1 dc.Desc_Categoria AS categoria_con_mas_productos, COUNT(DISTINCT dp.ID_producto) AS cantidad_productos
FROM Dim_Categoria dc
JOIN Dim_Producto dp ON dc.ID_categoria = dp.Categoria
GROUP BY dc.ID_categoria, dc.Desc_Categoria
ORDER BY cantidad_productos DESC;

-- 3. Identificar el año con más ventas
SELECT TOP 1 dt.anio AS anio_con_mas_ventas, SUM(fv.total_venta) AS total_ventas
FROM Fact_Ventas fv
JOIN Dim_Tiempo dt ON fv.ID_tiempo = dt.ID_tiempo
GROUP BY dt.anio
ORDER BY total_ventas DESC;