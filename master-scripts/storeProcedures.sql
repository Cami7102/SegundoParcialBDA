USE cintillosMascotas;

-- 1. Este stored procedure recibe un rango de precios y devuelve los productos que se encuentran dentro de ese rango.
DELIMITER $$
CREATE PROCEDURE ObtenerProductosPorPrecio(
  IN minPrecio DECIMAL(10, 2),
  IN maxPrecio DECIMAL(10, 2)
)
BEGIN
  SELECT *
  FROM Producto
  WHERE Precio BETWEEN minPrecio AND maxPrecio;
END $$
DELIMITER ;

-- 2. Este stored procedure recibe una fecha y devuelve las compras realizadas en esa fecha.
DELIMITER $$
CREATE PROCEDURE ObtenerComprasPorFecha(
  IN fechaCompra DATE
)
BEGIN
  SELECT *
  FROM Compra
  WHERE FechaCompra = fechaCompra;
END $$
DELIMITER ;

-- 3. Este stored procedure recibe el nombre de un propietario y devuelve todas las mascotas asociadas a ese propietario.
DELIMITER $$
CREATE PROCEDURE ObtenerMascotasPorPropietario(
  IN propietario VARCHAR(50)
)
BEGIN
  SELECT *
  FROM Mascotas
  WHERE Propietario = propietario;
END $$
DELIMITER ;

-- 4. Este stored procedure devuelve todas las solicitudes que están en estado "Pendiente".
DELIMITER $$
CREATE PROCEDURE ObtenerSolicitudesPendientes()
BEGIN
  SELECT *
  FROM Solicitud
  WHERE Estado = 'Pendiente';
END $$
DELIMITER ;

-- 5. Este stored procedure permite registrar una nueva compra en la tabla "Compra" y también inserta los detalles de la compra
-- en la tabla "DetallesCompra". Recibe como parámetros la fecha de la compra, el total de la compra, el ID del producto y la
-- cantidad comprada.
DELIMITER $$
CREATE PROCEDURE RegistrarCompra(
  IN fechaCompra DATE,
  IN totalCompra DECIMAL(10, 2),
  IN idProducto INT,
  IN cantidad INT
)
BEGIN
  DECLARE idCompra INT;

  -- Insertar en la tabla Compra
  INSERT INTO Compra (FechaCompra, TotalCompra)
  VALUES (fechaCompra, totalCompra);

  -- Obtener el ID de la última compra registrada
  SET idCompra = LAST_INSERT_ID();

  -- Insertar en la tabla DetallesCompra
  INSERT INTO DetallesCompra (IDCompra, IDProducto, Cantidad)
  VALUES (idCompra, idProducto, cantidad);
  
  SELECT idCompra AS 'ID de la Compra';
END $$
DELIMITER ;
