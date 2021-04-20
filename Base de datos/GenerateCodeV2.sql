USE PedidosOnline
go

DROP PROCEDURE IF EXISTS sp_genCode
go

CREATE PROCEDURE sp_genCode
@tabla NVARCHAR(120),
@letter varchar(3),
@result char(5) output
AS	
	BEGIN
		----------------------------
		DECLARE @count NVARCHAR(MAX);
		DECLARE @max NVARCHAR(MAX);
		DECLARE @verify NVARCHAR(500);
		-----------------------------
		DECLARE @capCount int;
		DECLARE @capMax char(5);
		DECLARE @capId NVARCHAR(MAX);
		DECLARE @query nvarchar(600);
		DECLARE @maxInt int;
		-----------------------------------------
		DECLARE @parametrosID NVARCHAR(MAX);
		DECLARE	@parametrosCOUNT NVARCHAR(MAX);
		DECLARE	@parametrosMAX NVARCHAR(MAX);
		------------------------------------------
		DECLARE @cod varchar(5)
		
		--OBTENER LA CANTIDAD--
		SET @parametrosCOUNT=N'@capCount INT OUTPUT'; 
		SET @count='SELECT @capCount=(SELECT COUNT(ID) FROM'+QUOTENAME(@tabla)+')';
		EXEC @query=sp_executesql @count,@parametrosCOUNT,@capCount=@capCount OUTPUT;
		--OBTENER VALOR MAXIMO--
		SET @parametrosMAX=N'@capMax NVARCHAR(MAX) OUTPUT'; 
		SET @max='SELECT @capMax=(SELECT MAX(ID) FROM'+QUOTENAME(@tabla)+')';
		EXEC @query=sp_executesql @max,@parametrosMAX,@capMax=@capMax OUTPUT;

		--GENERAR CODIGO--
		SET @cod=CONCAT(@letter,REPLICATE(0,3-LEN(@capCount+1)),@capCount+1);

		--OBTENER ID--
		SET @parametrosID=N'@capId NVARCHAR(MAX) OUTPUT';
		SET @verify='SELECT @capId=(SELECT (Id) FROM '+QUOTENAME(@tabla)+'WHERE Id'+'='+QUOTENAME(@cod,'''')+')';
		EXEC @query=sp_executesql @verify,@parametrosID,@capId=@capId OUTPUT;

		--SI EL CODIGO GENERADO ES IGUAL A UN CODIGO EXISTENTE
			IF(@capId=@cod)
				BEGIN
					SET @maxInt=(SELECT SUBSTRING(@capMax,5,1) as ExtractString)+1;
					SET @cod=CONCAT(@letter,REPLICATE(0,3 - LEN(@maxInt)),@maxInt);
					SET @result=@cod;
				RETURN
				END

		SET @result=@cod;
		RETURN
	END
GO

DECLARE @mensaje VARCHAR(50)
EXEC sp_genCode 'Cliente','C-',@mensaje OUTPUT
SELECT @mensaje
       