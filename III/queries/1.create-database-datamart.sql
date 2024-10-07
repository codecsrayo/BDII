create database datamart;
use datamart;

CREATE TABLE Dim_Cliente (
    ID_Cliente INT PRIMARY KEY,
    Nombre_Cliente VARCHAR(50) NOT NULL,
    Ciudad VARCHAR(50),
    Pais VARCHAR(50),
    Limite_Credito NUMERIC(15,2)
);

-- Crear tabla Dim_Producto
CREATE TABLE Dim_Producto (
    ID_Producto VARCHAR(15) PRIMARY KEY,
    Nombre VARCHAR(70) NOT NULL,
    Categoria INT,
    Precio_Venta NUMERIC(15,2) NOT NULL
);

-- Crear tabla Dim_Categoria
CREATE TABLE Dim_Categoria (
    ID_Categoria INT PRIMARY KEY,
    Desc_Categoria VARCHAR(50) NOT NULL
);

-- Crear tabla Dim_Empleado
CREATE TABLE Dim_Empleado (
    ID_Empleado INT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido1 VARCHAR(50) NOT NULL,
    Apellido2 VARCHAR(50),
    Puesto VARCHAR(50)
);

-- Crear tabla Dim_Oficina
CREATE TABLE Dim_Oficina (
    ID_Oficina INT PRIMARY KEY,
    Ciudad VARCHAR(30) NOT NULL,
    Pais VARCHAR(50) NOT NULL,
    Region VARCHAR(50)
);

-- Crear tabla Fact_Ventas
CREATE TABLE Fact_Ventas (
    ID_Venta INT IDENTITY(1,1) PRIMARY KEY,
    ID_Pedido INT,
    ID_Cliente INT,
    ID_Producto VARCHAR(15),
    ID_Empleado INT,
    ID_Oficina INT,
    Fecha_Pedido DATE,
    Cantidad INT,
    Precio_Unidad NUMERIC(15,2),
    Total_Linea NUMERIC(15,2),
    FOREIGN KEY (ID_Cliente) REFERENCES Dim_Cliente(ID_Cliente),
    FOREIGN KEY (ID_Producto) REFERENCES Dim_Producto(ID_Producto),
    FOREIGN KEY (ID_Empleado) REFERENCES Dim_Empleado(ID_Empleado),
    FOREIGN KEY (ID_Oficina) REFERENCES Dim_Oficina(ID_Oficina)
);