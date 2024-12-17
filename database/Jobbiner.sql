CREATE DATABASE Jobbiner;
USE Jobbiner;

-- Tabla Usuarios
CREATE TABLE Usuarios (
    UsuarioID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Contrasena VARCHAR(255) NOT NULL,
    TipoUsuario ENUM('Postulante', 'Reclutador') NOT NULL,
    FechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
    Activo BOOLEAN DEFAULT 1
);
-- Visualizar tabla Usuarios
SELECT * FROM Usuarios;

DELETE FROM Usuarios;

DELETE FROM postulantes;
DELETE FROM Usuarios;


-- Actualizar un usuario
UPDATE Usuarios SET Activo = 0 WHERE UsuarioID = 5;

-- Consultar usuarios activos
SELECT * FROM Usuarios WHERE Activo = 1;

-- Eliminar un usuario
DELETE FROM Usuarios WHERE UsuarioID = 1;

-- Tabla Postulantes
CREATE TABLE Postulantes (
    PostulanteID INT AUTO_INCREMENT PRIMARY KEY,
    UsuarioID INT UNIQUE NOT NULL,
    FechaNacimiento DATE,
    Telefono VARCHAR(15),
    ExperienciaLaboral TEXT,
    Educacion TEXT,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

-- Tabla Reclutadores
CREATE TABLE Reclutadores (
    ReclutadorID INT AUTO_INCREMENT PRIMARY KEY,
    UsuarioID INT UNIQUE NOT NULL,
    Empresa VARCHAR(100) NOT NULL,
    Telefono VARCHAR(15),
    SitioWeb VARCHAR(255),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

-- Tabla Vacantes
CREATE TABLE Vacantes (
    VacanteID INT AUTO_INCREMENT PRIMARY KEY,
    ReclutadorID INT NOT NULL,
    Titulo VARCHAR(100) NOT NULL,
    Descripcion TEXT NOT NULL,
    Requisitos TEXT,
    Ubicacion VARCHAR(255),
    Salario DECIMAL(10,2),
    FechaPublicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FechaCierre DATETIME,
    Activa BOOLEAN DEFAULT 1,
    FOREIGN KEY (ReclutadorID) REFERENCES Reclutadores(ReclutadorID)
);

-- Tabla Postulaciones
CREATE TABLE Postulaciones (
    PostulacionID INT AUTO_INCREMENT PRIMARY KEY,
    PostulanteID INT NOT NULL,
    VacanteID INT NOT NULL,
    FechaPostulacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    Estado ENUM('Pendiente', 'Revisado', 'Rechazado', 'Aceptado') DEFAULT 'Pendiente',
    FOREIGN KEY (PostulanteID) REFERENCES Postulantes(PostulanteID),
    FOREIGN KEY (VacanteID) REFERENCES Vacantes(VacanteID)
);
