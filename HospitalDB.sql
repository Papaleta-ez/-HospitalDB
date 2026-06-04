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

USE HospitalDB;
GO

CREATE SCHEMA hospital;
GO

CREATE TABLE hospital.Especialidades (
    id_especialidad INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(80) NOT NULL,
    descripcion VARCHAR(200)
)

CREATE TABLE hospital.Pacientes (
    id_paciente INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NULL,
    apellido VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    correo VARCHAR(100),
    fecha_registro DATE
)

CREATE TABLE hospital.Medicos (
    id_medico INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(50) NULL,
    apellido VARCHAR(50) NOT NULL,
    id_especialidad INT NOT NULL,
    salario DECIMAL(10,2),
    correo VARCHAR(100)
)

CREATE TABLE hospital.Habitaciones (
    id_habitacion INT IDENTITY(1,1) NOT NULL,
    numero_habitacion VARCHAR(10) NOT NULL,
    tipo VARCHAR(50),
    estado VARCHAR(30),
    id_paciente INT NULL
)

CREATE TABLE hospital.Citas (
    id_cita INT IDENTITY(1,1) NOT NULL,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_habitacion INT NULL,
    fecha_cita DATETIME NOT NULL,
    motivo VARCHAR(200)
)

CREATE TABLE hospital.Tratamientos (
    id_tratamiento INT IDENTITY(1,1) NOT NULL,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    descripcion VARCHAR(200),
    fecha_inicio DATE,
    fecha_fin DATE
)

CREATE TABLE hospital.Medicamentos (
    id_medicamento INT IDENTITY(1,1) NOT NULL,
    id_tratamiento INT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200),
    precio DECIMAL(10,2),
    stock INT,
    fecha_vencimiento DATE
)

--Tabla restricciones

ALTER TABLE hospital.Especialidades
ADD CONSTRAINT PK_Especialidades PRIMARY KEY (id_especialidad);

ALTER TABLE hospital.Pacientes
ADD CONSTRAINT PK_Pacientes PRIMARY KEY (id_paciente);

ALTER TABLE hospital.Medicos
ADD CONSTRAINT PK_Medicos PRIMARY KEY (id_medico);

ALTER TABLE hospital.Habitaciones
ADD CONSTRAINT PK_Habitaciones PRIMARY KEY (id_habitacion);

ALTER TABLE hospital.Citas
ADD CONSTRAINT PK_Citas PRIMARY KEY (id_cita);

ALTER TABLE hospital.Tratamientos
ADD CONSTRAINT PK_Tratamientos PRIMARY KEY (id_tratamiento);

ALTER TABLE hospital.Medicamentos
ADD CONSTRAINT PK_Medicamentos PRIMARY KEY (id_medicamento);

ALTER TABLE hospital.Pacientes
ALTER COLUMN nombre VARCHAR(50) NOT NULL;

ALTER TABLE hospital.Medicos
ALTER COLUMN nombre VARCHAR(50) NOT NULL;

ALTER TABLE hospital.Pacientes
ADD CONSTRAINT UQ_Pacientes_Correo UNIQUE (correo);

ALTER TABLE hospital.Medicos
ADD CONSTRAINT UQ_Medicos_Correo UNIQUE (correo);

ALTER TABLE hospital.Pacientes
ADD CONSTRAINT CK_Pacientes_Edad CHECK (edad >= 0);

ALTER TABLE hospital.Medicos
ADD CONSTRAINT CK_Medicos_Salario CHECK (salario > 0);

ALTER TABLE hospital.Pacientes
ADD CONSTRAINT DF_Pacientes_FechaRegistro DEFAULT GETDATE() FOR fecha_registro;

--Modulo numero 3
ALTER TABLE hospital.Pacientes
ADD telefono VARCHAR(20);

ALTER TABLE hospital.Pacientes
ADD direccion VARCHAR(150);

ALTER TABLE hospital.Pacientes
ADD genero VARCHAR(20);

ALTER TABLE hospital.Pacientes
ADD tipo_sangre VARCHAR(5);

ALTER TABLE hospital.Pacientes
ADD fecha_nacimiento DATE;

ALTER TABLE hospital.Pacientes
ALTER COLUMN nombre VARCHAR(100) NOT NULL;

ALTER TABLE hospital.Pacientes
ALTER COLUMN direccion VARCHAR(200);

ALTER TABLE hospital.Medicos
ADD experiencia INT;

ALTER TABLE hospital.Medicos
ADD turno VARCHAR(30);

ALTER TABLE hospital.Medicos
ADD observaciones VARCHAR(200);

ALTER TABLE hospital.Medicos
DROP COLUMN observaciones;

ALTER TABLE hospital.Citas
ADD estado VARCHAR(30);

ALTER TABLE hospital.Citas
ADD costo_consulta DECIMAL(8,2);

ALTER TABLE hospital.Citas
ALTER COLUMN costo_consulta DECIMAL(10,2);

ALTER TABLE hospital.Habitaciones
ADD disponibilidad BIT;