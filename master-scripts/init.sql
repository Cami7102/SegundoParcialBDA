USE cintillosMascotas;

CREATE TABLE Producto (
  IDProducto INT NOT NULL AUTO_INCREMENT,
  NombreProducto VARCHAR(50),
  Descripcion VARCHAR(200),
  Precio DECIMAL(10, 2),
  PRIMARY KEY (IDProducto)
);

CREATE TABLE Solicitud (
  IDSolicitud INT NOT NULL AUTO_INCREMENT,
  FechaSolicitud DATE,
  Estado VARCHAR(50),
  PRIMARY KEY (IDSolicitud)
);

CREATE TABLE Compra (
  IDCompra INT NOT NULL AUTO_INCREMENT,
  FechaCompra DATE,
  TotalCompra DECIMAL(10, 2),
  PRIMARY KEY (IDCompra)
);

CREATE TABLE Proveedores (
  IDProveedor INT NOT NULL AUTO_INCREMENT,
  NombreProveedor VARCHAR(50),
  Direccion VARCHAR(100),
  Telefono VARCHAR(20),
  CorreoElectronico VARCHAR(50),
  PRIMARY KEY (IDProveedor)
);

CREATE TABLE Empleados (
  IDEmpleado INT NOT NULL AUTO_INCREMENT,
  NombreEmpleado VARCHAR(50),
  Cargo VARCHAR(50),
  Telefono VARCHAR(20),
  CorreoElectronico VARCHAR(50),
  PRIMARY KEY (IDEmpleado)
);

CREATE TABLE Mascotas (
  IDMascota INT NOT NULL AUTO_INCREMENT,
  NombreMascota VARCHAR(50),
  Raza VARCHAR(50),
  Edad INT,
  Propietario VARCHAR(50),
  TelefonoPropietario VARCHAR(20),
  PRIMARY KEY (IDMascota)
);

CREATE TABLE Propietario (
  IDPropietario INT NOT NULL AUTO_INCREMENT,
  NombrePropietario VARCHAR(50),
  TelefonoPropietario VARCHAR(20),
  PRIMARY KEY (IDPropietario)
);

CREATE TABLE Vacunas (
  IDVacuna INT NOT NULL AUTO_INCREMENT,
  NombreVacuna VARCHAR(50),
  Descripcion VARCHAR(200),
  PeriodoRevacunacion INT,
  PRIMARY KEY (IDVacuna)
);

CREATE TABLE Vacunacion (
  IDVacunacion INT NOT NULL AUTO_INCREMENT,
  IDVacuna INT,
  IDMascota INT,
  FechaVacunacion DATE,
  FOREIGN KEY (IDMascota) REFERENCES Mascotas(IDMascota),
  FOREIGN KEY (IDVacuna) REFERENCES Vacunas(IDVacuna),
  PRIMARY KEY (IDVacunacion)
);

CREATE TABLE DetallesCompra (
  IDDetalleC INT NOT NULL AUTO_INCREMENT,
  IDCompra INT,
  IDProducto INT,
  Cantidad INT,
  PrecioUnitario DECIMAL(10, 2),
  FOREIGN KEY (IDCompra) REFERENCES Compra(IDCompra),
  FOREIGN KEY (IDProducto) REFERENCES Producto(IDProducto),
  PRIMARY KEY (IDDetalleC)
);

CREATE TABLE DetallesSolicitud (
  IDDetalleS INT NOT NULL AUTO_INCREMENT,
  IDSolicitud INT,
  Producto VARCHAR(50),
  Cantidad INT,
  FOREIGN KEY (IDSolicitud) REFERENCES Solicitud(IDSolicitud),
  PRIMARY KEY (IDDetalleS)
);

-- Índice consulta 1: 
CREATE INDEX idx_NombreProducto ON Producto(NombreProducto);

-- Índice consulta 2: 
CREATE INDEX idx_NombreEmpleado ON Empleados(NombreEmpleado);

-- Índices consulta 3: 
CREATE INDEX idx_IDVacuna ON Vacunacion(IDVacuna);
CREATE INDEX idx_NombreVacuna ON Vacunas(NombreVacuna);

-- Índices consulta 4: 
CREATE INDEX idx_FechaCompra ON Compra(FechaCompra);
CREATE INDEX idx_IDCompra ON DetallesCompra(IDCompra);
CREATE INDEX idx_IDProducto ON DetallesCompra(IDProducto);

-- Índice consulta 5: 
CREATE INDEX idx_Raza ON Mascotas(Raza);

-- DATOS
INSERT INTO Solicitud (FechaSolicitud, Estado) VALUES
('2023-05-01', 'Pendiente'),
('2023-05-02', 'Aprobada'),
('2023-05-03', 'Rechazada'),
('2023-05-04', 'Pendiente'),
('2023-05-05', 'Aprobada');

INSERT INTO Producto (NombreProducto, Descripcion, Precio) VALUES
('Cintillo1', 'Cintillo de color rojo', 10.00),
('Cintillo2', 'Cintillo de color azul', 10.00),
('Cintillo3', 'Cintillo de color blanco', 20.00),
('Cintillo4', 'Cintillo de color negro', 20.00),
('Cintillo5', 'Cintillo1 de color naranja', 50.00);

INSERT INTO Compra (FechaCompra, TotalCompra) VALUES
('2023-05-10', 150.00),
('2023-05-12', 400.00),
('2023-05-12', 250.00),
('2023-05-20', 180.00),
('2023-05-20', 300.00);

INSERT INTO Proveedores (NombreProveedor, Direccion, Telefono, CorreoElectronico) VALUES
('Proveedor A', 'Calle 123, Ciudad', '123456789', 'proveedorA@example.com'),
('Proveedor B', 'Calle 456, Ciudad', '987654321', 'proveedorB@example.com'),
('Proveedor C', 'Calle 789, Ciudad', '654321987', 'proveedorC@example.com'),
('Proveedor D', 'Calle 012, Ciudad', '321654987', 'proveedorD@example.com'),
('Proveedor E', 'Calle 345, Ciudad', '456123789', 'proveedorE@example.com');

INSERT INTO Empleados (NombreEmpleado, Cargo, Telefono, CorreoElectronico) VALUES
('Empleado A', 'Gerente', '123456789', 'empleadoA@example.com'),
('Empleado B', 'Asistente', '987654321', 'empleadoB@example.com'),
('Empleado C', 'Vendedor', '654321987', 'empleadoC@example.com'),
('Empleado D', 'Contador', '321654987', 'empleadoD@example.com'),
('Empleado E', 'Recepcionista', '456123789', 'empleadoE@example.com');

INSERT INTO Propietario (NombrePropietario, TelefonoPropietario) VALUES
('Juan Perez', '1234567890'),
('Maria Gomez', '9876543210'),
('Pedro Rodriguez', '0123456789'),
('Laura Lopez', '9876543210'),
('Carlos Torres', '1234567890');

INSERT INTO Mascotas (NombreMascota, Raza, Edad, Propietario, TelefonoPropietario) VALUES
('Max', 'Labrador', 5, 'Juan Perez', '1234567890'),
('Luna', 'Bulldog Frances', 2, 'Maria Gomez', '9876543210'),
('Rocky', 'Golden Retriever', 10, 'Pedro Rodriguez', '0123456789'),
('Lola', 'Poodle', 5, 'Laura Lopez', '9876543210'),
('Simba', 'Maine Coon', 3, 'Carlos Torres', '1234567890');

INSERT INTO Vacunas (NombreVacuna, Descripcion, PeriodoRevacunacion) VALUES
('Vacuna Antirrabica', 'Protege contra la rabia', 1),
('Vacuna Parvovirus', 'Protege contra el parvovirus', 1),
('Vacuna Moquillo', 'Protege contra el moquillo', 2),
('Vacuna Leucemia Felina', 'Protege contra la leucemia felina', 1),
('Vacuna Tos de las perreras', 'Protege contra la tos de las perreras', 1);

INSERT INTO DetallesSolicitud (IDSolicitud, Producto, Cantidad) VALUES
(1, 'Cintillo1', 10),
(2, 'Cintillo2', 5),
(3, 'Cintillo3', 20),
(4, 'Cintillo4', 15),
(5, 'Cintillo5', 8);

INSERT INTO DetallesCompra (IDCompra, IDProducto, Cantidad, PrecioUnitario) VALUES
(1, 1, 5, 10.00),
(2, 2, 3, 12.00),
(3, 3, 10, 20.00),
(4, 4, 8, 22.00),
(5, 5, 2, 45.00);

INSERT INTO Vacunacion (IDVacuna, IDMascota, FechaVacunacion) VALUES
(1, 1, '2023-01-15'),
(2, 2, '2023-03-20'),
(3, 3, '2023-02-10'),
(4, 4, '2023-04-05'),
(5, 5, '2023-03-18');

-- TABLAS DE AUDITORIA 
-- 1 
CREATE TABLE AuditoriaSolicitud (
  IDAuditoria INT PRIMARY KEY,
  IDSolicitud INT,
  Accion VARCHAR(50),
  FechaAccion DATETIME,
  Usuario VARCHAR(50),
  FOREIGN KEY (IDSolicitud) REFERENCES Solicitud(IDSolicitud)
);

-- 2 
CREATE TABLE AuditoriaDetallesSolicitud (
  IDAuditoria INT PRIMARY KEY,
  IDDetalleS INT,
  Accion VARCHAR(50),
  FechaAccion DATETIME,
  Usuario VARCHAR(50),
  FOREIGN KEY (IDDetalleS) REFERENCES DetallesSolicitud(IDDetalleS)
);

-- 3
CREATE TABLE AuditoriaProductos (
  IDAuditoria INT PRIMARY KEY,
  IDProducto INT,
  Accion VARCHAR(50),
  FechaAccion DATETIME,
  Usuario VARCHAR(50),
  FOREIGN KEY (IDProducto) REFERENCES Producto(IDProducto)
);

-- 4 
CREATE TABLE AuditoriaCompra (
  IDAuditoria INT PRIMARY KEY,
  IDCompra INT,
  Accion VARCHAR(50),
  FechaAccion DATETIME,
  Usuario VARCHAR(50),
  FOREIGN KEY (IDCompra) REFERENCES Compra(IDCompra)
);

-- 5 
CREATE TABLE AuditoriaVacunas (
  IDAuditoria INT PRIMARY KEY,
  IDVacuna INT,
  Accion VARCHAR(50),
  FechaAccion DATETIME,
  Usuario VARCHAR(50),
  FOREIGN KEY (IDVacuna) REFERENCES Vacunas(IDVacuna)
);
