USE PedidosOnline
GO
---- Procedimiento Almacenado de logeo-----
DROP PROCEDURE Sp_LogeoPedido
GO
CREATE PROC Sp_LogeoPedido(
@P_User VARCHAR(50),
@P_Pass VARCHAR(50),
@Variable VARCHAR(50) OUTPUT,
@IdArea CHAR(3) OUTPUT
)
as
	DECLARE @V_Admin VARCHAR(50), @V_Empleado VARCHAR(50),@idCat CHAR(1);
	SET @V_Admin = (SElECT (Id) FROM Administrador where Id= @P_user and Contraseña= @P_Pass)
	SET @V_Empleado = (SElECT (Id) FROM Empleados where Id= @P_user and Contraseña= @P_Pass)

	if(@V_Admin != '')
	begin
		SET @Variable = @V_Admin
	    SET @IdArea=(SELECT (IdArea) FROM Administrador WHERE Id=@P_User AND Contraseña=@P_Pass)
		RETURN
	end
	if(@V_Empleado !='')
	begin
		SET @Variable = @V_Empleado;
	    SET @IdArea=(SELECT (IdArea) FROM Empleados WHERE Id=@P_User AND Contraseña=@P_Pass)
		RETURN
	end
GO


-------------------------AREA DE TRABAJO-----------------------------------------------
DROP PROC Sp_Insertar_AreaTrabajo
GO
CREATE PROC Sp_Insertar_AreaTrabajo
@Id char(3),
@NombreArea VARCHAR(40)
as
insert into AreaDeTrabajo(Id,NameArea)
values(@Id,@NombreArea)
GO

------------------------ CateGOria Producto-------------------------------------------
DROP PROC Sp_InsertarCatProducto
GO
CREATE PROC Sp_InsertarCatProducto
@NombreCateGOría VARCHAR(40)
as
	DECLARE @result char(5),@id char(5);
	EXEC sp_genCode'CategoriaProd','P-',@result output;
	SET @id = @result
	insert into CateGOriaProd(Id,NombreCat)
	values(@id,@NombreCateGOría)

exec Sp_InsertarCatProducto Limpieza
GO

SELECT*FROM CategoriaProd
GO
------------------------Cliente------------------------------------------------------
DROP PROC Sp_InsertarCliente
GO
CREATE PROC Sp_InsertarCliente
@Nombre VARCHAR(50),
@Apellido VARCHAR(50),
@DNI char(8),
@correo VARCHAR(90),
@Contraseña VARCHAR(50)
as
	DECLARE @result char(5),@id char(5);
	EXEC sp_genCode'Cliente','C-',@result output;
	SET @id = @result
	INSERT INTO Cliente(Id,Nombres,Apellido,DNI,Correo,Contraseña)
	VALUES(@id,@Nombre,@Apellido,@DNI,@correo,@Contraseña)
GO
----------------------Detalle Pedido-------------------------------------------------
--Acá son trigger

GO
---------------------Empleados(INCLUYE AL EMPLEADO Y ADMINISTRADOR)-------------------------------------------------------
DROP PROC Sp_InsertarEmpleado
GO
CREATE PROC Sp_InsertarEmpleado(
@Area char(3),
@Nombres VARCHAR(50),
@Apellidos VARCHAR(100),
@DNI char(8),
@Mensaje VARCHAR(50) OUTPUT
)
as
	DECLARE @Id char(5);
	DECLARE @result char(5);
	DECLARE @Contraseña VARCHAR(50)
	IF(@Area='ADM')
		BEGIN
			EXEC sp_genCode'Administrador','A-',@result output;
			SET @Id = (SELECT @result);
			SET @Contraseña = @DNI
			INSERT INTO Empleados(Id,IdArea,Nombre, Apellido, DNI, Contraseña)
			VALUES(@Id,@Area,@Nombres,@Apellidos,@DNI,@Contraseña)
			SET @Mensaje='Administrador Registrado'
			RETURN
		END
	ELSE
		EXEC sp_genCode'Empleados','E-',@result output;
		SET @Id = (SELECT @result);
		SET @Contraseña = @DNI
		INSERT INTO Empleados(Id,IdArea,Nombres, Apellidos, DNI, Contraseña)
		VALUES(@Id,@Area,@Nombres,@Apellidos,@DNI,@Contraseña)
		SET @Mensaje='Empleado Registrado'
GO
---------------------------------Pedidos----------------------------------------------
DROP PROC Sp_InsertarPedidos
GO
CREATE PROC Sp_InsertarPedidos
@IdCliente char(5),
@Cantidad int,
@IdProducto char(5)
as
	DECLARE @result char(5), @Id char(5), @Total char(50), @precio char(50),@nomProd VARCHAR(70);
	EXEC sp_genCode'Pedidos','D-',@result output;
	SET @Id = (SELECT @result);
	SET @precio = (select(precio) from Productos where Id = @IdProducto)
	SET @nomProd=(SELECT(Nombre) FROM Productos WHERE Id=@IdProducto)
	SET @Total = @precio * @Cantidad
	insert into Pedidos(Id,IdCliente,IdProducto,Nombre,CantidadProd,PrecioTotal)
	values(@Id,@IdCliente,@IdProducto,@nomProd,@Cantidad,@Total)
GO
---------------------------------Producción-------------------------------------------
--- Denuevo triggers :v 
GO
---------------------------------CateGOrias Productos--------------------------------------------
DROP PROC Sp_InsertarCatProducto
GO
CREATE PROC Sp_InsertarCatProducto
@NombreCateGOría VARCHAR(40),
@Mensaje VARCHAR(50) OUTPUT
as
DECLARE @result char(5),@id char(5);
EXEC sp_genCode'CategoriaProd','P-',@result output;
SET @id = @result
	insert into CateGOriaProd(Id,NombreCat)
	values(@id,@NombreCateGOría)
	SET @Mensaje='Categoria Insertado'

---------------------------------MENU--------------------------------------------
DROP PROCEDURE IF EXISTS Sp_InsertarProducto
GO
CREATE PROC Sp_InsertarProducto
@IdCateGOria char(5),
@Nombre VARCHAR(40),
@Precio int,
@Mensaje VARCHAR(50) OUTPUT
as
	DECLARE @result char(5);
	EXEC sp_genCode'Productos','F-',@result output;
	DECLARE @iDProducto char(5)
	SET @iDProducto = (SELECT @result);
	INSERT INTO Productos(id,IdCateGOria,Nombre,Precio)
	values(@result,@IdCateGOria,@Nombre,@Precio)
	SET @Mensaje='Producto Insertado'
GO

--------------------------------Ventas-------------------------------------------------
DROP PROC Sp_InsertarVentas
GO
CREATE PROC Sp_InsertarVentas
@idPedido char(5)
as
	declare @precio char(50)
	SET @precio = (select(PrecioTotal) from Pedidos where Id=@idPedido)
	INSERT INTO Ventas(IdPedido,Precio)
	VALUES(@idPedido,@precio)
