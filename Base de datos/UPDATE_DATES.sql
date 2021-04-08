USE PedidosOnline;
----------------------ADMINISTRADOR
DROP PROCEDURE IF EXISTS sp_updateAdmin
GO
CREATE PROCEDURE sp_updateAdmin
    @id CHAR(5),
    @Nombre VARCHAR(50),
    @Apellidos VARCHAR(100),
    @pass VARCHAR(50)
AS
    UPDATE Administrador SET Nombre=@Nombre,Apellido=@Apellidos,Contraseña=@pass
    WHERE Id=@id
GO
--------------------EMPLEADO
DROP PROCEDURE IF EXISTS sp_updateEmpleados
GO
CREATE PROCEDURE sp_updateEmpleados
    @id CHAR(5),
    @area CHAR(3),
    @Nombre VARCHAR(50),
    @Apellidos VARCHAR(100),
    @resultado VARCHAR(70) OUTPUT
AS
    UPDATE Empleados SET Nombres=@Nombre,Apellidos=@Apellidos, IdArea=@area
    WHERE Id=@id
    SET @resultado='Registro Actualizado'
GO
----------------CLIENTE
DROP PROCEDURE IF EXISTS sp_updateCliente
GO
CREATE PROCEDURE sp_updateCliente
    @id CHAR(5),
    @Nombre VARCHAR(50),
    @Apellidos VARCHAR(100),
    @pass VARCHAR(50)
AS
    UPDATE Cliente SET Nombres=@Nombre,Apellido=@Apellidos,Contraseña=@pass
    WHERE Id=@id
GO
----------------CATEGORIA PRODUCTO
DROP PROCEDURE IF EXISTS sp_updateCategoriaProd
GO
CREATE PROCEDURE sp_updateCategoriaProd
    @id CHAR(5),
    @Nombre VARCHAR(50)
AS
    UPDATE CategoriaProd SET NombreCat=@Nombre
    WHERE Id=@id
GO
----------------AREA TRABAJO
USE PedidosOnline
GO
DROP PROCEDURE IF EXISTS sp_updateAreaTrabajo
GO
CREATE PROCEDURE sp_updateAreaTrabajo
    @id CHAR(5),
    @Nombre VARCHAR(50)
AS
    UPDATE AreaDeTrabajo SET NameArea=@Nombre
    WHERE Id=@id
GO
--------------------Menu
DROP PROCEDURE IF EXISTS sp_updateMenu
GO
CREATE PROCEDURE sp_updateMenu
    @id CHAR(5),
    @nombre VARCHAR(50),
    @price INT,
    @result VARCHAR(50) OUTPUT
AS
    UPDATE Productos SET Nombre=@nombre,Precio=@price
    WHERE Id=@id
    SET @result='Menu Actualizado'
GO
-----------------PEDIDO
DROP PROCEDURE IF EXISTS sp_updatePedido
GO
CREATE PROCEDURE sp_updatePedido
    @id CHAR(5),
    @state VARCHAR(50)
AS
    UPDATE Pedidos SET Estado=@state WHERE Id=@id
GO