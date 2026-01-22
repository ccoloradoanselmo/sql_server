/* =========================================================
   PRUEBAS DE INSERCIÓN (INSERT)
   ========================================================= */

/* Inserción correcta en CHARLAS */
INSERT INTO CHARLAS (idCharla, nombre, puntuacion_media)
VALUES (1, 'Charla SQL Server', 8.5);

/* Inserción correcta en USUARIOS */
INSERT INTO USUARIOS (idUsuario, nombre, telefono)
VALUES (1, 'Carlos', '34123456789');

/* Inserción correcta en FECHAS */
INSERT INTO FECHAS (fecha)
VALUES ('2026-01-22');

/* Inserción correcta en PONENTES usando DEFAULT */
INSERT INTO PONENTES (idPonente, nombre)
VALUES (1, 'Ponente Principal');
-- tarifa toma el valor por defecto


/* =========================================================
   PRUEBAS DE CLAVES AJENAS (FOREIGN KEY)
   ========================================================= */

/* Inserción correcta en ASISTENCIAS */
INSERT INTO ASISTENCIAS (idCharla, idUsuario)
VALUES (1, 1);

/* Inserción INCORRECTA: idCharla no existe → error de FK */
-- INSERT INTO ASISTENCIAS (idCharla, idUsuario)
-- VALUES (99, 1);


/* =========================================================
   PRUEBAS DE CHECK
   ========================================================= */

/* Inserción INCORRECTA: tarifa negativa → error CHECK */
-- INSERT INTO PONENTES (idPonente, nombre, tarifa)
-- VALUES (2, 'Ponente Incorrecto', -5);


/* =========================================================
   PRUEBAS DE UNIQUE
   ========================================================= */

/* Inserción INCORRECTA: teléfono repetido → error UNIQUE */
-- INSERT INTO USUARIOS (idUsuario, nombre, telefono)
-- VALUES (2, 'Usuario Repetido', '34123456789');


/* =========================================================
   PRUEBAS DE UPDATE
   ========================================================= */

/* Modificación correcta */
UPDATE PONENTES
SET tarifa = 25.00
WHERE idPonente = 1;

/* Modificación INCORRECTA: rompe el CHECK */
-- UPDATE PONENTES
-- SET tarifa = -10
-- WHERE idPonente = 1;


/* =========================================================
   PRUEBAS DE DELETE
   ========================================================= */

/* Borrado INCORRECTO: la charla tiene asistencias → error FK */
-- DELETE FROM CHARLAS
-- WHERE idCharla = 1;

/* Borrado correcto: primero borrar dependencias */
DELETE FROM ASISTENCIAS
WHERE idCharla = 1;

DELETE FROM CHARLAS
WHERE idCharla = 1;
