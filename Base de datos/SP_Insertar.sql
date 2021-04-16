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
	DECLARE @V_Empleado VARCHAR(50),@idCat CHAR(1);
	SET @V_Empleado = (SElECT (Id) FROM Empleados where Id= @P_user and Contraseña= @P_Pass)

	IF(@V_Empleado !='')
	BEGIN
		SET @Variable = @V_Empleado;
	    SET @IdArea=(SELECT (IdArea) FROM Empleados WHERE Id=@P_User AND Contraseña=@P_Pass)
		RETURN
	END
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

------------------------ Categoria Producto-------------------------------------------
DROP PROC Sp_InsertarCatProducto
GO
CREATE PROC Sp_InsertarCatProducto
@NombreCateGOría VARCHAR(40),
@mensaje VARCHAR(50) OUTPUT
as
	DECLARE @result char(5),@id char(5);
	EXEC sp_genCode'CategoriaProd','P-',@result output;
	SET @id = @result
	insert into CateGOriaProd(Id,NombreCat)
	values(@id,@NombreCateGOría)
	SET @mensaje='Categoria Ingresado'

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
@Distrito VARCHAR(70),
@correo VARCHAR(90),
@Contraseña VARCHAR(50)
as
	DECLARE @result char(5),@id char(5);
	EXEC sp_genCode'Cliente','C-',@result output;
	SET @id = @result
	INSERT INTO Cliente(Id,Nombres,Apellido,DNI,Distrito,Correo,Contraseña)
	VALUES(@id,@Nombre,@Apellido,@DNI,@Distrito,@correo,@Contraseña)
GO
---------------------Empleados(INCLUYE AL EMPLEADO Y ADMINISTRADOR)-------------------------------------------------------
DROP PROC Sp_InsertarEmpleado
GO
CREATE PROC Sp_InsertarEmpleado(
@Area char(3),
@Nombres VARCHAR(50),
@Apellidos VARCHAR(100),
@DNI char(8),
@img image,
@Mensaje VARCHAR(50) OUTPUT
)
as
	DECLARE @Id char(5);
	DECLARE @result char(5);
	DECLARE @Contraseña VARCHAR(50)
	IF(@Area='ADM')
		BEGIN
			EXEC sp_genCode'Empleados','A-',@result output;
			SET @Id = (SELECT @result);
			SET @Contraseña = @DNI
			INSERT INTO Empleados(Id,IdArea,Nombres, Apellidos, DNI,Img, Contraseña)
			VALUES(@Id,@Area,@Nombres,@Apellidos,@DNI,@img,@Contraseña)
			SET @Mensaje='Administrador Registrado'
			RETURN
		END
	ELSE
		EXEC sp_genCode'Empleados','E-',@result output;
		SET @Id = (SELECT @result);
		SET @Contraseña = @DNI
		INSERT INTO Empleados(Id,IdArea,Nombres, Apellidos, DNI,Img, Contraseña)
		VALUES(@Id,@Area,@Nombres,@Apellidos,@DNI,@img,@Contraseña)
		SET @Mensaje='Empleado Registrado'
GO
---------------------------------Pedidos----------------------------------------------
DROP PROC Sp_InsertarPedidos
GO
CREATE PROC Sp_InsertarPedidos
@IdCliente char(5),
@Cantidad int,
@IdProducto char(5),
@Distrito VARCHAR(70),
@Direccion VARCHAR(70)
as
	DECLARE @result char(5), @id char(5), @total MONEY, @precio MONEY,@nomProd VARCHAR(70),@time SMALLDATETIME;
	EXEC sp_genCode'Pedidos','D-',@result output;

	SET @time=GETDATE();
	SET @Id = (SELECT @result);
	SET @precio = (SELECT(precio) FROM Productos WHERE Id = @IdProducto)
	SET @nomProd=(SELECT(Nombre) FROM Productos WHERE Id=@IdProducto)
	SET @total = @precio * @Cantidad

	INSERT INTO Pedidos(Id,IdCliente,IdProducto,Nombre,CantidadProd,PrecioTotal,Distrito,Direccion,Fecha)
	VALUES(@id,@IdCliente,@IdProducto,@nomProd,@Cantidad,@total,@Distrito,@Direccion,@time)
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
GO
---------------------------------MENU--------------------------------------------
DROP PROCEDURE IF EXISTS Sp_InsertarProducto
GO
CREATE PROC Sp_InsertarProducto
@IdCateGOria char(5),
@Nombre VARCHAR(40),
@Precio MONEY,
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

