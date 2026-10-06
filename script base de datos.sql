SET SQL_MODE = 'ALLOW_INVALID_DATES';

-- 2. Crear y seleccionar la base de datos
CREATE DATABASE IF NOT EXISTS sistema_permisos;
USE sistema_permisos;

-- 3. Crear la tabla 'permisos' en MySQL
CREATE TABLE IF NOT EXISTS permisos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    Usuario VARCHAR(50) NOT NULL,
    Contrasena VARCHAR(255) NOT NULL,
    Administrador TINYINT(1) DEFAULT 0,
    Correo VARCHAR(100),
    UsuarioSistema TINYINT(1) DEFAULT 0,
    FechaModificacion DATE,
    Modulo_Personal TINYINT(1) DEFAULT 0,
    Modulo_Horario TINYINT(1) DEFAULT 0,
    Modulo_Vacaciones TINYINT(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Insertar los registros exactos de la imagen
INSERT INTO permisos (id, Usuario, Contrasena, Administrador, Correo, UsuarioSistema, FechaModificacion, Modulo_Personal, Modulo_Horario, Modulo_Vacaciones) VALUES
(135, 'vielkarosmery', 'MTIzNDU=', 1, 'vreyes@umip.ac.pa', 0, '0000-00-00', 1, 1, 0),
(144, 'armando', 'cjNjdXJzMHM=', 1, 'amartinez@umip.ac.pa', 0, '0000-00-00', 1, 1, 1),
(145, 'pbarbax', 'YmFyYmF1bWlw', 1, 'pbarba@umip.ac.pa', 1, '0000-00-00', 0, 0, 0),
(146, 'root', 'TmV5bGFuMjUxNA==', 1, 'dreamsweb7@gmail.com', 0, '2020-05-20', 1, 1, 1);

-- 5. Tabla auxiliar para la consulta de inyección con SLEEP()
CREATE TABLE IF NOT EXISTS datospersonales (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO datospersonales (id, nombre) VALUES (10, 'Kankibe');

