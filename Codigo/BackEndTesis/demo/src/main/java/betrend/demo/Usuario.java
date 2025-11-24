package betrend.demo;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Usuario implements Serializable {
    private String nombre;
    private String apellido;
    private String email;
    private String contrasenia;
    private String pais;
    private String spotify;
    private List<UsuarioCancion> canciones;
    private int userId;


    // Constructor predeterminado.
    public Usuario() throws Exception {
        this("Anahi", "Andrade", "ana@example.com", "contrasenia123", "US", "Ana_spotify");
    }

    // Constructor parametrizado 1.
    public Usuario(String no, String ap, String em, String co, String pa, String sp) throws Exception {
        setNombre(no);
        setApellido(ap);
        setEmail(em);
        setContrasenia(co);
        setPais(pa);
        setSpotify(sp);
        setUsuarioCanciones(crearListaCanciones());
    }

    // Constructor parametrizado 2.
    public Usuario(String em, String co) throws Exception {
            setEmail(em);
            setContrasenia(co);
        }

    // Método auxiliar para crear una lista con 5 objetos de tipo UsuarioCancion.
    // Estas canciones se crean automáticamente al hacer signUp (simulando sincronización con Spotify)
    private static List<UsuarioCancion> crearListaCanciones() throws Exception {
        List<UsuarioCancion> usuarioCanciones = new ArrayList<>();

        // Agregar 5 objetos de tipo UsuarioCancion a la lista (valores de ejemplo del Training.csv)
        usuarioCanciones.add(new UsuarioCancion());
        usuarioCanciones.add(new UsuarioCancion("Me", -0.071, -0.881, -1.007, 0.450, -0.240, 1.003, 0.645, 0.741, -0.419, -0.733, 0.432, -0.052, -0.333));
        usuarioCanciones.add(new UsuarioCancion("Them", -2.358, 1.170, 1.580, -1.358, 5.749, 0.801, -1.139, 0.741, 2.757, -1.651, -0.396, -0.052, -0.333));
        usuarioCanciones.add(new UsuarioCancion("Feel", 0.813, -0.802, 0.972, 0.405, -0.340, -0.375, 1.016, 0.741, 0.551, 0.210, 1.133, -0.052, -0.333));
        usuarioCanciones.add(new UsuarioCancion("Insecurity", 0.190, -0.334, 0.815, -0.428, -0.286, -0.475, -0.446, 0.741, 2.168, 1.363, 0.329, -0.052, -0.333));

        return usuarioCanciones;
    }

    // Métodos set:
    public void setNombre(String no) throws Exception {
        if (no.length() > 0) {
            nombre = no;
        } else {
            throw new Exception("Nombre Usuario invalido.");
        }
    }

    public void setApellido(String ap) throws Exception {
        if (ap.length() > 0) {
            apellido = ap;
        } else {
            throw new Exception("Apellido Usuario invalido.");
        }
    }

    public void setEmail(String em) throws Exception {
        if (em.length() > 0) {
            email = em;
        } else {
            throw new Exception("Email Usuario invalido.");
        }
    }

    public void setContrasenia(String co) throws Exception {
        if (co.length() > 0) {
            contrasenia = co;
        } else {
            throw new Exception("Contrasenia Usuario invalido.");
        }
    }

    public void setPais(String pa) throws Exception {
        if (pa.length() > 0) {
            pais = pa;
        } else {
            throw new Exception("Pais Usuario invalido.");
        }
    }

    public void setSpotify(String sp) throws Exception {
        if (sp.length() > 0) {
            spotify = sp;
        } else {
            throw new Exception("Spotify Usuario invalido.");
        }
    }

    public void setUsuarioCanciones(List<UsuarioCancion> can) throws Exception {
        canciones=can;
    }

    public void setUserId(int id) {
            userId = id;
    }

    // Métodos get:
    public String getNombre() {
        return nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public String getEmail() {
        return email;
    }

    public String getContrasenia() {
        return contrasenia;
    }

    public String getPais() {
        return pais;
    }

    public String getSpotify() {
        return spotify;
    }

    public List<UsuarioCancion> getUsuarioCanciones() {
        return canciones;
    }

    public int getUserId() {
        return userId;
    }

    // Método toString:
    @Override
    public String toString() {
        return "[ " + getNombre() + ", " + getApellido() + ", " + getEmail() + ", "
                + getContrasenia() + ", " + getPais() + ", " + getSpotify() + getUsuarioCanciones()
                + " ]";
    }

    public int signIn() {
        try (Connection connection = DatabaseConnector.getConnection()) {
            String query = "SELECT id_usuario FROM usuarios WHERE email = ? AND contrasenia = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, getEmail());
                statement.setString(2, getContrasenia());
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        return resultSet.getInt("id_usuario");
                    } else {
                        return -1;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    // MÉTODO MODIFICADO: Ahora retorna int (el ID del usuario creado o -1 si falla)
    public int signUp() {
        Connection connection = null;
        try {
            connection = DatabaseConnector.getConnection();
            connection.setAutoCommit(false);

            String insertUsuarioQuery = "INSERT INTO usuarios (nombre, apellido, email, contrasenia, pais, spotify_usuario) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement insertUsuarioStatement = connection.prepareStatement(insertUsuarioQuery, Statement.RETURN_GENERATED_KEYS)) {
                insertUsuarioStatement.setString(1, getNombre());
                insertUsuarioStatement.setString(2, getApellido());
                insertUsuarioStatement.setString(3, getEmail());
                insertUsuarioStatement.setString(4, getContrasenia());
                insertUsuarioStatement.setString(5, getPais());
                insertUsuarioStatement.setString(6, getSpotify());
                int rowsAffected = insertUsuarioStatement.executeUpdate();

                if (rowsAffected > 0) {
                    try (ResultSet generatedKeys = insertUsuarioStatement.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int userId = generatedKeys.getInt(1);
                            
                            String insertCancionQuery = "INSERT INTO usuario_canciones (usuario, nombre_cancion, song_duration_ms, acousticness, danceability, energy, instrumentalness, liveness, loudness, audio_mode, speechiness, tempo, audio_valence, time_signature_1, key_1) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                            try (PreparedStatement insertCancionStatement = connection.prepareStatement(insertCancionQuery)) {
                                for (UsuarioCancion cancion : getUsuarioCanciones()) {
                                    insertCancionStatement.setInt(1, userId);
                                    insertCancionStatement.setString(2, cancion.getNombre());
                                    insertCancionStatement.setDouble(3, cancion.getSongDurationMs());
                                    insertCancionStatement.setDouble(4, cancion.getAcousticness());
                                    insertCancionStatement.setDouble(5, cancion.getDanceability());
                                    insertCancionStatement.setDouble(6, cancion.getEnergy());
                                    insertCancionStatement.setDouble(7, cancion.getInstrumentalness());
                                    insertCancionStatement.setDouble(8, cancion.getLiveness());
                                    insertCancionStatement.setDouble(9, cancion.getLoudness());
                                    insertCancionStatement.setDouble(10, cancion.getAudioMode());
                                    insertCancionStatement.setDouble(11, cancion.getSpeechiness());
                                    insertCancionStatement.setDouble(12, cancion.getTempo());
                                    insertCancionStatement.setDouble(13, cancion.getAudioValence());
                                    insertCancionStatement.setDouble(14, cancion.getTimeSignature1());
                                    insertCancionStatement.setDouble(15, cancion.getKey1());
                                    insertCancionStatement.addBatch();
                                }
                                insertCancionStatement.executeBatch();
                            }

                            connection.commit();
                            return userId; // Retorna el ID del usuario creado
                        }
                    }
                }
            }

            connection.rollback();
            return -1; // Retorna -1 si algo falló
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return -1; // Retorna -1 en caso de error
        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // MÉTODO MODIFICADO: Retorna valores RAW de la canción
    public Map<String, Object> Music(String nombreCancion) {
        Map<String, Object> resultado = new HashMap<>();
        
        try (Connection connection = DatabaseConnector.getConnection()) {
            String query = "SELECT nombre_cancion, song_duration_ms, acousticness, danceability, energy, " +
                           "instrumentalness, liveness, loudness, audio_mode, speechiness, tempo, " +
                           "audio_valence, time_signature_1, key_1 " +
                           "FROM usuario_canciones WHERE nombre_cancion = ? AND usuario = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, nombreCancion);
                statement.setInt(2, getUserId());
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        resultado.put("success", true);
                        resultado.put("songName", resultSet.getString("nombre_cancion"));
                        
                        // Calcular el porcentaje de tendencia general
                        int porcentaje = compararCaracteristicas(nombreCancion);
                        resultado.put("trendPercentage", porcentaje);
                        
                        // Agregar valores RAW de cada característica
                        resultado.put("songDurationMs", resultSet.getDouble("song_duration_ms"));
                        resultado.put("acousticness", resultSet.getDouble("acousticness"));
                        resultado.put("danceability", resultSet.getDouble("danceability"));
                        resultado.put("energy", resultSet.getDouble("energy"));
                        resultado.put("instrumentalness", resultSet.getDouble("instrumentalness"));
                        resultado.put("liveness", resultSet.getDouble("liveness"));
                        resultado.put("loudness", resultSet.getDouble("loudness"));
                        resultado.put("audioMode", resultSet.getDouble("audio_mode"));
                        resultado.put("speechiness", resultSet.getDouble("speechiness"));
                        resultado.put("tempo", resultSet.getDouble("tempo"));
                        resultado.put("audioValence", resultSet.getDouble("audio_valence"));
                        resultado.put("timeSignature", resultSet.getDouble("time_signature_1"));
                        resultado.put("key", resultSet.getDouble("key_1"));
                    } else {
                        resultado.put("success", false);
                        resultado.put("message", "Canción no encontrada para este usuario");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resultado.put("success", false);
            resultado.put("message", "Error al buscar la canción: " + e.getMessage());
        }
        
        return resultado;
    }
    
    // Método auxiliar para calcular porcentajes individuales de cada característica
    private Map<String, Integer> calcularCaracteristicasIndividuales(String nombreCancion) {
        Map<String, Integer> porcentajes = new HashMap<>();
        
        try (Connection connection = DatabaseConnector.getConnection()) {
            String query = "SELECT song_duration_ms, acousticness, danceability, energy, instrumentalness, " +
                           "liveness, loudness, audio_mode, speechiness, tempo, audio_valence, " +
                           "time_signature_1, key_1 " +
                           "FROM usuario_canciones WHERE nombre_cancion = ? AND usuario = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, nombreCancion);
                statement.setInt(2, getUserId());
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        double[] caracteristicas = {
                            resultSet.getDouble("song_duration_ms"),
                            resultSet.getDouble("acousticness"),
                            resultSet.getDouble("danceability"),
                            resultSet.getDouble("energy"),
                            resultSet.getDouble("instrumentalness"),
                            resultSet.getDouble("liveness"),
                            resultSet.getDouble("loudness"),
                            resultSet.getDouble("audio_mode"),
                            resultSet.getDouble("speechiness"),
                            resultSet.getDouble("tempo"),
                            resultSet.getDouble("audio_valence"),
                            resultSet.getDouble("time_signature_1"),
                            resultSet.getDouble("key_1")
                        };

                        String[] nombresCaracteristicas = {
                            "song_duration_ms", "acousticness", "danceability", "energy",
                            "instrumentalness", "liveness", "loudness", "audio_mode",
                            "speechiness", "tempo", "audio_valence", "time_signature_1", "key_1"
                        };

                        String queryLimites = "SELECT caracteristica, limite_inferior, limite_superior FROM ( " +
                                              "SELECT 'song_duration_ms' AS caracteristica, AVG(song_duration_ms) - " +
                                              "2.8076 * STDDEV(song_duration_ms) / SQRT(COUNT(*)) AS limite_inferior, " +
                                              "AVG(song_duration_ms) + 2.8076 * STDDEV(song_duration_ms) / SQRT(COUNT(*)) AS limite_superior " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'acousticness', AVG(acousticness) - " +
                                              "2.8076 * STDDEV(acousticness) / SQRT(COUNT(*)), " +
                                              "AVG(acousticness) + 2.8076 * STDDEV(acousticness) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'danceability', AVG(danceability) - " +
                                              "2.8076 * STDDEV(danceability) / SQRT(COUNT(*)), " +
                                              "AVG(danceability) + 2.8076 * STDDEV(danceability) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'energy', AVG(energy) - " +
                                              "2.8076 * STDDEV(energy) / SQRT(COUNT(*)), " +
                                              "AVG(energy) + 2.8076 * STDDEV(energy) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'instrumentalness', AVG(instrumentalness) - " +
                                              "2.8076 * STDDEV(instrumentalness) / SQRT(COUNT(*)), " +
                                              "AVG(instrumentalness) + 2.8076 * STDDEV(instrumentalness) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'liveness', AVG(liveness) - " +
                                              "2.8076 * STDDEV(liveness) / SQRT(COUNT(*)), " +
                                              "AVG(liveness) + 2.8076 * STDDEV(liveness) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'loudness', AVG(loudness) - " +
                                              "2.8076 * STDDEV(loudness) / SQRT(COUNT(*)), " +
                                              "AVG(loudness) + 2.8076 * STDDEV(loudness) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'audio_mode', AVG(audio_mode) - " +
                                              "2.8076 * STDDEV(audio_mode) / SQRT(COUNT(*)), " +
                                              "AVG(audio_mode) + 2.8076 * STDDEV(audio_mode) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'speechiness', AVG(speechiness) - " +
                                              "2.8076 * STDDEV(speechiness) / SQRT(COUNT(*)), " +
                                              "AVG(speechiness) + 2.8076 * STDDEV(speechiness) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'tempo', AVG(tempo) - " +
                                              "2.8076 * STDDEV(tempo) / SQRT(COUNT(*)), " +
                                              "AVG(tempo) + 2.8076 * STDDEV(tempo) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'audio_valence', AVG(audio_valence) - " +
                                              "2.8076 * STDDEV(audio_valence) / SQRT(COUNT(*)), " +
                                              "AVG(audio_valence) + 2.8076 * STDDEV(audio_valence) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'time_signature_1', AVG(time_signature_1) - " +
                                              "2.8076 * STDDEV(time_signature_1) / SQRT(COUNT(*)), " +
                                              "AVG(time_signature_1) + 2.8076 * STDDEV(time_signature_1) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'key_1', AVG(key_1) - " +
                                              "2.8076 * STDDEV(key_1) / SQRT(COUNT(*)), " +
                                              "AVG(key_1) + 2.8076 * STDDEV(key_1) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              ") AS limites";

                        try (PreparedStatement statementLimites = connection.prepareStatement(queryLimites);
                             ResultSet resultSetLimites = statementLimites.executeQuery()) {

                            int i = 0;
                            while (resultSetLimites.next() && i < caracteristicas.length) {
                                double limiteInferior = resultSetLimites.getDouble("limite_inferior");
                                double limiteSuperior = resultSetLimites.getDouble("limite_superior");
                                
                                // Calcular porcentaje individual (0-100%)
                                int porcentaje = 0;
                                if (caracteristicas[i] >= limiteInferior && caracteristicas[i] <= limiteSuperior) {
                                    // Está en rango, calcular qué tan cerca está del centro
                                    double centro = (limiteInferior + limiteSuperior) / 2;
                                    double rango = (limiteSuperior - limiteInferior) / 2;
                                    double distanciaDelCentro = Math.abs(caracteristicas[i] - centro);
                                    porcentaje = (int) Math.round(100 * (1 - (distanciaDelCentro / rango)));
                                } else if (caracteristicas[i] < limiteInferior) {
                                    // Está por debajo del rango
                                    double distancia = limiteInferior - caracteristicas[i];
                                    double rango = limiteSuperior - limiteInferior;
                                    porcentaje = Math.max(0, (int) Math.round(50 * (1 - (distancia / rango))));
                                } else {
                                    // Está por encima del rango
                                    double distancia = caracteristicas[i] - limiteSuperior;
                                    double rango = limiteSuperior - limiteInferior;
                                    porcentaje = Math.max(0, (int) Math.round(50 * (1 - (distancia / rango))));
                                }
                                
                                porcentajes.put(nombresCaracteristicas[i], porcentaje);
                                i++;
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return porcentajes;
    }

    private int compararCaracteristicas(String nombreCancion) {
        int caracteristicasEnRango = 0;

        try (Connection connection = DatabaseConnector.getConnection()) {
            String query = "SELECT song_duration_ms, acousticness, danceability, energy, instrumentalness, " +
                           "liveness, loudness, audio_mode, speechiness, tempo, audio_valence, " +
                           "time_signature_1, key_1 " +
                           "FROM usuario_canciones WHERE nombre_cancion = ? AND usuario = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, nombreCancion);
                statement.setInt(2, getUserId());
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        double[] caracteristicas = {
                                resultSet.getDouble("song_duration_ms"),
                                resultSet.getDouble("acousticness"),
                                resultSet.getDouble("danceability"),
                                resultSet.getDouble("energy"),
                                resultSet.getDouble("instrumentalness"),
                                resultSet.getDouble("liveness"),
                                resultSet.getDouble("loudness"),
                                resultSet.getDouble("audio_mode"),
                                resultSet.getDouble("speechiness"),
                                resultSet.getDouble("tempo"),
                                resultSet.getDouble("audio_valence"),
                                resultSet.getDouble("time_signature_1"),
                                resultSet.getDouble("key_1")
                        };

                        String queryLimites = "SELECT caracteristica, limite_inferior, limite_superior FROM ( " +
                                              "SELECT 'song_duration_ms' AS caracteristica, AVG(song_duration_ms) - " +
                                              "2.8076 * STDDEV(song_duration_ms) / SQRT(COUNT(*)) AS limite_inferior, " +
                                              "AVG(song_duration_ms) + 2.8076 * STDDEV(song_duration_ms) / SQRT(COUNT(*)) AS limite_superior " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'acousticness', AVG(acousticness) - " +
                                              "2.8076 * STDDEV(acousticness) / SQRT(COUNT(*)), " +
                                              "AVG(acousticness) + 2.8076 * STDDEV(acousticness) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'danceability', AVG(danceability) - " +
                                              "2.8076 * STDDEV(danceability) / SQRT(COUNT(*)), " +
                                              "AVG(danceability) + 2.8076 * STDDEV(danceability) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'energy', AVG(energy) - " +
                                              "2.8076 * STDDEV(energy) / SQRT(COUNT(*)), " +
                                              "AVG(energy) + 2.8076 * STDDEV(energy) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'instrumentalness', AVG(instrumentalness) - " +
                                              "2.8076 * STDDEV(instrumentalness) / SQRT(COUNT(*)), " +
                                              "AVG(instrumentalness) + 2.8076 * STDDEV(instrumentalness) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'liveness', AVG(liveness) - " +
                                              "2.8076 * STDDEV(liveness) / SQRT(COUNT(*)), " +
                                              "AVG(liveness) + 2.8076 * STDDEV(liveness) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'loudness', AVG(loudness) - " +
                                              "2.8076 * STDDEV(loudness) / SQRT(COUNT(*)), " +
                                              "AVG(loudness) + 2.8076 * STDDEV(loudness) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'audio_mode', AVG(audio_mode) - " +
                                              "2.8076 * STDDEV(audio_mode) / SQRT(COUNT(*)), " +
                                              "AVG(audio_mode) + 2.8076 * STDDEV(audio_mode) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'speechiness', AVG(speechiness) - " +
                                              "2.8076 * STDDEV(speechiness) / SQRT(COUNT(*)), " +
                                              "AVG(speechiness) + 2.8076 * STDDEV(speechiness) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'tempo', AVG(tempo) - " +
                                              "2.8076 * STDDEV(tempo) / SQRT(COUNT(*)), " +
                                              "AVG(tempo) + 2.8076 * STDDEV(tempo) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'audio_valence', AVG(audio_valence) - " +
                                              "2.8076 * STDDEV(audio_valence) / SQRT(COUNT(*)), " +
                                              "AVG(audio_valence) + 2.8076 * STDDEV(audio_valence) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'time_signature_1', AVG(time_signature_1) - " +
                                              "2.8076 * STDDEV(time_signature_1) / SQRT(COUNT(*)), " +
                                              "AVG(time_signature_1) + 2.8076 * STDDEV(time_signature_1) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              "UNION ALL " +
                                              "SELECT 'key_1', AVG(key_1) - " +
                                              "2.8076 * STDDEV(key_1) / SQRT(COUNT(*)), " +
                                              "AVG(key_1) + 2.8076 * STDDEV(key_1) / SQRT(COUNT(*)) " +
                                              "FROM top_canciones " +
                                              ") AS limites";

                        try (PreparedStatement statementLimites = connection.prepareStatement(queryLimites);
                             ResultSet resultSetLimites = statementLimites.executeQuery()) {

                            int i = 0;
                            while (resultSetLimites.next()) {
                                String caracteristica = resultSetLimites.getString("caracteristica");
                                double limiteInferior = resultSetLimites.getDouble("limite_inferior");
                                double limiteSuperior = resultSetLimites.getDouble("limite_superior");

                                if (caracteristicas[i] >= limiteInferior && caracteristicas[i] <= limiteSuperior) {
                                    caracteristicasEnRango++;
                                }
                                i++;
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        int totalCriterios = 13;
        int porcentaje = Math.round((caracteristicasEnRango * 100.0f) / totalCriterios);

        return porcentaje;
    }

    // MÉTODO MODIFICADO: Ahora retorna Map<String, Object>
    public Map<String, Object> Profile() {
        Map<String, Object> resultado = new HashMap<>();
        List<Map<String, Object>> songs = new ArrayList<>();
        
        try (Connection connection = DatabaseConnector.getConnection()) {
            String queryUserInfo = "SELECT u.nombre, u.apellido, u.spotify_usuario, uc.nombre_cancion " +
                                   "FROM usuarios u " +
                                   "JOIN usuario_canciones uc ON u.id_usuario = uc.usuario " +
                                   "WHERE u.id_usuario = ?";
            try (PreparedStatement statementUserInfo = connection.prepareStatement(queryUserInfo)) {
                statementUserInfo.setInt(1, getUserId());
                try (ResultSet resultSetUserInfo = statementUserInfo.executeQuery()) {
                    if (resultSetUserInfo.next()) {
                        String userName = resultSetUserInfo.getString("nombre") + " " + resultSetUserInfo.getString("apellido");
                        String spotifyUsername = resultSetUserInfo.getString("spotify_usuario");
                        
                        resultado.put("success", true);
                        resultado.put("userName", userName);
                        resultado.put("spotifyUsername", spotifyUsername);

                        List<Map<String, Object>> songList = new ArrayList<>();
                        do {
                            String songName = resultSetUserInfo.getString("nombre_cancion");
                            int trendPercentage = compararCaracteristicas(songName);
                            
                            Map<String, Object> songData = new HashMap<>();
                            songData.put("songName", songName);
                            songData.put("trendPercentage", trendPercentage);
                            songList.add(songData);
                        } while (resultSetUserInfo.next());

                        songList.sort((s1, s2) -> {
                            int trend1 = (int) s1.get("trendPercentage");
                            int trend2 = (int) s2.get("trendPercentage");
                            return Integer.compare(trend2, trend1);
                        });

                        resultado.put("songs", songList);
                    } else {
                        resultado.put("success", false);
                        resultado.put("message", "No se encontró información del usuario");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            resultado.put("success", false);
            resultado.put("message", "Error al obtener el perfil: " + e.getMessage());
        }
        
        return resultado;
    }
}