-- Ejercicio_ Productos
-- DDL (Data Definition Language):
/*Crear una tabla de productos:
Identificador de producto
Nombre producto
Descripcion producto
Precio producto
Stock producto*/
USE mi_base_de_datos;
DROP TABLE IF EXISTS productos;
CREATE TABLE IF NOT EXISTS productos(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	descripcion VARCHAR(500),
	precio DECIMAL(7,2),
	stock INT
);
-- Agregar una columna a la tabla de productos:
ALTER TABLE productos ADD COLUMN fecha_creacion DATE;
-- Cambiar el tipo de datos de una columna de la tabla de productos:
ALTER TABLE productos MODIFY COLUMN fecha_creacion DATETIME;
-- Eliminar una columna de la tabla de productos:
ALTER TABLE productos DROP COLUMN fecha_creacion;
-- Eliminar la tabla de productos:
TRUNCATE TABLE productos;

-- Ejercicio_ Productos
-- DML (Data Manipulation Language):
-- Insertar un nuevo producto en la tabla de productos:
INSERT INTO productos (nombre, descripcion, precio, stock)
VALUES ('Laptop', 'Laptop de alta gama con procesador Intel i7', 1299.99, 50);
-- Actualizar el precio de un producto:
UPDATE productos SET precio = 1499.99 WHERE id = 1;
-- Eliminar un producto de la tabla de productos:
DELETE FROM productos WHERE id = 1;
-- Seleccionar todos los productos de la tabla de productos:
SELECT * FROM productos;
-- Seleccionar solo el nombre y el precio de los productos de la tabla de productos:
SELECT nombre, precio FROM productos;