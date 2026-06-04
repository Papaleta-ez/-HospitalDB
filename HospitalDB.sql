USE master;
GO

IF DB_ID('HospitalDB') IS NOT NULL
BEGIN
    ALTER DATABASE HospitalDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE HospitalDB;
END
GO

CREATE DATABASE HospitalDB;
GO

SELECT name FROM sys.databases WHERE name = 'HospitalDB';
GO

USE HospitalDB;
GO

CREATE TABLE Especialidades (
    id_especialidad INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    descripcion VARCHAR(200)
);
GO

CREATE TABLE Pacientes (
    id_paciente INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    correo VARCHAR(100),
    fecha_registro DATE DEFAULT GETDATE()
);
GO

CREATE TABLE Medicos (
    id_medico INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    id_especialidad INT NOT NULL,
    salario DECIMAL(10,2),
    correo VARCHAR(100),

    CONSTRAINT FK_Medicos_Especialidades
    FOREIGN KEY (id_especialidad)
    REFERENCES Especialidades(id_especialidad)
);
GO

CREATE TABLE Habitaciones (
    id_habitacion INT IDENTITY(1,1) PRIMARY KEY,
    numero_habitacion VARCHAR(10) NOT NULL,
    tipo VARCHAR(50),
    estado VARCHAR(30)
);
GO

CREATE TABLE Citas (
    id_cita INT IDENTITY(1,1) PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_habitacion INT NULL,
    fecha_cita DATETIME NOT NULL,
    motivo VARCHAR(200),

    CONSTRAINT FK_Citas_Pacientes
    FOREIGN KEY (id_paciente)
    REFERENCES Pacientes(id_paciente),

    CONSTRAINT FK_Citas_Medicos
    FOREIGN KEY (id_medico)
    REFERENCES Medicos(id_medico),

    CONSTRAINT FK_Citas_Habitaciones
    FOREIGN KEY (id_habitacion)
    REFERENCES Habitaciones(id_habitacion)
);
GO

CREATE TABLE Tratamientos (
    id_tratamiento INT IDENTITY(1,1) PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    descripcion VARCHAR(200),
    fecha_inicio DATE,
    fecha_fin DATE,

    CONSTRAINT FK_Tratamientos_Pacientes
    FOREIGN KEY (id_paciente)
    REFERENCES Pacientes(id_paciente),

    CONSTRAINT FK_Tratamientos_Medicos
    FOREIGN KEY (id_medico)
    REFERENCES Medicos(id_medico)
);
GO

CREATE TABLE Medicamentos (
    id_medicamento INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200),
    precio DECIMAL(10,2),
    stock INT,
    fecha_vencimiento DATE
);
GO


