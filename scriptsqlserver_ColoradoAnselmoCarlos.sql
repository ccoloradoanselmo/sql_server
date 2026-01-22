/* =========================================================
   BORRADO DE TABLAS
   DROP TABLE elimina una tabla existente de la base de datos
   ========================================================= */

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
