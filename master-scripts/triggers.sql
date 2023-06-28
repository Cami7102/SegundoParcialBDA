USE cintillosMascotas;

-- 1. Trigger para actualizar el total de compra al insertar un nuevo detalle de compra:
DELIMITER $$
CREATE TRIGGER trg_ActualizarTotalCompra
AFTER INSERT ON DetallesCompra
FOR EACH ROW
BEGIN
  UPDATE Compra
  SET TotalCompra = TotalCompra + (NEW.Cantidad * NEW.PrecioUnitario)
  WHERE IDCompra = NEW.IDCompra;
END $$
DELIMITER ;

-- 2. Trigger para verificar la edad mínima de una mascota al insertarla en la tabla de mascotas:
DELIMITER $$
CREATE TRIGGER trg_VerificarEdadMinimaMascota
BEFORE INSERT ON Mascotas
FOR EACH ROW
BEGIN
  IF NEW.Edad < 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La edad de la mascota debe ser un valor válido.';
  END IF;
END $$
DELIMITER ;

-- 3. Trigger para verificar la existencia de un propietario al insertar una mascota:
DELIMITER $$
CREATE TRIGGER trg_VerificarExistenciaPropietario
BEFORE INSERT ON Mascotas
FOR EACH ROW
BEGIN
  DECLARE propietario_count INT;
  SELECT COUNT(*) INTO propietario_count FROM Propietario;
  IF propietario_count = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El propietario de la mascota no existe en la tabla de propietarios.';
  END IF;
END $$
DELIMITER ;

-- 4. Trigger para incrementar el contador de revacunaciones al insertar una nueva vacunación:
DELIMITER $$
CREATE TRIGGER trg_IncrementarContadorRevacunaciones
AFTER INSERT ON Vacunacion
FOR EACH ROW
BEGIN
  UPDATE Vacunas
  SET ContadorRevacunaciones = ContadorRevacunaciones + 1
  WHERE IDVacuna = NEW.IDVacuna;
END $$
DELIMITER ;

-- 5. Trigger para verificar el estado de una solicitud antes de eliminarla:
DELIMITER $$
CREATE TRIGGER trg_VerificarEstadoSolicitud
BEFORE DELETE ON Solicitud
FOR EACH ROW
BEGIN
  IF OLD.Estado = 'Aprobada' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar una solicitud aprobada.';
  END IF;
END $$
DELIMITER ;
