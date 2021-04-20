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
--------------------------------------VISTA ENVIO-----------------------------------------------
DROP PROC Sp_VistaEnvio
GO
CREATE PROCEDURE Sp_VistaEnvio
as
SELECT Id,IdCliente,IdEnvio,Distrito,Direccion,Estado,CONVERT(varchar,Fecha,100)AS Fecha FROM Pedidos WHERE Estado='Listo para enviar'
go

exec Sp_VistaEnvio
go

--------------------------------------VISTA PEDIDOS---------------------------------------------
DROP PROC Sp_VistaPedidos
GO
CREATE PROCEDURE Sp_VistaPedidos
as
Select * from Pedidos
go

exec Sp_VistaPedidos
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
--------------------------------------Vista-Pedidos(LISTO PARA ENVIAR)---------------------------------------------
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

--------------------------------------VISTA DETALLE PEDIDO PENDIENTE---------------------------------------------
DROP PROC Sp_VistaDetallePedidoPendiente
GO
CREATE PROCEDURE Sp_VistaDetallePedidoPendiente
as
Select * from DetallePedido WHERE Estado='Pendiente'
go

exec Sp_VistaDetallePedido
go
--------------------------------------VISTA EMPLEADOS---------------------------------------------
DROP PROC Sp_VistaEmpleado
GO
CREATE PROCEDURE Sp_VistaEmpleado
@id char(5)
as
begin
	Select * from Empleados where Id=@id
end
----------------------------------------------------------------------------------------------------------
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
GO

DECLARE @E VARCHAR(10)
DECLARE @Pr VARCHAR(10)
DECLARE @Pe VARCHAR(10)
DECLARE @Cl VARCHAR(10)
EXEC Sp_countTables @E OUTPUT,@Pr OUTPUT,@Pe OUTPUT,@Cl OUTPUT
SELECT @E 
SELECT @Pr 
SELECT @Pe 
SELECT @Cl 

--------------------------------------VISTA BOLETA---------------------------------------------
DROP PROC IF EXISTS SP_vistaBoleta
GO
CREATE PROCEDURE SP_vistaBoleta
@idClient CHAR(5)
AS
	SELECT p.IdCliente,p.Fecha,d.NombreProducto,SUM(d.Cantidad) AS Cantidad,SUM(d.Subtotal) AS Subtotal FROM DetallePedido d
	INNER JOIN Pedidos p
	ON  p.IdCliente=@idClient
	WHERE d.Estado!='Enviado' AND p.Id=d.IdPedido
	GROUP BY p.Fecha,d.NombreProducto,p.IdCliente
GO
EXEC SP_vistaBoleta 'C-002'
--------------------------------------VISTA PRODUCCION---------------------------------------------
DROP PROC IF EXISTS SP_vistaProduccion
GO
CREATE PROCEDURE SP_vistaProduccion
AS
	SELECT p.Id,d.NombreProducto,SUM(d.Cantidad) AS Cantidad,p.Estado,CONVERT(varchar,p.Fecha,100)AS Fecha FROM DetallePedido d
	INNER JOIN Pedidos p
	ON  p.Id=d.IdPedido
	WHERE p.Estado='Pendiente'
	GROUP BY p.Fecha,d.NombreProducto,p.Id,p.Estado
GO

EXEC SP_vistaProduccion

SELECT*FROM Productos
SELECT*FROM Pedidos
SELECT*FROM DetallePedido	
SELECT*FROM Empleados
SELECT*FROM Cliente
DELETE FROM Pedidos
DELETE FROM Empleados