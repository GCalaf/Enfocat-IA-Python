CREATE DATABASE IF NOT EXISTS bares_musicales_db;
USE bares_musicales_db;

DROP TABLE IF EXISTS localidad;
CREATE TABLE IF NOT EXISTS localidad(
	cod_prov INT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY(cod_prov)
);
DROP TABLE IF EXISTS empleado;
CREATE TABLE IF NOT EXISTS empleado(
	dni_emp VARCHAR(9),
    nombre VARCHAR(30) NOT NULL,
    domicilio VARCHAR(30),
    PRIMARY KEY(dni_emp)
);
DROP TABLE IF EXISTS pub;
CREATE TABLE IF NOT EXISTS pub(
	cod_pub VARCHAR(3),
	nombre VARCHAR(30) NOT NULL,
	licencia VARCHAR(15) NOT NULL,
	domicilio VARCHAR(30),
	f_apertura DATE NOT NULL,
	horario VARCHAR(4) NOT NULL,
	cod_prov INT NOT NULL,
    CONSTRAINT ChkHorario CHECK (horario IN ('HOR1', 'HOR2', 'HOR3')),
    PRIMARY KEY(cod_pub),
    FOREIGN KEY(cod_prov) REFERENCES localidad(cod_prov)
);
DROP TABLE IF EXISTS titular;
CREATE TABLE IF NOT EXISTS titular(
	dni_titular VARCHAR(9),
	nombre VARCHAR(30) NOT NULL,
	domicilio VARCHAR(30),
	cod_pub VARCHAR(3) NOT NULL,
    PRIMARY KEY(dni_titular),
    FOREIGN KEY(cod_pub) REFERENCES pub(cod_pub)
);
DROP TABLE IF EXISTS stock;
CREATE TABLE IF NOT EXISTS stock(
	cod_prod VARCHAR(5),
	nombre VARCHAR(30) NOT NULL,
	cantidad INT NOT NULL,
	precio FLOAT NOT NULL,
	cod_pub VARCHAR(3) NOT NULL,
    PRIMARY KEY(cod_prod),
    FOREIGN KEY(cod_pub) REFERENCES pub(cod_pub),
    CONSTRAINT ChkPrecio CHECK (precio > 0)
);
DROP TABLE IF EXISTS pub_empleado;
CREATE TABLE IF NOT EXISTS pub_empleado(
	cod_pub VARCHAR(3),
	dni_empleado VARCHAR(9),
	cargo VARCHAR(30),
    CONSTRAINT ChkCargo CHECK(cargo IN ('CAMARERO', 'SEGURIDAD', 'LIMPIEZA')),
    PRIMARY KEY(cod_pub, dni_empleado, cargo),
    FOREIGN KEY(cod_pub) REFERENCES pub(cod_pub),
    FOREIGN KEY(dni_empleado) REFERENCES empleado(dni_emp)
);

# Datos de la LOCALIDAD
  insert into localidad values (15002, 'La Coruña');
  insert into localidad values (15165, 'Bergondo');
  insert into localidad values (15160, 'Sada');
  insert into localidad values (15170, 'Betanzos');
  insert into localidad values (15001, 'Ayuntamiento Coruña');
  insert into localidad values (15004, 'Centro Coruña');  
  
# Datos del PUB
insert into pub values('01','Borges','Homologada1', 'Polvorin','2020-05-15', 'HOR1', '15002');
insert into pub values('02','Agua Mineral','Comprada', 'Orzan','1985-05-15', 'HOR1', '15001'); 
insert into pub values('03','Grietas','Robada', 'Matogrande','2002-02-10', 'HOR2', '15004'); 
insert into pub values('04','OH Coruña','Homologada', 'Orillamar','2020-05-15','HOR1', '15002');  
insert into pub values('05','Borges','Homologada1', 'Polvorin','2020-05-15', 'HOR1', '15002');
insert into pub values('06','Nueces','No  Homologada', 'Vereda','2010-05-15', 'HOR4', '15002');
  
 # Datos del TITULAR
insert into titular values ('1234567X', 'Manolo','Orillamar','01');
insert into titular values ('2345678c', 'Pepe','Riobao', '02');
insert into titular values ('5649872x', 'Tomas','Cacharrete', '02');
insert into titular values ('7654321X','Antonio','Mandin','01');
 
 # Datos EMPLEADO
insert into empleado values ('1234567X', 'Manuel','Orillamar');
insert into empleado values ('4534567X', 'Lucas','Orzan');
insert into empleado values ('1234886X', 'Luis','Monte Alto');

# DATOS EMPLEADOS DEL PUB
insert into pub_empleado values('01','1234567X','CAMARERO');
insert into pub_empleado values('03','1234567X','SEGURIDAD');
insert into pub_empleado values('04','4534567X','CAMARERO');
insert into pub_empleado values('05','46345678X','tocada de huevos');

# DATOS STOCK
INSERT INTO stock VALUES ('P001', 'Aceite del Sol', 100, 19.99, '01');
INSERT INTO stock VALUES ('P002', 'Miel de Montaña', 50, 29.99, '02');
INSERT INTO stock VALUES ('P003', 'Café de Los Andes', 75, 9.99, '03');
INSERT INTO stock VALUES ('P004', 'Te de Amazonas', 150, 39.99, '04');
INSERT INTO stock VALUES ('P005', 'Jugo del Valle', 25, -5.99, '05');