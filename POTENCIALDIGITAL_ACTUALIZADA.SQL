/* =========================================================
   TABLA CHARLAS
   ========================================================= */

CREATE TABLE CHARLAS
(
    idCharla SMALLINT NOT NULL, 
    -- SMALLINT: número entero pequeño
    -- NOT NULL: el campo no puede quedar vacío

    nombre VARCHAR(255) NOT NULL,
    -- VARCHAR(255): texto de longitud variable hasta 255 caracteres

    info_adicional VARCHAR(MAX),
    -- VARCHAR(MAX): texto largo sin límite fijo

    puntuacion_media DECIMAL(4,2),
    -- DECIMAL(4,2): número con 4 cifras totales y 2 decimales

    CONSTRAINT pk_charlas PRIMARY KEY (idCharla),
    -- PRIMARY KEY: identifica de forma única cada fila

    CONSTRAINT chk_puntuacion CHECK (puntuacion_media >= 0)
    -- CHECK: impone una condición sobre los valores
);


/* =========================================================
   TABLA USUARIOS
   ========================================================= */

CREATE TABLE USUARIOS
(
    idUsuario SMALLINT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    -- VARCHAR(100): texto de hasta 100 caracteres

    telefono CHAR(13) NOT NULL,
    -- CHAR(13): texto de longitud fija de 13 caracteres

    CONSTRAINT pk_usuarios PRIMARY KEY (idUsuario),

    CONSTRAINT uq_telefono UNIQUE (telefono)
    -- UNIQUE: no permite valores repetidos en la columna
);


/* =========================================================
   TABLA ASISTENCIAS
   ========================================================= */

CREATE TABLE ASISTENCIAS
(
    idCharla SMALLINT NOT NULL,
    idUsuario SMALLINT NOT NULL,

    CONSTRAINT pk_asistencias PRIMARY KEY (idCharla, idUsuario),
    -- Clave primaria compuesta: formada por más de una columna

    CONSTRAINT fk_asistencias_charlas FOREIGN KEY (idCharla)
        REFERENCES CHARLAS (idCharla)
        -- FOREIGN KEY: indica que el campo depende de otra tabla
        ON DELETE NO ACTION
        -- NO ACTION: no permite borrar si hay registros relacionados
        ON UPDATE CASCADE,
        -- CASCADE: los cambios se propagan a las tablas relacionadas

    CONSTRAINT fk_asistencias_usuarios FOREIGN KEY (idUsuario)
        REFERENCES USUARIOS (idUsuario)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);


/* =========================================================
   TABLA PONENTES
   ========================================================= */

CREATE TABLE PONENTES
(
    idPonente SMALLINT NOT NULL,
    nombre VARCHAR(100) NOT NULL,

    tarifa SMALLMONEY DEFAULT 0.00,
    -- SMALLMONEY: tipo numérico para cantidades económicas
    -- DEFAULT: valor que se asigna si no se indica ninguno

    CONSTRAINT pk_ponentes PRIMARY KEY (idPonente),

    CONSTRAINT chk_tarifa CHECK (tarifa >= 0)
);


/* =========================================================
   TABLA FECHAS
   ========================================================= */

CREATE TABLE FECHAS
(
    fecha DATE NOT NULL,
    -- DATE: almacena únicamente una fecha (año, mes y día)

    CONSTRAINT pk_fechas PRIMARY KEY (fecha)
);


/* =========================================================
   TABLA CHARLAS_FECHAS
   ========================================================= */

CREATE TABLE CHARLAS_FECHAS
(
    idCharla SMALLINT NOT NULL,
    fecha DATE NOT NULL,

    hora TIME NOT NULL,
    -- TIME: almacena solo la hora

    CONSTRAINT pk_charlas_fechas PRIMARY KEY (idCharla, fecha, hora),

    CONSTRAINT fk_cf_charlas FOREIGN KEY (idCharla)
        REFERENCES CHARLAS (idCharla)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,

    CONSTRAINT fk_cf_fechas FOREIGN KEY (fecha)
        REFERENCES FECHAS (fecha)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);


/* =========================================================
   TABLA CHARLAS_PONENTES
   ========================================================= */

CREATE TABLE CHARLAS_PONENTES
(
    idCharla SMALLINT NOT NULL,
    idPonente SMALLINT NOT NULL,

    CONSTRAINT pk_charlas_ponentes PRIMARY KEY (idCharla, idPonente),

    CONSTRAINT fk_cp_charlas FOREIGN KEY (idCharla)
        REFERENCES CHARLAS (idCharla)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,

    CONSTRAINT fk_cp_ponentes FOREIGN KEY (idPonente)
        REFERENCES PONENTES (idPonente)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);
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
