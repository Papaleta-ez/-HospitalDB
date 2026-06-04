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

--Modulo numero 4
INSERT INTO hospital.Especialidades (nombre, descripcion)
VALUES
('Cardiología', 'Especialidad médica del corazón'),
('Pediatría', 'Atención médica para niños'),
('Dermatología', 'Especialidad de la piel'),
('Ortopedia', 'Tratamiento de huesos y articulaciones'),
('Medicina General', 'Atención médica general');

INSERT INTO hospital.Medicos (nombre, apellido, id_especialidad, salario, correo, experiencia, turno)
VALUES
('Carlos', 'López', 1, 35000.00, 'carlos.lopez@uamv.edu.ni', 8, 'Mañana'),
('Andrea', 'Morales', 2, 32000.00, 'andrea.morales@uamv.edu.ni', 5, 'Tarde'),
('Luis', 'Ramírez', 3, 30000.00, 'luis.ramirez@uamv.edu.ni', 4, 'Mañana'),
('María', 'Gómez', 4, 36000.00, 'maria.gomez@uamv.edu.ni', 10, 'Noche'),
('José', 'Martínez', 5, 28000.00, 'jose.martinez@uamv.edu.ni', 3, 'Tarde'),
('Daniela', 'Castro', 1, 37000.00, 'daniela.castro@uamv.edu.ni', 9, 'Mañana'),
('Roberto', 'Mendoza', 2, 31000.00, 'roberto.mendoza@uamv.edu.ni', 6, 'Noche'),
('Sofía', 'Rivas', 3, 29500.00, 'sofia.rivas@uamv.edu.ni', 2, 'Tarde'),
('Miguel', 'Herrera', 4, 34000.00, 'miguel.herrera@uamv.edu.ni', 7, 'Mañana'),
('Fernanda', 'Torres', 5, 28500.00, 'fernanda.torres@uamv.edu.ni', 4, 'Noche');

INSERT INTO hospital.Pacientes (nombre, apellido, edad, correo, fecha_registro, direccion, genero, tipo_sangre, fecha_nacimiento)
VALUES
('Ana', 'Pérez', 25, 'ana.perez@uamv.edu.ni', GETDATE(), 'Managua, Bello Horizonte', 'Femenino', 'O+', '2000-04-12'),
('Luis', 'García', 30, 'luis.garcia@uamv.edu.ni', GETDATE(), 'Managua, Linda Vista', 'Masculino', 'A+', '1995-08-20'),
('María', 'López', 22, 'maria.lopez@uamv.edu.ni', GETDATE(), 'Masaya, Centro', 'Femenino', 'B+', '2003-01-15'),
('Carlos', 'Ruiz', 40, 'carlos.ruiz@uamv.edu.ni', GETDATE(), 'Granada, Calle Real', 'Masculino', 'AB+', '1985-06-10'),
('Sofía', 'Martínez', 19, 'sofia.martinez@uamv.edu.ni', GETDATE(), 'Managua, Carretera Norte', 'Femenino', 'O-', '2006-11-05'),
('Pedro', 'Castillo', 55, 'pedro.castillo@uamv.edu.ni', GETDATE(), 'León, Centro', 'Masculino', 'A-', '1970-02-18'),
('Gabriela', 'Núñez', 34, 'gabriela.nunez@uamv.edu.ni', GETDATE(), 'Chinandega, Reparto España', 'Femenino', 'B-', '1991-09-25'),
('Jorge', 'Sánchez', 28, 'jorge.sanchez@uamv.edu.ni', GETDATE(), 'Managua, Altamira', 'Masculino', 'O+', '1997-12-03'),
('Valeria', 'Mendoza', 45, 'valeria.mendoza@uamv.edu.ni', GETDATE(), 'Estelí, Centro', 'Femenino', 'AB-', '1980-07-22'),
('Ricardo', 'Flores', 50, 'ricardo.flores@uamv.edu.ni', GETDATE(), 'Matagalpa, Guanuca', 'Masculino', 'A+', '1975-03-14'),
('Elena', 'Torres', 27, 'elena.torres@uamv.edu.ni', GETDATE(), 'Managua, Las Colinas', 'Femenino', 'O+', '1998-05-09'),
('Diego', 'Vargas', 31, 'diego.vargas@uamv.edu.ni', GETDATE(), 'Masaya, Monimbó', 'Masculino', 'B+', '1994-10-30'),
('Paola', 'Reyes', 24, 'paola.reyes@uamv.edu.ni', GETDATE(), 'Granada, Xalteva', 'Femenino', 'A-', '2001-01-11'),
('Kevin', 'Morales', 36, 'kevin.morales@uamv.edu.ni', GETDATE(), 'Managua, Ciudad Jardín', 'Masculino', 'O-', '1989-04-28'),
('Lucía', 'Rojas', 29, 'lucia.rojas@uamv.edu.ni', GETDATE(), 'León, Sutiaba', 'Femenino', 'AB+', '1996-06-16'),
('Oscar', 'Aguilar', 42, 'oscar.aguilar@uamv.edu.ni', GETDATE(), 'Chinandega, El Rosario', 'Masculino', 'B-', '1983-08-19'),
('Camila', 'Salinas', 21, 'camila.salinas@uamv.edu.ni', GETDATE(), 'Managua, Villa Fontana', 'Femenino', 'A+', '2004-12-01'),
('Héctor', 'Navarro', 47, 'hector.navarro@uamv.edu.ni', GETDATE(), 'Estelí, La Comuna', 'Masculino', 'O+', '1978-09-07'),
('Natalia', 'Cruz', 33, 'natalia.cruz@uamv.edu.ni', GETDATE(), 'Matagalpa, Centro', 'Femenino', 'B+', '1992-02-23'),
('Mario', 'Espinoza', 60, 'mario.espinoza@uamv.edu.ni', GETDATE(), 'Managua, Ticuantepe', 'Masculino', 'AB-', '1965-05-05');

