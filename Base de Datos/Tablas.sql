drop database PedidosOnline;
create database PedidosOnline;
use PedidosOnline;

drop table if exists AreaDeTrabajo;
create table AreaDeTrabajo(
	IdArea char(1) primary key not null,
    NameArea varchar(40) not null
);

drop table if exists CategoriaProd;
create table CategoriaProd(
	IdCategoria char(4) primary key not null,
    NombreCat varchar(40)
);

drop table if exists Productos;
create table Productos(
	IdProducto char(5) primary key not null,
    IdCategoria char(4) not null,
    foreign key Productos(IdCategoria) references CategoriaProd(IdCategoria),
    Nombre varchar(40),
    Precio int
);

drop table if exists Empleados;
create table Empleados(
	IdEmpleado char(5) primary key not null,
    IdArea char(1) not null,
    foreign key Empleados(IdArea) references AreaDeTrabajo(IdArea),
    Nombres varchar(50) not null,
    Apellidos varchar(100) not null,
    DNI char(8) not null
);

drop table if exists Login;
create table Login(
	Username varchar(50) not null,
    Pass varchar (150) not null
);

drop table if exists Cliente;
create table Cliente(
	IdCliente char(5) primary key not null,
    Nombres varchar(50) not null,
    Apellido varchar(50) not null,
    DNI char(8) not null
);

drop table if exists Pedidos;
create table Pedidos(
	IdPedido char(5) primary key not null,
	IdCliente char(5) not null,
    foreign key Pedidos(IdCliente) references Cliente(IdCliente),
    CantidadProd int,
    IdProducto char(5) not null,
    PrecioTotal int
);
ALTER TABLE Pedidos ADD FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto);

drop table if exists DetallePedido;
create table DetallePedido(
	IdPedido char(5) not null,
	CONSTRAINT IdPedidosFK foreign key DetallePedido(IdPedido) references Pedidos(IdPedido),
    IdProducto char(5) not null,
    Cantidad int not null,
    Subtotal int not null,
    Estado varchar(40)
);

ALTER TABLE DetallePedido ADD CONSTRAINT ProductoPK foreign key (IdProducto) references Productos(IdProducto);


drop table if exists Envio;
create table Envio(
	IdPedido char(5) not null,
    CONSTRAINT PedidosFK foreign key Envio(IdPedido) references Pedidos(IdPedido),
    IdArea char(1) not null,
    CONSTRAINT AreaFK foreign key Envio(IdArea) references AreaDeTrabajo(IdArea),
    IdEmpleado char(5) not null,
    CONSTRAINT EmpleadosFK foreign key Envio(IdEmpleado) references Empleados(IdEmpleado),
    Nombres varchar(40) not null,
    Apellidos varchar(50) not null,
    DNI char(8) not null
);

Drop table if exists Produccion;
create table Produccion(
	IdPedido char(5) not null,
    CONSTRAINT Pedidos1FK foreign key Produccion(IdPedido) references Pedidos(IdPedido),
    IdProducto char(5) not null,
    CONSTRAINT Producto1FK foreign key Produccion(IdProducto) references Productos(IdProducto),
    IdCategoria char(1) not null,
    CONSTRAINT Cate1FK foreign key Produccion(IdCategoria) references CategoriaProd(IdCategoria),
    Nombre varchar(40) not null,
    Cantidad int not null
);

drop table if exists EntregaProducto;
create table EntregaProducto(
	IdPedido char(5) not null,
    CONSTRAINT Pedidos2FK foreign key EntregaProducto(IdPedido) references Produccion(IdPedido),
    IdProducto char(5) not null,
    CONSTRAINT Producto2FK foreign key EntregaProducto(IdProducto) references Produccion(IdProducto)
);

drop table if exists Administrador;
create table Administrador(
	IdAdmin char(5) not null primary key,
    IdArea char(1) not null,
    foreign key Administrador(IdArea) references AreaDeTrabajo(IdArea),
    Nombre varchar(40) not null,
    Apellido varchar(50) not null,
    DNI char(8) not null
);

drop table if exists Ventas;
create table Ventas(
	IdPedido char(5) not null,
    foreign key Ventas(IdPedido) references EntregaProducto(IdPedido),
    Precio int not null
);










