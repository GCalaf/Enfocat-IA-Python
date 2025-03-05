/*71TA01_ Ejercicio Gestión
Asistencia Empleados
Enunciado Completo:
Se desea ampliar el sistema de registro de asistencia para los empleados de una
empresa con el objetivo de proporcionar una visión más detallada y funcional de la
jornada laboral de cada empleado. La tabla Asistencia debe incluir información
sobre la llegada y salida de los empleados, si trabajaron de forma remota,
comentarios sobre el día, documentos adjuntos relevantes, el modo de transporte
utilizado para llegar al trabajo, y un resumen de las tareas completadas.
Los campos específicos y sus requisitos son los siguientes:
● EmpleadoID (INT): Un identificador único para cada empleado.
● FechaAsistencia (DATE): La fecha en que se registra la asistencia.
● EstadoAsistencia (ENUM): El estado de asistencia del empleado (puede ser
'Presente', 'Ausente', 'Vacaciones', 'Enfermedad').
● HoraEntrada (TIME): La hora exacta en que el empleado llegó al trabajo.
● HoraSalida (TIME): La hora exacta en que el empleado dejó el trabajo.
● TrabajoRemoto (BOOLEAN): Un indicador de si el empleado trabajó de forma
remota ese día.
● Comentarios (TEXT): Observaciones o comentarios adicionales sobre la
jornada laboral.
● DocumentoAdjunto (BLOB): Un archivo adjunto relevante, como un certificado
médico en formato PDF o imagen.
● ModoTransporte (ENUM): El medio de transporte utilizado por el empleado
para llegar al trabajo (puede ser 'Coche', 'Transporte Público', 'Bicicleta', 'A
pie').
● TareasCompletadas (SET): Una lista de tareas que el empleado completó ese
día, por ejemplo, ('Emails', 'Reuniones', 'Desarrollo', 'Diseño').

1. El script comprobará la existencia de la base de datos y tabla para su creación
2. Se añadiran 3 inserts de datos random.
3. Se entregará un fichero tipo script llamado "07TA01_nombreAlumno.sql" */

USE mi_base_de_datos;
DROP TABLE if exists Asistencia;
CREATE TABLE IF NOT exists Asistencia (
EmpleadoID INT,
FechaAsistencia DATE,
EstadoAsistencia ENUM('Presente', 'Ausente', 'Vacaciones', 'Enfermedad'),
HoraEntrada TIME,
HoraSalida TIME,
TrabajoRemoto BOOLEAN,
Comentarios TEXT,
DocumentoAdjunto BLOB,
ModoTransporte ENUM('Coche', 'Transporte Público', 'Bicicleta', 'A pie'),
TareasCompletadas SET('Emails', 'Reuniones', 'Desarrollo', 'Diseño'),
PRIMARY KEY (EmpleadoID, FechaAsistencia)
);
INSERT INTO Asistencia (
EmpleadoID,
FechaAsistencia,
EstadoAsistencia,
HoraEntrada,
HoraSalida,
TrabajoRemoto,
Comentarios,
DocumentoAdjunto,
ModoTransporte,
TareasCompletadas
)
VALUES (
1,
'2024-09-30',
'Presente',
'09:00:00',
'17:00:00',
TRUE,
'Trabajó en un proyecto importante.',
'71TA01_oscarBurgos.sql', -- Asumiendo que es un archivo en el servidor
'Coche',
'Emails,Desarrollo'
);

INSERT INTO Asistencia (
EmpleadoID,
FechaAsistencia,
EstadoAsistencia,
HoraEntrada,
HoraSalida,
TrabajoRemoto,
Comentarios,
DocumentoAdjunto,
ModoTransporte,
TareasCompletadas
)
VALUES (
2,
'2024-09-30',
'Presente',
'09:00:00',
'17:00:00',
TRUE,
'Trabajó en un proyecto importante.',
'71TA01_oscarBurgos.sql', -- Asumiendo que es un archivo en el servidor
'Bicicleta',
'Emails,Desarrollo'
);
select * from Asistencia;