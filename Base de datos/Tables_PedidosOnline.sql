/*USE master;
GO
ALTER DATABASE PedidosOnline SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE PedidosOnline*/

CREATE DATABASE PedidosOnline;

USE PedidosOnline;

DROP TABLE IF EXISTS AreaDeTrabajo;
CREATE TABLE AreaDeTrabajo(
	Id CHAR(3) NOT NULL PRIMARY KEY,
    NameArea VARCHAR(40) NOT NULL
);

DROP TABLE IF EXISTS Empleados;
create table Empleados(
	Id CHAR(5) NOT NULL PRIMARY KEY,
    IdArea CHAR(3) NOT NULL,
    foreign key (IdArea) REFERENCES AreaDeTrabajo(Id),
    Nombres VARCHAR(50) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    DNI CHAR(8) NOT NULL,
	Img image, 
    Contraseña VARCHAR (50) NOT NULL
);

DROP TABLE IF EXISTS Cliente;
CREATE TABLE Cliente(
	Id CHAR(5) NOT NULL PRIMARY KEY,
    Nombres VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    DNI CHAR(8) NOT NULL UNIQUE,
    Distrito VARCHAR(70) NOT NULL,
    Correo VARCHAR(90) NOT NULL UNIQUE,
    Contraseña VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS CategoriaProd;
create table CategoriaProd(
	Id CHAR(5) NOT NULL PRIMARY KEY,
    NombreCat VARCHAR(40),
    Cantidad INT 
);

DROP TABLE IF EXISTS Productos;
create table Productos(
	Id CHAR(5) NOT NULL PRIMARY KEY,
    IdCategoria CHAR(5) NOT NULL,
    FOREIGN KEY (IdCategoria) REFERENCES CategoriaProd(Id),
    Nombre VARCHAR(40),
    Precio MONEY
);

DROP TABLE IF EXISTS Pedidos;
CREATE TABLE Pedidos(
	Id CHAR(5) NOT NULL PRIMARY KEY,
	IdCliente CHAR(5) NOT NULL,
    foreign key (IdCliente) references Cliente(Id),
	IdEnvio CHAR(5),
	FOREIGN KEY (IdEnvio) REFERENCES Empleados(Id),
    IdProducto CHAR(5) NOT NULL,
	FOREIGN KEY(IdProducto) REFERENCES Productos(Id),
    Nombre VARCHAR(70) NOT NULL,
    CantidadProd INT NOT NULL,
    PrecioTotal MONEY NOT NULL,
    Distrito VARCHAR(70) NOT NULL,
    Direccion VARCHAR(70) NOT NULL,
    Fecha SMALLDATETIME,
    Estado VARCHAR(50) DEFAULT 'Pendiente'
);

DROP TABLE IF EXISTS DetallePedido;
CREATE TABLE DetallePedido(
	IdPedido CHAR(5) NOT NULL,
	CONSTRAINT IdPedidosFK FOREIGN KEY (IdPedido) references Pedidos(Id) ON DELETE CASCADE,
	IdProducto CHAR(5) NOT NULL,
	FOREIGN KEY(IdProducto) REFERENCES Productos(Id),
	NombreProducto VARCHAR(70) NOT NULL,
    Cantidad INT NOT NULL,
    Subtotal MONEY NOT NULL,
	Total MONEY NOT NULL,
	Fecha SMALLDATETIME,
    Estado VARCHAR(40) DEFAULT 'Pendiente'
);


DROP TABLE IF EXISTS Proveedor
CREATE TABLE Proveedor(
	Id CHAR(5) PRIMARY KEY NOT NULL,
	Nombre VARCHAR(80) NOT NULL,
	Email VARCHAR(80) NOT NULL,
	Telefono CHAR(9) NOT NULL,
)

