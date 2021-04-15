use PedidosOnline
go
--------------------------------------VISTA CLIENTES---------------------------------------------
DROP PROC Sp_VistaCliente
GO
CREATE PROCEDURE Sp_VistaCliente
as
select * from Cliente
go 
exec Sp_VistaCliente
go
--------------------------------------Vista Empleado(COCINA)--------------------------------------
DROP PROC Sp_VistaCocina
GO
CREATE PROCEDURE Sp_VistaCocina
AS
SELECT*FROM Empleados WHERE IdArea='COC'
GO

EXEC Sp_VistaCocina
GO
--------------------------------------Vista Empleado(MOSTRADOR)--------------------------------------
DROP PROC Sp_VistaMostrador
GO
CREATE PROCEDURE Sp_VistaMostrador
AS
SELECT*FROM Empleados WHERE IdArea='MOS'
GO
--------------------------------------Vista Empleado(ENVIOS)--------------------------------------
DROP PROC Sp_VistaEmpEnvio
GO
CREATE PROCEDURE Sp_VistaEmpEnvio
AS
SELECT*FROM Empleados WHERE IdArea='ENV'
GO
--------------------------------------VISTA PRODUCTOS---------------------------------------------
DROP PROC Sp_VistaProductos
GO
CREATE PROCEDURE Sp_VistaProductos
as
Select * from Productos
go

exec Sp_VistaProductos
go
------------------------------VISTA AREA DE TRABAJO---------------------------------------------
USE PedidosOnline
GO
DROP PROC Sp_VistaAreaTrabajo
GO
CREATE PROCEDURE Sp_VistaAreaTrabajo
as
Select * from AreaDeTrabajo
go

exec Sp_VistaAreaTrabajo
go

--------------------------------------VISTA CATEGORIA PRODUCTO---------------------------------------------
DROP PROC Sp_VistaCategoriaProd
GO
CREATE PROCEDURE Sp_VistaCategoriaProd
as
Select * from CategoriaProd
go

exec Sp_VistaCategoriaProd
Go

--------------------------------------VISTA PEDIDOS---------------------------------------------
DROP PROC Sp_VistaPedidos
GO
CREATE PROCEDURE Sp_VistaPedidos
as
Select * from Pedidos
go

exec Sp_VistaPedidos
go
--------------------------------------Vista-Pedidos(PENDIENTE)---------------------------------------------
DROP PROC Sp_VistaPedidosPend
GO
CREATE PROCEDURE Sp_VistaPedidosPend
as
Select * from Pedidos WHERE Estado='Pendiente'
go

exec Sp_VistaPedidosPend
go
--------------------------------------Vista-Pedidos(ENVIADOS)---------------------------------------------
DROP PROC Sp_VistaPedidosEnv
GO
CREATE PROCEDURE Sp_VistaPedidosEnv
as
Select * from Pedidos WHERE Estado='Enviado'
go

exec Sp_VistaPedidosEnv
go
--------------------------------------Vista-Pedidos(Listo para enviar)---------------------------------------------
DROP PROC Sp_VistaPedidosLisEnv
GO
CREATE PROCEDURE Sp_VistaPedidosLisEnv
as
Select * from Pedidos WHERE Estado='Listo para enviar'
go

exec Sp_VistaPedidosLisEnv
go
--------------------------------------VISTA DETALLE PEDIDO---------------------------------------------
DROP PROC Sp_VistaDetallePedido
GO
CREATE PROCEDURE Sp_VistaDetallePedido
as
Select * from DetallePedido
go

exec Sp_VistaDetallePedido
go
--------------------------------------Vista-Envio---------------------------------------------
DROP PROC Sp_VistaEnvio
GO
CREATE PROCEDURE Sp_VistaEnvio
as
Select * from Envio
Go

exec Sp_VistaEnvio
go
--------------------------------------Vista-Ventas---------------------------------------------
DROP PROC Sp_VistaVentas
GO
CREATE PROCEDURE Sp_VistaVentas
as
Select * from Ventas
go

exec Sp_VistaVentas
go
--------------------------------------Vista-Empleado---------------------------------------------
DROP PROC Sp_VistaEmpleado
GO
CREATE PROCEDURE Sp_VistaEmpleado
@id char(5)
as
begin
	Select * from Empleados where Id=@id
end
----------------------------------------------------------------------------------------------------------
EXEC Sp_VistaEmpleado 'A-002'
GO

DROP PROC Sp_countTables
GO
CREATE PROC Sp_countTables
@intE VARCHAR(10) OUTPUT,
@intPr VARCHAR(10) OUTPUT,
@intPe VARCHAR(15) OUTPUT,
@intCl VARCHAR(10) OUTPUT
AS 
	BEGIN
		SET @intE=(SELECT COUNT(Id) FROM Empleados)
		SET @intPr=(SELECT COUNT(Id) FROM Productos)
		SET @intPe=(SELECT COUNT(Id) FROM Pedidos)
		SET @intCl=(SELECT COUNT(Id) FROM Cliente)
	END

DECLARE @E VARCHAR(10)
DECLARE @Pr VARCHAR(10)
DECLARE @Pe VARCHAR(10)
DECLARE @Cl VARCHAR(10)
EXEC Sp_countTables @E OUTPUT,@Pr OUTPUT,@Pe OUTPUT,@Cl OUTPUT
SELECT @E 
SELECT @Pr 
SELECT @Pe 
SELECT @Cl 

