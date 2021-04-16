USE PedidosOnline
GO

DROP PROCEDURE IF EXISTS Sp_EliminarEmpleados
GO
CREATE PROCEDURE Sp_EliminarEmpleados
@id char(5),
@resultado VARCHAR(50) OUTPUT
AS
	DELETE FROM Empleados WHERE Id=@id
	SET @resultado='Empleado Eliminado'
GO

--------------------------------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS Sp_EliminarCliente
GO
CREATE PROCEDURE Sp_EliminarCliente
@id char(5),
@resultado VARCHAR(50) OUTPUT
AS
	DELETE FROM Cliente WHERE Id=@id
	SET @resultado='Cliente Eliminado'
GO

--------------------------------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS Sp_EliminarEnvio
GO
CREATE PROCEDURE Sp_EliminarEnvio
@idpedido char(5),
@resultado VARCHAR(50) OUTPUT
AS
	DELETE FROM Envio WHERE IdPedido=@idpedido
	SET @resultado='Envio Eliminado'
GO

--------------------------------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS Sp_EliminarCategoriaProd
GO
CREATE PROCEDURE Sp_EliminarCategoriaProd
@id char (5),
@resultado VARCHAR(50) OUTPUT
AS
	DELETE FROM CategoriaProd WHERE Id=@id
	SET @resultado='Categoría elminado'
GO


--------------------------------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS Sp_deleteMenu
GO
CREATE PROCEDURE Sp_deleteMenu
@id char (5),
@resultado VARCHAR(50) OUTPUT
AS
	DELETE FROM Productos WHERE Id=@id
	SET @resultado='Menú elminado'
GO

DECLARE @resultado VARCHAR(50)
EXEC Sp_deleteMenu 'F-002' ,@resultado OUTPUT
SELECT @resultado

--------------------------------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS Sp_deletePedido
GO
CREATE PROCEDURE Sp_deletePedido
@id char (5),
@resultado VARCHAR(50) OUTPUT
AS
	DELETE FROM Pedidos WHERE Id=@id
	SET @resultado='Pedido Eliminado'
GO

DECLARE @resultado VARCHAR(50)
EXEC Sp_deletePedido 'D-001' ,@resultado OUTPUT
SELECT @resultado