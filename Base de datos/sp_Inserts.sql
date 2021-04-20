----------------------------------INSERTAR AREA DE TRABAJO---------------------------------------
EXEC Sp_Insertar_AreaTrabajo 'COC','Area de Cocina'
EXEC Sp_Insertar_AreaTrabajo 'ENV','Area de Envios'
EXEC Sp_Insertar_AreaTrabajo 'ADM','Area de Administración'
EXEC Sp_Insertar_AreaTrabajo 'MOS','Area de Mostrador'

----------------------------------INSERTAR EMPLEADOS--------------------------------------------
-----------EMPLEADOS Area de COCINA----------

--EXEC Sp_InsertarEmpleado 'COC','Arnaud ','Donckele','83157694','',@Mensaje OUTPUT
--EXEC Sp_InsertarEmpleado 'COC','Cristophe ','Bacquié','79158634','',@Mensaje OUTPUT
--EXEC Sp_InsertarEmpleado 'COC','Mauro ','Colagreco','34968730','',@Mensaje OUTPUT

-----------EMPLEADOS Area de ENVIOS----------

--EXEC Sp_InsertarEmpleado 'ENV','Gabriel ','Paez Tur','87304598','',@Mensaje OUTPUT
--EXEC Sp_InsertarEmpleado 'ENV','Luis','Tormo Blades','97364580','',@Mensaje OUTPUT
--EXEC Sp_InsertarEmpleado 'ENV','Javier ','Sempere Tur','19753694','',@Mensaje OUTPUT
DECLARE @Mensaje VARCHAR(50)
EXEC Sp_InsertarEmpleado 'ENV','Andres','Villanueva','23753694','',@Mensaje OUTPUT
SELECT @Mensaje

-----------EMPLEADOS Area de ADMINISTRADORES----------

--EXEC Sp_InsertarEmpleado 'ADM','Anne','Mulcahy','69425789','',@Mensaje OUTPUT
--EXEC Sp_InsertarEmpleado 'ADM','Warren','Buffett','67842304','',@Mensaje OUTPUT
--EXEC Sp_InsertarEmpleado 'ADM','Gary','Hamel','43078912','',@Mensaje1 OUTPUT
--EXEC Sp_InsertarEmpleado 'ADM','Fred','Smith','83078943','',@Mensaje1 OUTPUT
DECLARE @Mensaje1 VARCHAR(50)
EXEC Sp_InsertarEmpleado 'ADM','Warren','Buffett','67842304','',@Mensaje OUTPUT
SELECT @Mensaje1
go
----------------------------------INSERTAR CATEGORIA MENU---------------------------------------

DECLARE @Mensaje VARCHAR(50)
EXEC Sp_InsertarCatProducto 'Mega Regulares',@Mensaje OUTPUT
SELECT @Mensaje
----------------------------------INSERTAR MENU-------------------------------------------------

--EXEC Sp_InsertarProducto 'P-001','MEGA RECARGADO',85,@Mensaje2 OUTPUT
DECLARE @Mensaje2 VARCHAR(50)
EXEC Sp_InsertarProducto 'P-001','MEGA PODEROSO',75,@Mensaje2 OUTPUT
SELECT @Mensaje2
------------------------------INSERTAR CLIENTE-------------------------------------------------
EXEC Sp_InsertarCliente 'Fonsciareli','Cobeñas','84737670','Comas','Ponscia_cob1905@hotmail.com','Epson2021'

---------------------------------GENERAR PEDIDO--------------------------------------------

DECLARE @SMS VARCHAR(50)
EXEC SP_genPedido 'C-002',@SMS OUTPUT
SELECT @SMS

---------------------------------INSERTAR PRODUCTOS AL DETALLE PEDIDO--------------------------------------------
EXEC Sp_insertDetailPedido 'D-001','F-002',5

--------------------------EMPLEADOS POR ÁREA(REPORTE)--------------------------------------------------
SELECT a.NameArea,COUNT(e.Id)FROM Empleados e 
INNER JOIN AreaDeTrabajo a
ON e.IdArea=a.Id
GROUP BY a.NameArea

---------------------------CILENTES POR DISTRITO(REPORTE)--------------------------------------------------
SELECT COUNT(Id) as Cliente,Distrito FROM Cliente
GROUP BY Distrito



