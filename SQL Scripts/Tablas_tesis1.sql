-- ============================================================================
-- Script de Base de Datos para Tesis - Sistema de Análisis Musical
-- Esquema: tesis1 (Actualizado con AlgPropio.csv y 10 ejemplos del notebook)
-- ============================================================================

DROP SCHEMA IF EXISTS tesis1;
CREATE SCHEMA tesis1;
USE tesis1;

-- ============================================================================
-- TABLA: usuarios
-- Almacena la información de los usuarios del sistema
-- ============================================================================
DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios(
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    contrasenia VARCHAR(15) NOT NULL,
    pais CHAR(2) NOT NULL,
    spotify_usuario VARCHAR(50) NOT NULL
);

-- ============================================================================
-- TABLA: top_canciones
-- Almacena ÚNICAMENTE los 13 atributos del AlgPropio.csv
-- SIN nombre de canción - solo datos numéricos/booleanos para el algoritmo
-- ============================================================================
DROP TABLE IF EXISTS top_canciones;
CREATE TABLE top_canciones(
    id_topcancion INT AUTO_INCREMENT PRIMARY KEY,
    song_duration_ms INT NOT NULL,
    acousticness FLOAT NOT NULL,
    danceability FLOAT NOT NULL,
    energy FLOAT NOT NULL,
    instrumentalness FLOAT NOT NULL,
    liveness FLOAT NOT NULL,
    loudness FLOAT NOT NULL,
    audio_mode BOOLEAN NOT NULL,
    speechiness FLOAT NOT NULL,
    tempo FLOAT NOT NULL,
    audio_valence FLOAT NOT NULL,
    time_signature_1 BOOLEAN NOT NULL,
    key_1 BOOLEAN NOT NULL,
    fecha_obtencion_datos DATE
);

-- ============================================================================
-- TABLA: usuario_canciones
-- Almacena las canciones asociadas a cada usuario con sus características
-- Incluye nombre_cancion porque representa canciones específicas del usuario
-- ============================================================================
DROP TABLE IF EXISTS usuario_canciones;
CREATE TABLE usuario_canciones(
    id_cancion INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cancion VARCHAR(100) NOT NULL,
    song_duration_ms INT NOT NULL,
    acousticness FLOAT NOT NULL,
    danceability FLOAT NOT NULL,
    energy FLOAT NOT NULL,
    instrumentalness FLOAT NOT NULL,
    liveness FLOAT NOT NULL,
    loudness FLOAT NOT NULL,
    audio_mode BOOLEAN NOT NULL,
    speechiness FLOAT NOT NULL,
    tempo FLOAT NOT NULL,
    audio_valence FLOAT NOT NULL,
    time_signature_1 BOOLEAN NOT NULL,
    key_1 BOOLEAN NOT NULL,
    usuario INT NOT NULL,
    CONSTRAINT fk_usuario FOREIGN KEY (usuario) REFERENCES usuarios(id_usuario)
);

-- ============================================================================
-- INSERCIÓN DE DATOS: Usuarios
-- ============================================================================
INSERT INTO usuarios (id_usuario, nombre, apellido, email, contrasenia, pais, spotify_usuario)
VALUES 
    (1, 'Juan', 'Perez', 'juan@example.com', 'contrasenia123', 'MX', 'juan_spotify'),
    (2, 'Maria', 'Gomez', 'maria@example.com', 'password456', 'US', 'maria_spotify'),
    (3, 'Luis', 'Martinez', 'luis@example.com', 'qwerty789', 'ES', 'luis_spotify'),
    (4, 'Ana', 'Rodriguez', 'ana@example.com', 'abcdef012', 'AR', 'ana_spotify'),
    (5, 'Pedro', 'Sanchez', 'pedro@example.com', 'iloveyou345', 'US', 'pedro_spotify'),
    (6, 'Laura', 'Diaz', 'laura@example.com', 'lalala678', 'CO', 'laura_spotify'),
    (7, 'Carlos', 'Lopez', 'carlos@example.com', 'password123', 'MX', 'carlos_spotify'),
    (8, 'Sofia', 'Hernandez', 'sofia@example.com', '1234567890', 'PE', 'sofia_spotify'),
    (9, 'Diego', 'Gonzalez', 'diego@example.com', 'd1e2g3o4', 'CO', 'diego_spotify'),
    (10, 'Elena', 'Perez', 'elena@example.com', 'perez123', 'ES', 'elena_spotify'),
    (11, 'Fernando', 'Garcia', 'fernando@example.com', 'fernando456', 'AR', 'fernando_spotify'),
    (12, 'Isabel', 'Sanchez', 'isabel@example.com', 'sanchez789', 'MX', 'isabel_spotify'),
    (13, 'Alejandro', 'Lopez', 'alejandro@example.com', 'lopezabc', 'CO', 'alejandro_spotify'),
    (14, 'Carmen', 'Martinez', 'carmen@example.com', 'carmen123', 'ES', 'carmen_spotify'),
    (15, 'Miguel', 'Garcia', 'miguel@example.com', 'garcia456', 'US', 'miguel_spotify'),
    (16, 'Paula', 'Fernandez', 'paula@example.com', 'fernandez789', 'AR', 'paula_spotify'),
    (17, 'Roberto', 'Diaz', 'roberto@example.com', 'roberto123', 'CO', 'roberto_spotify'),
    (18, 'Patricia', 'Alvarez', 'patricia@example.com', 'alvarez456', 'MX', 'patricia_spotify'),
    (19, 'Javier', 'Romero', 'javier@example.com', 'romero789', 'ES', 'javier_spotify'),
    (20, 'Natalia', 'Gomez', 'natalia@example.com', 'gomezabc', 'US', 'natalia_spotify');

-- ============================================================================
-- SCRIPT PARA CARGAR AlgPropio.csv A top_canciones
-- ============================================================================

-- PASO 1: Asegúrate de estar en el esquema correcto
USE tesis1;

-- PASO 2: (OPCIONAL) Limpiar datos previos si quieres empezar de cero
TRUNCATE TABLE top_canciones;

-- PASO 3: Cargar datos desde AlgPropio.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/AlgPropio.csv'
INTO TABLE tesis1.top_canciones
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(song_duration_ms, acousticness, danceability, energy, instrumentalness, 
 liveness, loudness, @audio_mode_str, speechiness, tempo, audio_valence, 
 @time_signature_str, @key_str)
SET 
    audio_mode = IF(@audio_mode_str = 'True', 1, 0),
    time_signature_1 = IF(@time_signature_str = 'True', 1, 0),
    key_1 = IF(@key_str = 'True', 1, 0),
    fecha_obtencion_datos = CURDATE();

-- ============================================================================
-- INSERCIÓN DE DATOS: usuario_canciones
-- USUARIOS 1-10: Los 10 ejemplos EXACTOS del Notebook Tesis.ipynb
-- ============================================================================
INSERT INTO usuario_canciones (nombre_cancion, song_duration_ms, acousticness, danceability, energy, 
    instrumentalness, liveness, loudness, audio_mode, speechiness, tempo, audio_valence, 
    time_signature_1, key_1, usuario)
VALUES 
    -- ========================================================================
    -- USUARIO 1 - EJEMPLO 1 DEL NOTEBOOK
    -- ========================================================================
    ('Ejemplo_1', 174275, 0.337, 0.669, 0.561, 0.0, 0.198, -6.613, TRUE, 0.0318, 114.405, 0.867, FALSE, TRUE, 1),
    -- ========================================================================
    -- USUARIO 2 - EJEMPLO 2 DEL NOTEBOOK
    -- ========================================================================
    ('Ejemplo_2', 204400, 0.0485, 0.76, 0.588, 0.0, 0.0847, -7.082, TRUE, 0.0775, 102.974, 0.384, FALSE, FALSE, 2),
    -- ========================================================================
    -- USUARIO 3 - EJEMPLO 3 DEL NOTEBOOK
    -- ========================================================================
    ('Ejemplo_3', 239013, 0.356, 0.607, 0.575, 0.000007, 0.0608, -9.777, FALSE, 0.093, 78.35, 0.769, FALSE, FALSE, 3),
    -- ========================================================================
    -- USUARIO 4 - EJEMPLO 4 DEL NOTEBOOK
    -- ========================================================================
    ('Ejemplo_4', 213903, 0.284, 0.778, 0.824, 0.0, 0.405, -5.092, FALSE, 0.0712, 100.024, 0.756, FALSE, FALSE, 4),
    -- ========================================================================
    -- USUARIO 5 - EJEMPLO 5 DEL NOTEBOOK
    -- ========================================================================
    ('Ejemplo_5', 179895, 0.0365, 0.629, 0.686, 0.000024, 0.0709, -4.851, TRUE, 0.0626, 91.1, 0.731, FALSE, FALSE, 5),
    -- ========================================================================
    -- USUARIO 6 - EJEMPLO 6 DEL NOTEBOOK
    -- ========================================================================
    ('Ejemplo_6', 287400, 0.0478, 0.367, 0.445, 0.00284, 0.199, -13.615, FALSE, 0.0286, 67.197, 0.149, FALSE, FALSE, 6),
    -- ========================================================================
    -- USUARIO 7 - EJEMPLO 7 DEL NOTEBOOK
    -- ========================================================================
    ('Ejemplo_7', 204346, 0.0512, 0.772, 0.78, 0.0, 0.119, -4.288, FALSE, 0.108, 124.988, 0.719, FALSE, FALSE, 7),
    -- ========================================================================
    -- USUARIO 8 - EJEMPLO 8 DEL NOTEBOOK
    -- ========================================================================
    ('Ejemplo_8', 227106, 0.193, 0.828, 0.69, 0.00001, 0.0947, -5.732, TRUE, 0.0804, 95.997, 0.832, FALSE, TRUE, 8),
    -- ========================================================================
    -- USUARIO 9 - EJEMPLO 9 DEL NOTEBOOK
    -- ========================================================================
    ('Ejemplo_9', 209820, 0.0161, 0.759, 0.85, 0.0, 0.0745, -4.348, TRUE, 0.137, 110.003, 0.709, FALSE, FALSE, 9),
    -- ========================================================================
    -- USUARIO 10 - EJEMPLO 10 DEL NOTEBOOK
    -- ========================================================================
    ('Ejemplo_10', 238924, 0.0013, 0.392, 0.884, 0.000068, 0.35, -3.374, TRUE, 0.0385, 169.123, 0.508, FALSE, FALSE, 10),
    -- ========================================================================
    -- USUARIOS 11-20 - Datos ficticios
    -- ========================================================================
    ('Track Especial 10', 192008, 0.00116, 0.536, 0.966, 0.00531, 0.173, -2.037, FALSE, 0.137, 125.008, 0.379, FALSE, FALSE, 11),
    ('Ritmo Personal 11', 158437, 0.363, 0.735, 0.564, 0.0000469, 0.167, -5.775, TRUE, 0.0712, 127.947, 0.217, FALSE, FALSE, 12),
    ('Cancion Favorita 12', 187203, 0.00176, 0.54, 0.873, 0.0000457, 0.0803, -5.602, TRUE, 0.0648, 136.948, 0.319, FALSE, FALSE, 13),
    ('Mi Tema 13', 195306, 0.319, 0.623, 0.91, 0.000448, 0.081, -8.448, TRUE, 0.0384, 145.624, 0.745, FALSE, FALSE, 14),
    ('Melodia Especial 14', 316426, 0.041, 0.436, 0.682, 0.000155, 0.0712, -10.598, TRUE, 0.0384, 132.663, 0.416, FALSE, FALSE, 15),
    ('Track Personal 15', 210468, 0.182, 0.513, 0.803, 0.0, 0.34, -3.635, TRUE, 0.0817, 127.927, 0.292, FALSE, TRUE, 16),
    ('Cancion Unica 16', 201400, 0.00536, 0.679, 0.859, 0.0000518, 0.327, -5.945, TRUE, 0.0665, 124.324, 0.792, FALSE, FALSE, 17),
    ('Mi Ritmo 17', 165987, 0.607, 0.66, 0.475, 0.0, 0.0715, -5.296, TRUE, 0.064, 109.293, 0.867, FALSE, FALSE, 18),
    ('Tema Personal 18', 227400, 0.0196, 0.78, 0.879, 0.00000664, 0.138, -8.379, FALSE, 0.0691, 98.233, 0.889, FALSE, FALSE, 19),
    ('Melodia Favorita 19', 255413, 0.0516, 0.753, 0.461, 0.00000515, 0.0668, -7.898, TRUE, 0.0406, 138.048, 0.586, FALSE, FALSE, 20);

-- ============================================================================
-- CONSULTAS DE VERIFICACIÓN
-- ============================================================================
-- Verificar los datos insertados
SELECT 'Usuarios registrados:' AS Info, COUNT(*) AS Total FROM usuarios;
SELECT 'Top canciones cargadas:' AS Info, COUNT(*) AS Total FROM top_canciones;
SELECT 'Canciones de usuarios:' AS Info, COUNT(*) AS Total FROM usuario_canciones;

-- Ver una muestra de cada tabla
SELECT * FROM usuarios LIMIT 22;
SELECT * FROM top_canciones LIMIT 5;
SELECT * FROM usuario_canciones LIMIT 30;

-- Ver específicamente las canciones de los primeros 10 usuarios (ejemplos del notebook)
SELECT 
    u.id_usuario AS 'Usuario',
    CONCAT(u.nombre, ' ', u.apellido) AS 'Nombre Completo',
    u.email AS 'Correo',
    uc.nombre_cancion AS 'Canción',
    uc.song_duration_ms AS 'Duration (ms)',
    uc.acousticness AS 'Acousticness',
    uc.danceability AS 'Danceability',
    uc.energy AS 'Energy',
    uc.instrumentalness AS 'Instrumentalness',
    uc.liveness AS 'Liveness',
    uc.loudness AS 'Loudness',
    uc.audio_mode AS 'Audio Mode',
    uc.speechiness AS 'Speechiness',
    uc.tempo AS 'Tempo',
    uc.audio_valence AS 'Audio Valence',
    uc.time_signature_1 AS 'Time Signature',
    uc.key_1 AS 'Key'
FROM usuario_canciones uc
JOIN usuarios u ON uc.usuario = u.id_usuario
WHERE u.id_usuario BETWEEN 1 AND 10
ORDER BY u.id_usuario;