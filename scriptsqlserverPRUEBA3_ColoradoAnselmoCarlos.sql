-- Usamos la base de datos
USE PotencialDigital2;
GO


-- Creación de la tabla COLEGIOS
-- Almacena los colegios que realizan actividades
CREATE TABLE COLEGIOS
(
    idColegio INT NOT NULL,
    -- Identificador del colegio (no es contador)

    nombre VARCHAR(100) NOT NULL,
    -- Nombre del colegio

    persona_contacto VARCHAR(100) NOT NULL,
    -- Persona de contacto del colegio

    tfno_contacto VARCHAR(20) NOT NULL,
    -- Teléfono de contacto

    CONSTRAINT pk_colegios PRIMARY KEY (idColegio)
    -- Clave primaria de la tabla
);


-- Inserción de la fila especial con idColegio = 0
-- Se usa como valor por defecto para indicar plazas disponibles
INSERT INTO COLEGIOS VALUES
(0, 'plazas disponibles', 'no procede', 'no procede');


-- Inserción de un colegio real para realizar pruebas
INSERT INTO COLEGIOS VALUES
(1, 'IES Centro', 'Ana López', '600111222');


-- Creación de la tabla COLEGIOS_ACTIVIDADES
-- Relaciona colegios con actividades (charlas)
CREATE TABLE COLEGIOS_ACTIVIDADES
(
    idReserva INT IDENTITY(1,1),
    -- Identificador de la reserva (contador)

    idColegio INT DEFAULT 0,
    -- Colegio que realiza la actividad (por defecto 0)

    idCharla SMALLINT NULL,
    -- Charla asociada (puede ser nula)

    fecha DATE NOT NULL,
    -- Fecha de la actividad

    numero_asistentes SMALLINT NOT NULL,
    -- Número de asistentes

    CONSTRAINT pk_colegios_actividades PRIMARY KEY (idReserva),
    -- Clave primaria de la tabla

    CONSTRAINT fk_ca_colegios FOREIGN KEY (idColegio)
        REFERENCES COLEGIOS (idColegio)
        ON DELETE CASCADE,
        -- Si se borra un colegio, se borran sus actividades

    CONSTRAINT fk_ca_charlas FOREIGN KEY (idCharla)
        REFERENCES CHARLAS (idCharla)
        ON DELETE NO ACTION
        -- No se permite borrar una charla si tiene actividades asociadas
);


-- Inserción de actividades de prueba
INSERT INTO COLEGIOS_ACTIVIDADES (idColegio, idCharla, fecha, numero_asistentes)
VALUES
(1, 1, '2026-02-10', 30),
-- Actividad asociada a un colegio y una charla

(0, NULL, '2026-02-15', 50);
-- Actividad sin colegio real ni charla asociada


-- PRUEBA 1
-- Borrado de un colegio que tiene actividades asociadas
DELETE FROM COLEGIOS WHERE idColegio = 1;
-- Resultado: se borra el colegio y automáticamente sus actividades (ON DELETE CASCADE)


-- PRUEBA 2
-- Intento de borrar una charla que tiene actividades asociadas
DELETE FROM CHARLAS WHERE idCharla = 1;
-- Resultado: no se permite el borrado (ON DELETE NO ACTION)
