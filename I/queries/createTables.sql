-- Crear tablas de dimensiones
CREATE TABLE Dim_Producto (
    ID_producto INT PRIMARY KEY,
    CodigoProducto VARCHAR(15),
    nombre VARCHAR(70),
    Categoria INT,
    dimensiones VARCHAR(25),
    proveedor VARCHAR(50),
    descripcion TEXT,
    cantidad_en_stock SMALLINT,
    precio_venta NUMERIC(15,2),
    precio_proveedor NUMERIC(15,2)
);

CREATE TABLE Dim_Categoria (
    ID_categoria INT PRIMARY KEY,
    Desc_Categoria VARCHAR(50),
    descripcion_texto TEXT
);

CREATE TABLE Dim_Cliente (
    ID_cliente INT PRIMARY KEY,
    nombre_cliente VARCHAR(50),
    nombre_contacto VARCHAR(30),
    apellido_contacto VARCHAR(30),
    telefono VARCHAR(15),
    fax VARCHAR(15),
    linea_direccion1 VARCHAR(50),
    linea_direccion2 VARCHAR(50),
    ciudad VARCHAR(50),
    region VARCHAR(50),
    pais VARCHAR(50),
    codigo_postal VARCHAR(10),
    ID_empleado_rep_ventas INTEGER,
    limite_credito NUMERIC(15,2)
);

CREATE TABLE Dim_Tiempo (
    ID_tiempo INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATE,
    dia INT,
    mes INT,
    anio INT,
    trimestre INT
);

CREATE TABLE Dim_Oficina (
    codigo_oficina VARCHAR(10) PRIMARY KEY,
    ciudad VARCHAR(30),
    pais VARCHAR(50),
    region VARCHAR(50),
    codigo_postal VARCHAR(10),
    telefono VARCHAR(20),
    linea_direccion1 VARCHAR(50),
    linea_direccion2 VARCHAR(50)
);

-- Crear tabla de hechos
CREATE TABLE Fact_Ventas (
    ID_venta INT IDENTITY(1,1) PRIMARY KEY,
    ID_producto INT,
    ID_cliente INT,
    ID_categoria INT,
    ID_tiempo INT,
    codigo_oficina VARCHAR(10),
    cantidad_vendida INT,
    precio_unitario NUMERIC(15,2),
    total_venta NUMERIC(15,2),
    FOREIGN KEY (ID_producto) REFERENCES Dim_Producto(ID_producto),
    FOREIGN KEY (ID_cliente) REFERENCES Dim_Cliente(ID_cliente),
    FOREIGN KEY (ID_categoria) REFERENCES Dim_Categoria(ID_categoria),
    FOREIGN KEY (ID_tiempo) REFERENCES Dim_Tiempo(ID_tiempo),
    FOREIGN KEY (codigo_oficina) REFERENCES Dim_Oficina(codigo_oficina)
);

-- Poblar dimensiones
INSERT INTO Dim_Producto (ID_producto, CodigoProducto, nombre, Categoria, dimensiones, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor)
SELECT ID_producto, CodigoProducto, nombre, Categoria, dimensiones, proveedor, descripcion, cantidad_en_stock, precio_venta, precio_proveedor
FROM producto;

INSERT INTO Dim_Categoria (ID_categoria, Desc_Categoria, descripcion_texto)
SELECT Id_Categoria, Desc_Categoria, descripcion_texto
FROM Categoria_producto;

INSERT INTO Dim_Cliente (ID_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal, ID_empleado_rep_ventas, limite_credito)
SELECT ID_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal, ID_empleado_rep_ventas, limite_credito
FROM cliente;

INSERT INTO Dim_Oficina (codigo_oficina, ciudad, pais, region, codigo_postal, telefono, linea_direccion1, linea_direccion2)
SELECT codigo_oficina, ciudad, pais, region, codigo_postal, telefono, linea_direccion1, linea_direccion2
FROM oficina;

-- Poblar Dim_Tiempo (asumiendo que tenemos datos desde 2006 hasta 2009)
;WITH DateCTE AS (
    SELECT CAST('2006-01-01' AS DATE) AS fecha
    UNION ALL
    SELECT DATEADD(DAY, 1, fecha)
    FROM DateCTE
    WHERE fecha < '2009-12-31'
)
INSERT INTO Dim_Tiempo (fecha, dia, mes, anio, trimestre)
SELECT 
    fecha,
    DAY(fecha) AS dia,
    MONTH(fecha) AS mes,
    YEAR(fecha) AS anio,
    DATEPART(QUARTER, fecha) AS trimestre
FROM DateCTE
OPTION (MAXRECURSION 0);

-- Poblar tabla de hechos
INSERT INTO Fact_Ventas (ID_producto, ID_cliente, ID_categoria, ID_tiempo, codigo_oficina, cantidad_vendida, precio_unitario, total_venta)
SELECT 
    dp.ID_producto,
    p.ID_cliente,
    prod.Categoria AS ID_categoria,
    dt.ID_tiempo,
    e.codigo_oficina,
    dp.cantidad,
    dp.precio_unidad,
    dp.cantidad * dp.precio_unidad AS total_venta
FROM detalle_pedido dp
JOIN pedido p ON dp.ID_pedido = p.ID_pedido
JOIN producto prod ON dp.ID_producto = prod.ID_producto
JOIN Dim_Tiempo dt ON CAST(p.fecha_pedido AS DATE) = dt.fecha
JOIN cliente c ON p.ID_cliente = c.ID_cliente
JOIN empleado e ON c.ID_empleado_rep_ventas = e.ID_empleado;

