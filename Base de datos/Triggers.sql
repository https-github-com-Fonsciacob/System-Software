USE PedidosOnline
GO

DROP TRIGGER IF EXISTS UpdateCategoriaProducto
GO
CREATE TRIGGER UpdateCategoriaProducto
ON Productos
AFTER INSERT,UPDATE,DELETE
AS
    DECLARE @idCategoria CHAR(5),@count int

    IF EXISTS (SELECT*FROM inserted) and NOT EXISTS (SELECT*FROM deleted)
    BEGIN
        SELECT @idCategoria=IdCategoria FROM INSERTED
        SELECT @count=(SELECT COUNT(IdCategoria) FROM Productos WHERE IdCategoria=@idCategoria)
        UPDATE CategoriaProd SET Cantidad=@count 
        WHERE Id=@idCategoria
    END

    IF EXISTS (SELECT* FROM deleted) and NOT EXISTS (SELECT*FROM inserted)
    BEGIN
        SELECT @idCategoria=IdCategoria FROM DELETED
        SELECT @count=(SELECT COUNT(IdCategoria) FROM Productos WHERE IdCategoria=@idCategoria)
        UPDATE CategoriaProd SET Cantidad=@count 
        WHERE Id=@idCategoria
    END

GO

SELECT COUNT(IdCategoria) FROM Productos WHERE IdCategoria='P-001'

------------------INSERTAR DETALLE PEDIDO------------------------------
DROP TRIGGER IF EXISTS Tg_DetallePedido
GO
CREATE TRIGGER Tg_DetallePedido ON Pedidos AFTER INSERT
AS 
DECLARE @IdPedido char(5), @IdProducto char(5), @Cantidad int, 
        @Impuesto int,@Subtotal MONEY,@nomProd VARCHAR(70),@tPrice MONEY,@fecha SMALLDATETIME,
		@distrito VARCHAR(70),@direccion VARCHAR(70)
        
    SELECT @IdPedido=Id FROM inserted
    SELECT @IdProducto=IdProducto FROM inserted
    SELECT @Cantidad=CantidadProd FROM inserted
    SELECT @nomProd=Nombre FROM inserted
	SELECT @distrito=Distrito FROM inserted
	SELECT @direccion=Direccion FROM inserted
    SELECT @fecha=Fecha FROM inserted
    SELECT @tPrice=PrecioTotal FROM inserted

    SET @Impuesto = ((SELECT (PrecioTotal) FROM Pedidos where Id = @IdPedido)*(0.05))
    SET @Subtotal=(SELECT (PrecioTotal) FROM Pedidos where Id = @IdPedido)-@Impuesto

    -------------------DETALLE PEDIDO-------------------------------------
    INSERT INTO DetallePedido(IdPedido,IdProducto,NombreProducto,Cantidad,Subtotal,Total,Fecha) 
    VALUES(@IdPedido,@IdProducto,@nomProd,@Cantidad,@Subtotal,@tPrice,@fecha)
GO

------------------ACTUALIZAR ESTADO DEL ENVIO------------------------------

DROP TRIGGER IF EXISTS tg_updateEnvio
GO
CREATE TRIGGER g_updateEnvio ON Pedidos AFTER UPDATE
AS
    DECLARE @state VARCHAR(70),@id CHAR(5)

    SELECT @state=Estado FROM inserted
    SELECT @id=Id FROM inserted

    UPDATE DetallePedido SET Estado=@state 
	WHERE IdPedido=@id
GO
