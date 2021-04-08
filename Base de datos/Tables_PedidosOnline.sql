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
    Precio INT
);

DROP TABLE IF EXISTS Empleados;
create table Empleados(
	Id CHAR(5) NOT NULL PRIMARY KEY,
    IdArea CHAR(3) NOT NULL,
    foreign key (IdArea) REFERENCES AreaDeTrabajo(Id),
    Nombres VARCHAR(50) NOT NULL,
    Apellidos VARCHAR(100) NOT NULL,
    DNI CHAR(8) NOT NULL,
    Contraseña VARCHAR (50) NOT NULL
);

DROP TABLE IF EXISTS logins;
CREATE TABLE logins(
	Username VARCHAR(50) NOT NULL,
    Pass VARCHAR (150) NOT NULL
);

DROP TABLE IF EXISTS Cliente;
CREATE TABLE Cliente(
	Id CHAR(5) NOT NULL PRIMARY KEY,
    Nombres VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    DNI CHAR(8) NOT NULL UNIQUE,
    Correo VARCHAR(90) NOT NULL UNIQUE,
    Contraseña VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS Pedidos;
CREATE TABLE Pedidos(
	Id CHAR(5) NOT NULL PRIMARY KEY,
	IdCliente CHAR(5) NOT NULL,
    foreign key (IdCliente) references Cliente(Id),
    IdProducto CHAR(5) NOT NULL,
    Nombre VARCHAR(70) NOT NULL,
    CantidadProd INT,
    PrecioTotal INT,
    Estado VARCHAR(50) DEFAULT 'Pendiente'
);

ALTER TABLE Pedidos ADD FOREIGN KEY (IdProducto) REFERENCES Productos(Id);

DROP TABLE IF EXISTS DetallePedido;
CREATE TABLE DetallePedido(
	IdPedido CHAR(5) NOT NULL,
	CONSTRAINT IdPedidosFK foreign key (IdPedido) references Pedidos(Id),
    IdProducto CHAR(5) NOT NULL,
    Nombre VARCHAR(70) NOT NULL,
    Cantidad INT NOT NULL,
    Subtotal INT NOT NULL,
    Estado VARCHAR(40) DEFAULT 'Pendiente'
);

ALTER TABLE DetallePedido ADD CONSTRAINT ProductoPK FOREIGN KEY (IdProducto) references Productos(Id);


DROP TABLE IF EXISTS Envio;
CREATE TABLE Envio(
	IdPedido CHAR(5) NOT NULL,
    CONSTRAINT PedidosFK FOREIGN KEY (IdPedido) references Pedidos(Id),
    IdArea CHAR(3) NOT NULL,
    CONSTRAINT AreaFK FOREIGN KEY (IdArea) references AreaDeTrabajo(Id),
    IdEmpleado CHAR(5) NOT NULL,
    CONSTRAINT EmpleadosFK FOREIGN KEY (IdEmpleado) references Empleados(Id),
    Nombres VARCHAR(40) NOT NULL,
    Apellidos VARCHAR(50) NOT NULL,
    DNI CHAR(8) NOT NULL,
    Estado VARCHAR(50) DEFAULT 'Pendiente'
);

DROP TABLE IF EXISTS Produccion;
CREATE TABLE Produccion(
	IdPedido CHAR(5) NOT NULL,
    CONSTRAINT Pedidos1FK FOREIGN KEY (IdPedido) references Pedidos(Id),
    IdProducto CHAR(5) NOT NULL,
    CONSTRAINT Producto1FK FOREIGN KEY (IdProducto) references Productos(Id),
    Nombre VARCHAR(40) NOT NULL,
    Estado VARCHAR(50) NOT NULL DEFAULT 'Pendiente',
    Cantidad INT NOT NULL
);

DROP TABLE IF EXISTS Ventas;
CREATE TABLE Ventas(
	IdPedido CHAR(5) NOT NULL FOREIGN KEY REFERENCES Pedidos(Id),
    Precio INT NOT NULL
);

DROP TABLE IF EXISTS Administrador;
CREATE TABLE Administrador(
	Id CHAR(5) NOT NULL PRIMARY KEY,
    IdArea CHAR(3) NOT NULL,
    FOREIGN KEY (IdArea) references AreaDeTrabajo(Id),
    Nombre VARCHAR(40) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    DNI CHAR(8) NOT NULL,
    Contraseña VARCHAR(50) NOT NULL
);

