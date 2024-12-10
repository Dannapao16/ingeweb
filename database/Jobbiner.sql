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

-- Insertar datos en Usuarios
INSERT INTO Usuarios (Nombre, Apellido, Email, Contrasena, TipoUsuario) VALUES
('Juan', 'Pérez', 'juan.perez@mail.com', 'Juan1', 'Postulante'),
('Ana', 'López', 'ana.lopez@mail.com', 'Ana2', 'Postulante'),
('Carlos', 'García', 'carlos.garcia@mail.com', 'Carlos3', 'Postulante'),
('Marta', 'Ruiz', 'marta.ruiz@mail.com', 'Marta4', 'Postulante'),
('Luis', 'Hernández', 'luis.hernandez@mail.com', 'Luis5', 'Postulante'),
('Laura', 'Fernández', 'laura.fernandez@mail.com', 'Laura6', 'Postulante'),
('Diego', 'Martínez', 'diego.martinez@mail.com', 'Diego7', 'Postulante'),
('Clara', 'Sánchez', 'clara.sanchez@mail.com', 'Clara8', 'Postulante'),
('Alberto', 'Jiménez', 'alberto.jimenez@mail.com', 'Alberto9', 'Postulante'),
('Valeria', 'Díaz', 'valeria.diaz@mail.com', 'Valeria10', 'Postulante'),
('Carla', 'Gómez', 'carla.gomez@mail.com', 'Carla11', 'Reclutador'),
('Andrés', 'Flores', 'andres.flores@mail.com', 'Andres12', 'Reclutador'),
('Sofía', 'Navarro', 'sofia.navarro@mail.com', 'Sofia13', 'Reclutador'),
('Gabriel', 'Muñoz', 'gabriel.munoz@mail.com', 'Gabriel14', 'Reclutador'),
('Paula', 'Castillo', 'paula.castillo@mail.com', 'Paula15', 'Reclutador'),
('José', 'Silva', 'jose.silva@mail.com', 'Jose16', 'Reclutador'),
('Eva', 'Mendoza', 'eva.mendoza@mail.com', 'Eva17', 'Reclutador'),
('Roberto', 'Iglesias', 'roberto.iglesias@mail.com', 'Roberto18', 'Reclutador'),
('Luz', 'Vega', 'luz.vega@mail.com', 'Luz19', 'Reclutador'),
('Oscar', 'Campos', 'oscar.campos@mail.com', 'Oscar20', 'Reclutador');

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
