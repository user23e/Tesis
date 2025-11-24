-- ============================================================================
-- Script de Base de Datos para Tesis - Sistema de Análisis Musical
-- ============================================================================

DROP SCHEMA IF EXISTS tesis;
CREATE SCHEMA tesis;
USE tesis;

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
-- Almacena ÚNICAMENTE los 13 atributos del Training.csv
-- SIN nombre de canción - solo datos numéricos para el algoritmo estadístico
-- TIPO DE DATO CORREGIDO: DECIMAL(20,10) para permitir valores más grandes
-- ============================================================================
DROP TABLE IF EXISTS top_canciones;
CREATE TABLE top_canciones(
    id_topcancion INT AUTO_INCREMENT PRIMARY KEY,
    song_duration_ms DECIMAL(20,10) NOT NULL,
    acousticness DECIMAL(20,10) NOT NULL,
    danceability DECIMAL(20,10) NOT NULL,
    energy DECIMAL(20,10) NOT NULL,
    instrumentalness DECIMAL(20,10) NOT NULL,
    liveness DECIMAL(20,10) NOT NULL,
    loudness DECIMAL(20,10) NOT NULL,
    audio_mode DECIMAL(20,10) NOT NULL,
    speechiness DECIMAL(20,10) NOT NULL,
    tempo DECIMAL(20,10) NOT NULL,
    audio_valence DECIMAL(20,10) NOT NULL,
    time_signature_1 DECIMAL(20,10) NOT NULL,
    key_1 DECIMAL(20,10) NOT NULL,
    fecha_obtencion_datos DATE
);

-- ============================================================================
-- TABLA: usuario_canciones
-- Almacena las canciones asociadas a cada usuario con sus características
-- Incluye nombre_cancion porque representa canciones específicas del usuario
-- TIPO DE DATO CORREGIDO: DECIMAL(20,10) para permitir valores más grandes
-- ============================================================================
DROP TABLE IF EXISTS usuario_canciones;
CREATE TABLE usuario_canciones(
    id_cancion INT AUTO_INCREMENT PRIMARY KEY,
    nombre_cancion VARCHAR(100) NOT NULL,
    song_duration_ms DECIMAL(20,10) NOT NULL,
    acousticness DECIMAL(20,10) NOT NULL,
    danceability DECIMAL(20,10) NOT NULL,
    energy DECIMAL(20,10) NOT NULL,
    instrumentalness DECIMAL(20,10) NOT NULL,
    liveness DECIMAL(20,10) NOT NULL,
    loudness DECIMAL(20,10) NOT NULL,
    audio_mode DECIMAL(20,10) NOT NULL,
    speechiness DECIMAL(20,10) NOT NULL,
    tempo DECIMAL(20,10) NOT NULL,
    audio_valence DECIMAL(20,10) NOT NULL,
    time_signature_1 DECIMAL(20,10) NOT NULL,
    key_1 DECIMAL(20,10) NOT NULL,
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
-- SCRIPT PARA CARGAR Training.csv A top_canciones
-- Versión SIMPLIFICADA - Sin nombre_cancion
-- ============================================================================

-- PASO 1: Asegúrate de estar en el esquema correcto
USE tesis;

-- PASO 2: (OPCIONAL) Limpiar datos previos si quieres empezar de cero
 TRUNCATE TABLE top_canciones;

-- PASO 3: Cargar datos desde Training.csv
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/Training.csv'
INTO TABLE tesis.top_canciones
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(song_duration_ms, acousticness, danceability, energy, instrumentalness, 
 liveness, loudness, audio_mode, speechiness, tempo, audio_valence, 
 time_signature_1, key_1)
SET fecha_obtencion_datos = CURDATE();

-- ============================================================================
-- INSERCIÓN DE DATOS: usuario_canciones
-- Los primeros 5 usuarios tienen las canciones de los ejemplos del notebook
-- ============================================================================
INSERT INTO usuario_canciones (nombre_cancion, song_duration_ms, acousticness, danceability, energy, 
    instrumentalness, liveness, loudness, audio_mode, speechiness, tempo, audio_valence, 
    time_signature_1, key_1, usuario)
VALUES 
    -- USUARIO 1 - EJEMPLO 1
    ('Summer Vibes', 174275, 0.3370, 0.6690, 0.5610, 0.000000, 0.1980, -6.613, 1, 0.0318, 114.405, 0.8670, 0, 1, 1),
    
    -- USUARIO 2 - EJEMPLO 2
    ('Night Drive', 204400, 0.0485, 0.7600, 0.5880, 0.000000, 0.0847, -7.082, 1, 0.0775, 102.974, 0.3840, 0, 0, 2),
    
    -- USUARIO 3 - EJEMPLO 3
    ('Electric Dreams', 239013, 0.3560, 0.6070, 0.5750, 0.000007, 0.0608, -9.777, 0, 0.0930, 78.350, 0.7690, 0, 0, 3),
    
    -- USUARIO 4 - EJEMPLO 4
    ('Sunset Boulevard', 213903, 0.2840, 0.7780, 0.8240, 0.000000, 0.4050, -5.092, 0, 0.0712, 100.024, 0.7560, 0, 0, 4),
    
    -- USUARIO 5 - EJEMPLO 5
    ('Midnight Echo', 179895, 0.0365, 0.6290, 0.6860, 0.000024, 0.0709, -4.851, 1, 0.0626, 91.100, 0.7310, 0, 0, 5),
    
    -- USUARIOS 6-20 - Datos originales
    ('Melodia Propia 5', 0.0426282826, -0.3785656939, -1.0890217282, 1.2185881470, -0.2151559701, 2.1020086282, 0.1547985985, -1.3482537863, -0.2275834483, -0.9093681167, -0.5377341168, -0.0529256124, -0.3335919117, 6),
    ('Tema Favorito 6', -1.3249885557, 2.0057232650, 0.3925317691, -2.0962722833, 0.2280537797, -0.6867135750, -1.2358021923, -1.3482537863, -0.6107414952, 0.2826219569, -1.3424179808, -0.0529256124, -0.3335919117, 7),
    ('Música Personal 7', 0.0653138116, -0.9130255737, -0.7817871320, 0.9103465522, -0.1859804977, -0.4984075742, 1.1971169361, 0.7417001236, -0.8486363266, -0.9765172618, -0.5543255367, -0.0529256124, -0.3335919117, 8),
    ('Cancion Unica 8', 0.1767688016, -0.8765685560, 0.1467440921, 0.3595541941, -0.3381649104, -0.8638108853, -1.3651436012, 0.7417001236, -0.5475835754, -0.4315704149, 1.4283491386, -0.0529256124, -0.3335919117, 9),
    ('Mi Selección 9', -0.3736018569, -0.9154499654, -0.9319907124, 0.4454575894, -0.1898419573, 0.4431224301, 0.5536614910, 0.7417001236, -0.7623205028, 0.3599362213, -0.3842634830, -0.0529256124, -0.3335919117, 10),
    ('Track Especial 10', -0.5233263479, -0.9139005421, -0.6520658581, 1.5520954464, 1.9356770169, 0.2301573101, 1.7332695923, -1.3482537863, 1.4313645793, 0.1732541780, -0.7077961705, -0.0529256124, -0.3335919117, 11),
    ('Ritmo Personal 11', -1.3511262303, 0.4052601871, 0.7065938008, -0.4792671953, -0.3224616414, 0.1629051670, 0.3827718641, 0.7417001236, 0.0461008710, 0.2822880662, -1.3797486756, -0.0529256124, -0.3335919117, 12),
    ('Cancion Favorita 12', -0.6418089202, -0.9117131211, -0.6247561162, 1.0821533427, -0.3229765027, -0.8088883018, 0.4452748354, 0.7417001236, -0.0886360246, 0.6162159420, -0.9566674687, -0.0529256124, -0.3335919117, 13),
    ('Mi Tema 13', -0.4420036583, 0.2448493091, -0.0580789720, 1.2691195560, -0.1503692594, -0.8010422184, -0.5829532370, 0.7417001236, -0.6444257191, 0.9380866510, 0.8103187482, -0.0529256124, -0.3335919117, 14),
    ('Melodia Especial 14', 2.5445955422, -0.7686557835, -1.3348094052, 0.1170034309, -0.2760812213, -0.9108873856, -1.3597242684, 0.7417001236, -0.6444257191, 0.4572468333, -0.5543255367, -0.0529256124, -0.3335919117, 15),
    ('Track Personal 15', -0.0681362782, -0.2546118337, -0.8090968739, 0.7284334798, -0.3425841363, 2.1020086282, 1.1559300070, 0.7417001236, 0.2671535904, 0.2815460867, -1.0686595529, -0.0529256124, 2.9976745985, 16),
    ('Cancion Unica 16', -0.2917366873, -0.8985885947, 0.3242574144, 1.0114093701, -0.3203592912, 1.9562956513, 0.3213527592, 0.7417001236, -0.0528465367, 0.1478784790, 1.0052679317, -0.0529256124, -0.3335919117, 17),
    ('Mi Ritmo 17', -1.1649569439, 1.2948114195, 0.1945361404, -0.9289967354, -0.3425841363, -0.9075247784, 0.5558292241, 0.7417001236, -0.1054781366, -0.4097562175, 1.3163570544, -0.0529256124, -0.3335919117, 18),
    ('Tema Personal 18', 0.3493760869, -0.8466738014, 1.0138283970, 1.1124721881, -0.3397352373, -0.1621468583, -0.5580243062, -1.3482537863, 0.0018903271, -0.8200708833, 1.4076098637, -0.0529256124, -0.3335919117, 19),
    ('Melodia Favorita 19', 1.0401257848, -0.7300113447, 0.8294876393, -0.9997407080, -0.3403745233, -0.9602056239, -0.3842443684, 0.7417001236, -0.5981099112, 0.6570248148, 0.1508098081, -0.0529256124, -0.3335919117, 20);

-- ============================================================================
-- CONSULTAS DE VERIFICACIÓN
-- ============================================================================
-- Verificar los datos insertados
SELECT 'Usuarios registrados:' AS Info, COUNT(*) AS Total FROM usuarios;
SELECT 'Top canciones cargadas:' AS Info, COUNT(*) AS Total FROM top_canciones;
SELECT 'Canciones de usuarios:' AS Info, COUNT(*) AS Total FROM usuario_canciones;

-- Ver una muestra de cada tabla
SELECT * FROM usuarios LIMIT 23;
SELECT * FROM top_canciones LIMIT 5;
SELECT * FROM usuario_canciones LIMIT 5;

-- Ver específicamente las canciones de los primeros 5 usuarios (ejemplos del notebook)
SELECT *
FROM usuario_canciones uc
JOIN usuarios u ON uc.usuario = u.id_usuario
WHERE u.id_usuario <= 5
ORDER BY u.id_usuario;