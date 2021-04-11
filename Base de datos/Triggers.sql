USE PedidosOnline
GO

DROP TRIGGER IF EXISTS UpdateCategoriaProducto
GO
CREATE TRIGGER UpdateCategoriaProducto
ON Productos
AFTER INSERT,UPDATE,DELETE
AS
    DECLARE @idCategoria CHAR(5),@count int
    SELECT @idCategoria=IdCategoria FROM INSERTED
    SELECT @idCategoria=IdCategoria FROM DELETED
    
    SELECT @count=(SELECT COUNT(IdCategoria) FROM Productos WHERE IdCategoria=@idCategoria)

    UPDATE CategoriaProd SET Cantidad=@count 
    WHERE Id=@idCategoria

GO

SELECT COUNT(IdCategoria) FROM Productos WHERE IdCategoria='P-001'
--------------------------------------------------------------------------------------
-------------PRODCUCIÓN---------------------------
DROP TRIGGER IF EXISTS Tg_Produccion
GO
CREATE TRIGGER Tg_Produccion ON Pedidos AFTER INSERT
AS
DECLARE @IdPedido char(5), @IdProducto char(5), @nomProd varchar(70), @Cantidad int;
    SELECT @IdPedido = Id FROM inserted
    SELECT @IdProducto = IdProducto from inserted
    SELECT @nomProd=Nombre FROM inserted
    SELECT @Cantidad = CantidadProd from inserted
    INSERT INTO Produccion(IdPedido,IdProducto,Nombre,Cantidad) VALUES(@IdPedido,@IdProducto,@nomProd,@Cantidad)
GO
-------------------------------------------------------------------------
------------------CLIENTE------------------------------
DROP TRIGGER IF EXISTS Tg_DetallePedido
GO
CREATE TRIGGER Tg_DetallePedido ON Pedidos AFTER INSERT
AS
DECLARE @IdPedido char(5), @IdProducto char(5), @Cantidad int, 
        @Impuesto int,@Subtotal int,@nomProd VARCHAR(70)
        
    SELECT @IdPedido = Id FROM inserted
    SELECT @IdProducto = IdProducto FROM inserted
    SELECT @Cantidad = CantidadProd FROM inserted
    SELECT @nomProd=   Nombre FROM inserted
    SET @Impuesto = ((SELECT (PrecioTotal) FROM Pedidos where Id = @IdPedido)*(0.05))
    SET @Subtotal=(SELECT (PrecioTotal) FROM Pedidos where Id = @IdPedido)-@Impuesto
    INSERT INTO DetallePedido(IdPedido,IdProducto,Nombre,Cantidad,Subtotal) VALUES(@IdPedido,@IdProducto,@nomProd,@Cantidad,@Subtotal)
GO---------------------------------------------------------------------------

CREATE TRIGGER Tg_Envio ON Pedidos AFTER INSERT
as
DECLARE @IdPedido char(5),@Nombres varchar(40), @Apellidos varchar(40),@DNI char(8)
SELECT @IdPedido = (Id) FROM inserted    