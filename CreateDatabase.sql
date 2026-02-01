-- =============================================
-- Script de Base de Datos
-- Sistema de Reservas de Hotel
-- =============================================

-- Crear la base de datos
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'HotelDB')
BEGIN
    ALTER DATABASE HotelDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE HotelDB;
END
GO

CREATE DATABASE HotelDB;
GO

USE HotelDB;
GO

-- =============================================
-- Tabla: Usuarios
-- =============================================
CREATE TABLE Usuarios (
    UsuarioId INT PRIMARY KEY IDENTITY(1,1),
    NombreUsuario VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    NombreCompleto VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Rol VARCHAR(20) NOT NULL DEFAULT 'Recepcionista', -- Administrador, Recepcionista
    Activo BIT NOT NULL DEFAULT 1,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    UltimoAcceso DATETIME NULL
);
GO

-- =============================================
-- Tabla: Clientes
-- =============================================
CREATE TABLE Clientes (
    ClienteId INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    TipoDocumento VARCHAR(20) NOT NULL, -- DNI, Pasaporte, Cedula
    NumeroDocumento VARCHAR(50) NOT NULL UNIQUE,
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    Direccion VARCHAR(255),
    FechaNacimiento DATE,
    Nacionalidad VARCHAR(50),
    FechaRegistro DATETIME NOT NULL DEFAULT GETDATE(),
    Activo BIT NOT NULL DEFAULT 1
);
GO

-- =============================================
-- Tabla: Habitaciones
-- =============================================
CREATE TABLE Habitaciones (
    HabitacionId INT PRIMARY KEY IDENTITY(1,1),
    Numero VARCHAR(10) NOT NULL UNIQUE,
    Tipo VARCHAR(30) NOT NULL, -- Simple, Doble, Suite, Premium
    Capacidad INT NOT NULL,
    PrecioPorNoche DECIMAL(10,2) NOT NULL,
    Estado VARCHAR(20) NOT NULL DEFAULT 'Disponible', -- Disponible, Ocupada, Mantenimiento, Reservada
    Descripcion VARCHAR(500),
    Activa BIT NOT NULL DEFAULT 1
);
GO

-- =============================================
-- Tabla: Reservas
-- =============================================
CREATE TABLE Reservas (
    ReservaId INT PRIMARY KEY IDENTITY(1,1),
    HabitacionId INT NOT NULL,
    ClienteId INT NOT NULL,
    FechaEntrada DATE NOT NULL,
    FechaSalida DATE NOT NULL,
    NumeroHuespedes INT NOT NULL DEFAULT 1,
    PrecioTotal DECIMAL(10,2) NOT NULL,
    Estado VARCHAR(20) NOT NULL DEFAULT 'Pendiente', -- Pendiente, Confirmada, Cancelada, Completada
    Observaciones VARCHAR(500),
    FechaReserva DATETIME NOT NULL DEFAULT GETDATE(),
    UsuarioRegistro INT NOT NULL,
    
    CONSTRAINT FK_Reservas_Habitaciones FOREIGN KEY (HabitacionId) 
        REFERENCES Habitaciones(HabitacionId),
    CONSTRAINT FK_Reservas_Clientes FOREIGN KEY (ClienteId) 
        REFERENCES Clientes(ClienteId),
    CONSTRAINT FK_Reservas_Usuarios FOREIGN KEY (UsuarioRegistro) 
        REFERENCES Usuarios(UsuarioId),
    CONSTRAINT CK_Reservas_Fechas CHECK (FechaSalida > FechaEntrada),
    CONSTRAINT CK_Reservas_Huespedes CHECK (NumeroHuespedes > 0)
);
GO

-- =============================================
-- Tabla: Pagos
-- =============================================
CREATE TABLE Pagos (
    PagoId INT PRIMARY KEY IDENTITY(1,1),
    ReservaId INT NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    FechaPago DATETIME NOT NULL DEFAULT GETDATE(),
    MetodoPago VARCHAR(30) NOT NULL, -- Efectivo, Tarjeta, Transferencia
    Estado VARCHAR(20) NOT NULL DEFAULT 'Completado', -- Completado, Pendiente, Rechazado
    Referencia VARCHAR(100),
    UsuarioRegistro INT NOT NULL,
    
    CONSTRAINT FK_Pagos_Reservas FOREIGN KEY (ReservaId) 
        REFERENCES Reservas(ReservaId),
    CONSTRAINT FK_Pagos_Usuarios FOREIGN KEY (UsuarioRegistro) 
        REFERENCES Usuarios(UsuarioId),
    CONSTRAINT CK_Pagos_Monto CHECK (Monto > 0)
);
GO

-- =============================================
-- Índices para mejorar el rendimiento
-- =============================================
CREATE INDEX IX_Reservas_FechaEntrada ON Reservas(FechaEntrada);
CREATE INDEX IX_Reservas_FechaSalida ON Reservas(FechaSalida);
CREATE INDEX IX_Reservas_Estado ON Reservas(Estado);
CREATE INDEX IX_Habitaciones_Estado ON Habitaciones(Estado);
CREATE INDEX IX_Clientes_NumeroDocumento ON Clientes(NumeroDocumento);
GO

-- =============================================
-- Insertar datos de prueba
-- =============================================

-- Usuarios de prueba
INSERT INTO Usuarios (NombreUsuario, Password, NombreCompleto, Email, Rol)
VALUES 
    ('admin', 'admin123', 'Administrador del Sistema', 'admin@hotel.com', 'Administrador'),
    ('recepcion', 'recep123', 'María García López', 'maria.garcia@hotel.com', 'Recepcionista'),
    ('juan.perez', 'juan123', 'Juan Pérez Martínez', 'juan.perez@hotel.com', 'Recepcionista');
GO

-- Habitaciones de prueba
INSERT INTO Habitaciones (Numero, Tipo, Capacidad, PrecioPorNoche, Descripcion, Estado)
VALUES 
    ('101', 'Simple', 1, 50.00, 'Habitación simple con vista a la ciudad', 'Disponible'),
    ('102', 'Simple', 1, 50.00, 'Habitación simple económica', 'Disponible'),
    ('201', 'Doble', 2, 80.00, 'Habitación doble con cama matrimonial', 'Disponible'),
    ('202', 'Doble', 2, 80.00, 'Habitación doble con dos camas individuales', 'Disponible'),
    ('301', 'Suite', 4, 150.00, 'Suite junior con sala de estar', 'Disponible'),
    ('302', 'Suite', 4, 150.00, 'Suite con jacuzzi', 'Disponible'),
    ('401', 'Premium', 6, 250.00, 'Suite presidencial con terraza', 'Disponible'),
    ('103', 'Simple', 1, 50.00, 'Habitación en mantenimiento', 'Mantenimiento');
GO

-- Clientes de prueba
INSERT INTO Clientes (Nombre, Apellido, TipoDocumento, NumeroDocumento, Telefono, Email, Nacionalidad)
VALUES 
    ('Carlos', 'Rodríguez', 'DNI', '12345678', '555-1234', 'carlos.r@email.com', 'Salvadoreño'),
    ('Ana', 'Martínez', 'Pasaporte', 'P87654321', '555-5678', 'ana.m@email.com', 'Española'),
    ('Luis', 'González', 'DNI', '23456789', '555-9012', 'luis.g@email.com', 'Salvadoreño'),
    ('María', 'Hernández', 'DNI', '34567890', '555-3456', 'maria.h@email.com', 'Salvadoreña');
GO

-- Reservas de ejemplo
INSERT INTO Reservas (HabitacionId, ClienteId, FechaEntrada, FechaSalida, NumeroHuespedes, PrecioTotal, Estado, UsuarioRegistro)
VALUES 
    (1, 1, '2026-02-01', '2026-02-03', 1, 100.00, 'Confirmada', 1),
    (3, 2, '2026-02-05', '2026-02-10', 2, 400.00, 'Confirmada', 2),
    (5, 3, '2026-02-15', '2026-02-20', 4, 750.00, 'Pendiente', 2);
GO

-- =============================================
-- Procedimientos almacenados útiles
-- =============================================

-- Obtener habitaciones disponibles por fechas
CREATE PROCEDURE sp_HabitacionesDisponibles
    @FechaEntrada DATE,
    @FechaSalida DATE
AS
BEGIN
    SELECT h.*
    FROM Habitaciones h
    WHERE h.Activa = 1
      AND h.Estado = 'Disponible'
      AND h.HabitacionId NOT IN (
          SELECT HabitacionId 
          FROM Reservas 
          WHERE Estado IN ('Confirmada', 'Pendiente')
            AND (
                (@FechaEntrada BETWEEN FechaEntrada AND FechaSalida) OR
                (@FechaSalida BETWEEN FechaEntrada AND FechaSalida) OR
                (FechaEntrada BETWEEN @FechaEntrada AND @FechaSalida)
            )
      )
    ORDER BY Tipo, Numero;
END
GO

-- Estadísticas del día
CREATE PROCEDURE sp_EstadisticasDia
    @Fecha DATE = NULL
AS
BEGIN
    IF @Fecha IS NULL
        SET @Fecha = CAST(GETDATE() AS DATE);
    
    SELECT 
        (SELECT COUNT(*) FROM Habitaciones WHERE Activa = 1) AS TotalHabitaciones,
        (SELECT COUNT(*) FROM Habitaciones WHERE Estado = 'Disponible' AND Activa = 1) AS HabitacionesDisponibles,
        (SELECT COUNT(*) FROM Reservas WHERE Estado IN ('Confirmada', 'Pendiente')) AS ReservasActivas,
        (SELECT COUNT(*) FROM Reservas WHERE FechaEntrada = @Fecha AND Estado = 'Confirmada') AS CheckInsHoy,
        (SELECT COUNT(*) FROM Reservas WHERE FechaSalida = @Fecha AND Estado = 'Confirmada') AS CheckOutsHoy;
END
GO

PRINT 'Base de datos creada exitosamente';
PRINT 'Usuarios de prueba:';
PRINT '  - admin / admin123 (Administrador)';
PRINT '  - recepcion / recep123 (Recepcionista)';
PRINT '  - juan.perez / juan123 (Recepcionista)';
GO
