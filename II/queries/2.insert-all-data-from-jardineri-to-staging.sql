-- Poblar Dim_Cliente
INSERT INTO Dim_Cliente (ID_Cliente, Nombre_Cliente, Ciudad, Pais, Limite_Credito)
SELECT ID_cliente, nombre_cliente, ciudad, pais, limite_credito
FROM Jardineria.dbo.cliente;

-- Poblar Dim_Producto
INSERT INTO Dim_Producto (ID_Producto, Nombre, Categoria, Precio_Venta)
SELECT ID_producto, nombre, Categoria, precio_venta
FROM Jardineria.dbo.producto;

-- Poblar Dim_Categoria
INSERT INTO Dim_Categoria (ID_Categoria, Desc_Categoria)
SELECT Id_Categoria, Desc_Categoria
FROM Jardineria.dbo.Categoria_producto;

-- Poblar Dim_Empleado
INSERT INTO Dim_Empleado (ID_Empleado, Nombre, Apellido1, Apellido2, Puesto)
SELECT ID_empleado, nombre, apellido1, apellido2, puesto
FROM Jardineria.dbo.empleado;

-- Poblar Dim_Oficina
INSERT INTO Dim_Oficina (ID_Oficina, Ciudad, Pais, Region)
SELECT ID_oficina, ciudad, pais, region
FROM Jardineria.dbo.oficina;

-- Poblar Fact_Ventas
INSERT INTO Fact_Ventas (ID_Pedido, ID_Cliente, ID_Producto, ID_Empleado, ID_Oficina, Fecha_Pedido, Cantidad, Precio_Unidad, Total_Linea)
SELECT 
    p.ID_pedido,
    p.ID_cliente,
    dp.ID_producto,
    c.ID_empleado_rep_ventas,
    e.ID_oficina,
    p.fecha_pedido,
    dp.cantidad,
    dp.precio_unidad,
    dp.cantidad * dp.precio_unidad
FROM 
    Jardineria.dbo.pedido p
    JOIN Jardineria.dbo.detalle_pedido dp ON p.ID_pedido = dp.ID_pedido
    JOIN Jardineria.dbo.cliente c ON p.ID_cliente = c.ID_cliente
    JOIN Jardineria.dbo.empleado e ON c.ID_empleado_rep_ventas = e.ID_empleado;