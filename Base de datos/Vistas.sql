use PedidosOnline
go
--------------------------------------Vista-Cliente---------------------------------------------
DROP PROC Sp_VistaCliente
GO
CREATE PROCEDURE Sp_VistaCliente
as
select * from Cliente
go 
exec Sp_VistaCliente
go
--------------------------------------Vista-Empleado---------------------------------------------
DROP PROC Sp_VistaEmpleado
GO
CREATE PROCEDURE Sp_VistaEmpleado
as
select * from Empleados
go

exec Sp_VistaEmpleado
go
--------------------------------------Vista Empleado(Cocina)--------------------------------------
DROP PROC Sp_VistaCocina
GO
CREATE PROCEDURE Sp_VistaCocina
AS
SELECT*FROM Empleados WHERE IdArea='COC'
GO

EXEC Sp_VistaCocina
GO
--------------------------------------Vista Empleado(Mostrador)--------------------------------------
DROP PROC Sp_VistaMostrador
GO
CREATE PROCEDURE Sp_VistaMostrador
AS
SELECT*FROM Empleados WHERE IdArea='MOS'
GO
--------------------------------------Vista Empleado(Envios)--------------------------------------
DROP PROC Sp_VistaEmpEnvio
GO
CREATE PROCEDURE Sp_VistaEmpEnvio
AS
SELECT*FROM Empleados WHERE IdArea='ENV'
GO
--------------------------------------Vista-Productos---------------------------------------------
DROP PROC Sp_VistaProductos
GO
CREATE PROCEDURE Sp_VistaProductos
as
Select * from Productos
go

exec Sp_VistaProductos
go
--------------------------------------Vista-Produccion---------------------------------------------
DROP PROC Sp_VistaProduccion
GO
CREATE PROCEDURE Sp_VistaProduccion
as
Select * from Produccion
go

exec Sp_VistaProduccion
go
--------------------------------------Vista-AreaTrabajo---------------------------------------------
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

--------------------------------------Vista-CategoriaProd---------------------------------------------
DROP PROC Sp_VistaCategoriaProd
GO
CREATE PROCEDURE Sp_VistaCategoriaProd
as
Select * from CategoriaProd
go

exec Sp_VistaCategoriaProd
Go

--------------------------------------Vista-Pedidos---------------------------------------------
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
--------------------------------------Vista-DetallePedido---------------------------------------------
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
--------------------------------------Vista-logins---------------------------------------------
DROP PROC Sp_VistaLogins
GO
CREATE PROCEDURE Sp_VistaLogins
as
Select * from logins
go

exec Sp_VistaLogins
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
--------------------------------------Vista-Administrador---------------------------------------------
DROP PROC Sp_VistaAdministrador
GO
CREATE PROCEDURE Sp_VistaAdministrador
@id char(5)
as
begin
	Select * from Administrador where Id=@id
end

----------------------------------------------------------------------------------------------------------
EXEC Sp_VistaAdministrador 'A-001'
GO