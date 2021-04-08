USE PedidosOnline
GO

DROP PROCEDURE IF EXISTS Sp_EliminarEmpleados
GO
CREATE PROCEDURE Sp_EliminarEmpleados
@id char(5)
AS
	DELETE FROM Empleados WHERE Id=@id
GO

--------------------------------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS Sp_EliminarCliente
GO
CREATE PROCEDURE Sp_EliminarCliente
@id char(5)
AS
	DELETE FROM Cliente WHERE Id=@id
GO


--------------------------------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS Sp_EliminarEnvio
GO
CREATE PROCEDURE Sp_EliminarEnvio
@idpedido char(5)
AS
	DELETE FROM Envio WHERE IdPedido=@idpedido
GO



--------------------------------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS Sp_EliminarCategoriaProd
GO
CREATE PROCEDURE Sp_EliminarCategoriaProd
@id char (5)
AS
	DELETE FROM CategoriaProd WHERE Id=@id
GO


--------------------------------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS Sp_EliminarMenu
GO
CREATE PROCEDURE Sp_EliminarMenu
@id char (5)
AS
	DELETE FROM Productos WHERE Id=@id
GO





--------------------------------------------------------------------------------------------------------