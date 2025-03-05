/*Ejercicio: Gestión de Permisos en MySQL
Eres el administrador de una base de datos en una empresa y debes configurar los
permisos de usuarios en MySQL para diferentes roles. Se te dan las siguientes
instrucciones:*/
-- 1. Crea una base de datos llamada empresa_db.
DROP DATABASE IF EXISTS empresa_db;
CREATE DATABASE IF NOT EXISTS empresa_db;
USE empresa_db;
/*2. Crea una tabla llamada empleados con los siguientes campos:
o id (INT, clave primaria)
o nombre (VARCHAR(100))
o salario (DECIMAL(10,2))*/
DROP TABLE IF EXISTS empleados;
CREATE TABLE IF NOT EXISTS empleados(
	id INT,
    nombre VARCHAR(100),
    salario DECIMAL(10,2),
    PRIMARY KEY(id)
);
/*3. Crea los siguientes usuarios con permisos específicos:
o analista_datos: Solo debe poder consultar la tabla empleados.
o gerente: Debe poder consultar e insertar empleados, pero no
eliminarlos.
o admin_rh: Debe tener todos los permisos sobre la tabla empleados,
incluyendo modificar y eliminar registros.*/
CREATE USER 'analista_datos'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT ON empresa_db.empleados TO 'analista_datos'@'localhost';
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT, INSERT ON empresa_db.empleados TO 'gerente'@'localhost';
CREATE USER 'admin_rh'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON empresa_db.empleados TO 'admin_rh'@'localhost';
FLUSH PRIVILEGES;
-- 4. Comprueba que los permisos han sido asignados correctamente.
SHOW GRANTS FOR 'analista_datos'@'localhost';
SHOW GRANTS FOR 'gerente'@'localhost';
SHOW GRANTS FOR 'admin_rh'@'localhost';