/* =========================================================
   1. MODIFICAR EL DISEÑO DE UNA TABLA
   Se añade un valor por defecto a un campo NOT NULL
   ========================================================= */

ALTER TABLE PONENTES
ADD CONSTRAINT df_tarifa DEFAULT 10.00 FOR tarifa;
-- DEFAULT: valor que se asigna automáticamente si no se indica ninguno


/* =========================================================
   2. AÑADIR UNA RESTRICCIÓN CHECK
   Garantiza que la tarifa no pueda ser negativa
   ========================================================= */

ALTER TABLE PONENTES
ADD CONSTRAINT chk_tarifa_positiva CHECK (tarifa >= 0);
-- CHECK: obliga a que el valor cumpla una condición


/* =========================================================
   3. INSERTAR UNA FILA USANDO EL VALOR POR DEFECTO
   Al no indicar el campo tarifa, se usará el DEFAULT
   ========================================================= */

INSERT INTO PONENTES (idPonente, nombre)
VALUES (1, 'Ponente por defecto');
-- Al no insertar tarifa, SQL Server asigna automáticamente 10.00
