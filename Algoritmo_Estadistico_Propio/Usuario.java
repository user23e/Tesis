import java.io.*;
import java.util.*;

import java.sql.ResultSet;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import java.sql.Statement;

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

        // Agregar 5 objetos de tipo UsuarioCancion a la lista (valores de ejemplo del AlgPropio.csv)
        usuarioCanciones.add(new UsuarioCancion());  // Hi (default)
        usuarioCanciones.add(new UsuarioCancion("Me", 117577, 0.573f, 0.863f, 0.39f, 0.0142f, 0.224f, -9.988f, true, 0.2f, 75.816f, 0.454f, false, false));
        usuarioCanciones.add(new UsuarioCancion("Them", 246240, 0.0316f, 0.774f, 0.739f, 0.00000595f, 0.119f, -4.022f, true, 0.0952f, 126.002f, 0.823f, false, false));
        usuarioCanciones.add(new UsuarioCancion("Feel", 220973, 0.16f, 0.751f, 0.574f, 0.000131f, 0.11f, -8.071f, true, 0.172f, 157.098f, 0.629f, false, false));
        usuarioCanciones.add(new UsuarioCancion("Insecurity", 214960, 0.148f, 0.472f, 0.9f, 0.000297f, 0.34f, -6.406f, false, 0.0582f, 95.826f, 0.42f, false, false));

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
            String query = "SELECT id_usuario, email, contrasenia FROM usuarios WHERE email = ? AND contrasenia = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                // Asignar valores a los parámetros
                statement.setString(1, getEmail());
                statement.setString(2, getContrasenia());
    
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        System.out.println("Welcome! You are logged in.");
                        int userId = resultSet.getInt("id_usuario");
                        setUserId(userId);
                    } else {
                        System.out.println("Email or password is wrong.");
                        System.exit(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return getUserId();
    }

    public int signUp() {
        try (Connection connection = DatabaseConnector.getConnection()) {
            String queryUsuario = "INSERT INTO usuarios (nombre, apellido, email, contrasenia, pais, spotify_usuario) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement statementUsuario = connection.prepareStatement(queryUsuario, Statement.RETURN_GENERATED_KEYS)) {
                statementUsuario.setString(1, getNombre());
                statementUsuario.setString(2, getApellido());
                statementUsuario.setString(3, getEmail());
                statementUsuario.setString(4, getContrasenia());
                statementUsuario.setString(5, getPais());
                statementUsuario.setString(6, getSpotify());

                int rowsInsertedUsuario = statementUsuario.executeUpdate();
                if (rowsInsertedUsuario > 0) {
                    System.out.println("User registered successfully!");

                    ResultSet generatedKeys = statementUsuario.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int userId = generatedKeys.getInt(1); // Asignar el ID generado a la variable userId

                        setUserId(userId);
                        
                        // Insertar datos de las canciones del usuario en la tabla usuario_canciones
                        // ACTUALIZADO: Ahora con tipos INT, FLOAT, BOOLEAN (sin género)
                        String queryCancion = "INSERT INTO usuario_canciones " +
                                            "(nombre_cancion, song_duration_ms, acousticness, danceability, energy, " +
                                            "instrumentalness, liveness, loudness, audio_mode, speechiness, tempo, " +
                                            "audio_valence, time_signature_1, key_1, usuario) " +
                                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        
                        try (PreparedStatement statementCancion = connection.prepareStatement(queryCancion)) {
                            for (UsuarioCancion cancion : getUsuarioCanciones()) {
                                statementCancion.setString(1, cancion.getNombre());
                                statementCancion.setInt(2, cancion.getSongDurationMs());
                                statementCancion.setFloat(3, cancion.getAcousticness());
                                statementCancion.setFloat(4, cancion.getDanceability());
                                statementCancion.setFloat(5, cancion.getEnergy());
                                statementCancion.setFloat(6, cancion.getInstrumentalness());
                                statementCancion.setFloat(7, cancion.getLiveness());
                                statementCancion.setFloat(8, cancion.getLoudness());
                                statementCancion.setBoolean(9, cancion.getAudioMode());
                                statementCancion.setFloat(10, cancion.getSpeechiness());
                                statementCancion.setFloat(11, cancion.getTempo());
                                statementCancion.setFloat(12, cancion.getAudioValence());
                                statementCancion.setBoolean(13, cancion.getTimeSignature1());
                                statementCancion.setBoolean(14, cancion.getKey1());
                                statementCancion.setInt(15, userId); // Utilizar el userId obtenido anteriormente

                                statementCancion.executeUpdate();
                            }
                        }
                    }
                } else {
                    System.out.println("Failed to register user.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return getUserId();
    }

    public void Music(String nombreCancion) {
        int porcentaje = compararCaracteristicas(nombreCancion);
        try (Connection connection = DatabaseConnector.getConnection()) {
            // Consulta para buscar la canción por el ID del usuario y el nombre de la canción
            // ACTUALIZADO: Ahora con 13 características (INT, FLOAT, BOOLEAN)
            String queryCancion = "SELECT * FROM usuario_canciones WHERE usuario = ? AND nombre_cancion = ?";
            try (PreparedStatement statementCancion = connection.prepareStatement(queryCancion)) {
                // Asignar el ID del usuario y el nombre de la canción a los parámetros de la consulta
                statementCancion.setInt(1, getUserId());
                statementCancion.setString(2, nombreCancion);
    
                try (ResultSet resultSetCancion = statementCancion.executeQuery()) {
                    if (resultSetCancion.next()) {
                        // Si se encuentra la canción, imprimir sus 13 características
                        int songDurationMs = resultSetCancion.getInt("song_duration_ms");
                        float acousticness = resultSetCancion.getFloat("acousticness");
                        float danceability = resultSetCancion.getFloat("danceability");
                        float energy = resultSetCancion.getFloat("energy");
                        float instrumentalness = resultSetCancion.getFloat("instrumentalness");
                        float liveness = resultSetCancion.getFloat("liveness");
                        float loudness = resultSetCancion.getFloat("loudness");
                        boolean audioMode = resultSetCancion.getBoolean("audio_mode");
                        float speechiness = resultSetCancion.getFloat("speechiness");
                        float tempo = resultSetCancion.getFloat("tempo");
                        float audioValence = resultSetCancion.getFloat("audio_valence");
                        boolean timeSignature1 = resultSetCancion.getBoolean("time_signature_1");
                        boolean key1 = resultSetCancion.getBoolean("key_1");
    
                        // Imprimir las características de la canción
                        System.out.println();
                        System.out.println("Your song has a " + porcentaje + "% to become a trend.");
                        System.out.println();
                        System.out.println("Characteristics of the song:");
                        System.out.printf("Song Duration (ms).......%d ms%n", songDurationMs);
                        System.out.printf("Acousticness.............%.4f%n", acousticness);
                        System.out.printf("Danceability.............%.4f%n", danceability);
                        System.out.printf("Energy...................%.4f%n", energy);
                        System.out.printf("Instrumentalness.........%.6f%n", instrumentalness);
                        System.out.printf("Liveness.................%.4f%n", liveness);
                        System.out.printf("Loudness.................%.3f dB%n", loudness);
                        System.out.printf("Audio Mode...............%b%n", audioMode);
                        System.out.printf("Speechiness..............%.4f%n", speechiness);
                        System.out.printf("Tempo....................%.3f BPM%n", tempo);
                        System.out.printf("Audio Valence............%.4f%n", audioValence);
                        System.out.printf("Time Signature...........%b%n", timeSignature1);
                        System.out.printf("Key......................%b%n", key1);
    
                    } else {
                        // Si no se encuentra la canción, imprimir un mensaje
                        System.out.println("Song does not exist for the user.");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int compararCaracteristicas(String nombreCancion) {
        int caracteristicasEnRango = 0;

        try (Connection connection = DatabaseConnector.getConnection()) {
            // ACTUALIZADO: Query con 13 características (INT, FLOAT, BOOLEAN)
            String query = "SELECT song_duration_ms, acousticness, danceability, energy, " +
                          "instrumentalness, liveness, loudness, audio_mode, speechiness, " +
                          "tempo, audio_valence, time_signature_1, key_1 " +
                          "FROM usuario_canciones WHERE usuario = ? AND nombre_cancion = ?";
            
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, getUserId());
                statement.setString(2, nombreCancion);

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        // Obtener valores (mezcla de int, float, boolean)
                        int songDurationMs = resultSet.getInt("song_duration_ms");
                        float acousticness = resultSet.getFloat("acousticness");
                        float danceability = resultSet.getFloat("danceability");
                        float energy = resultSet.getFloat("energy");
                        float instrumentalness = resultSet.getFloat("instrumentalness");
                        float liveness = resultSet.getFloat("liveness");
                        float loudness = resultSet.getFloat("loudness");
                        boolean audioMode = resultSet.getBoolean("audio_mode");
                        float speechiness = resultSet.getFloat("speechiness");
                        float tempo = resultSet.getFloat("tempo");
                        float audioValence = resultSet.getFloat("audio_valence");
                        boolean timeSignature1 = resultSet.getBoolean("time_signature_1");
                        boolean key1 = resultSet.getBoolean("key_1");

                        // Consulta para obtener los límites inferiores y superiores de las 13 características
                        // Para booleanos, usamos la moda (valor más frecuente)
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
                                              ") AS limites";

                        try (PreparedStatement statementLimites = connection.prepareStatement(queryLimites);
                             ResultSet resultSetLimites = statementLimites.executeQuery()) {

                            // Comparar características numéricas (primeras 10)
                            if (resultSetLimites.next()) {  // song_duration_ms
                                float limInf = resultSetLimites.getFloat("limite_inferior");
                                float limSup = resultSetLimites.getFloat("limite_superior");
                                if (songDurationMs >= limInf && songDurationMs <= limSup) caracteristicasEnRango++;
                            }
                            if (resultSetLimites.next()) {  // acousticness
                                float limInf = resultSetLimites.getFloat("limite_inferior");
                                float limSup = resultSetLimites.getFloat("limite_superior");
                                if (acousticness >= limInf && acousticness <= limSup) caracteristicasEnRango++;
                            }
                            if (resultSetLimites.next()) {  // danceability
                                float limInf = resultSetLimites.getFloat("limite_inferior");
                                float limSup = resultSetLimites.getFloat("limite_superior");
                                if (danceability >= limInf && danceability <= limSup) caracteristicasEnRango++;
                            }
                            if (resultSetLimites.next()) {  // energy
                                float limInf = resultSetLimites.getFloat("limite_inferior");
                                float limSup = resultSetLimites.getFloat("limite_superior");
                                if (energy >= limInf && energy <= limSup) caracteristicasEnRango++;
                            }
                            if (resultSetLimites.next()) {  // instrumentalness
                                float limInf = resultSetLimites.getFloat("limite_inferior");
                                float limSup = resultSetLimites.getFloat("limite_superior");
                                if (instrumentalness >= limInf && instrumentalness <= limSup) caracteristicasEnRango++;
                            }
                            if (resultSetLimites.next()) {  // liveness
                                float limInf = resultSetLimites.getFloat("limite_inferior");
                                float limSup = resultSetLimites.getFloat("limite_superior");
                                if (liveness >= limInf && liveness <= limSup) caracteristicasEnRango++;
                            }
                            if (resultSetLimites.next()) {  // loudness
                                float limInf = resultSetLimites.getFloat("limite_inferior");
                                float limSup = resultSetLimites.getFloat("limite_superior");
                                if (loudness >= limInf && loudness <= limSup) caracteristicasEnRango++;
                            }
                            if (resultSetLimites.next()) {  // speechiness
                                float limInf = resultSetLimites.getFloat("limite_inferior");
                                float limSup = resultSetLimites.getFloat("limite_superior");
                                if (speechiness >= limInf && speechiness <= limSup) caracteristicasEnRango++;
                            }
                            if (resultSetLimites.next()) {  // tempo
                                float limInf = resultSetLimites.getFloat("limite_inferior");
                                float limSup = resultSetLimites.getFloat("limite_superior");
                                if (tempo >= limInf && tempo <= limSup) caracteristicasEnRango++;
                            }
                            if (resultSetLimites.next()) {  // audio_valence
                                float limInf = resultSetLimites.getFloat("limite_inferior");
                                float limSup = resultSetLimites.getFloat("limite_superior");
                                if (audioValence >= limInf && audioValence <= limSup) caracteristicasEnRango++;
                            }
                        }

                        // Para las características booleanas, comparar con la moda (valor más frecuente)
                        String queryBooleanos = "SELECT " +
                                              "SUM(CASE WHEN audio_mode = 1 THEN 1 ELSE 0 END) as true_audio_mode, " +
                                              "SUM(CASE WHEN audio_mode = 0 THEN 1 ELSE 0 END) as false_audio_mode, " +
                                              "SUM(CASE WHEN time_signature_1 = 1 THEN 1 ELSE 0 END) as true_time_sig, " +
                                              "SUM(CASE WHEN time_signature_1 = 0 THEN 1 ELSE 0 END) as false_time_sig, " +
                                              "SUM(CASE WHEN key_1 = 1 THEN 1 ELSE 0 END) as true_key, " +
                                              "SUM(CASE WHEN key_1 = 0 THEN 1 ELSE 0 END) as false_key " +
                                              "FROM top_canciones";

                        try (PreparedStatement statementBool = connection.prepareStatement(queryBooleanos);
                             ResultSet resultSetBool = statementBool.executeQuery()) {
                            
                            if (resultSetBool.next()) {
                                // Comparar audio_mode con la moda
                                int trueAudioMode = resultSetBool.getInt("true_audio_mode");
                                int falseAudioMode = resultSetBool.getInt("false_audio_mode");
                                boolean modaAudioMode = trueAudioMode > falseAudioMode;
                                if (audioMode == modaAudioMode) caracteristicasEnRango++;

                                // Comparar time_signature_1 con la moda
                                int trueTimeSig = resultSetBool.getInt("true_time_sig");
                                int falseTimeSig = resultSetBool.getInt("false_time_sig");
                                boolean modaTimeSig = trueTimeSig > falseTimeSig;
                                if (timeSignature1 == modaTimeSig) caracteristicasEnRango++;

                                // Comparar key_1 con la moda
                                int trueKey = resultSetBool.getInt("true_key");
                                int falseKey = resultSetBool.getInt("false_key");
                                boolean modaKey = trueKey > falseKey;
                                if (key1 == modaKey) caracteristicasEnRango++;
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Calcular el porcentaje con 13 criterios
        int totalCriterios = 13;
        int porcentaje = Math.round((caracteristicasEnRango * 100.0f) / totalCriterios);

        return porcentaje;
    }

    public void Profile() {
        try (Connection connection = DatabaseConnector.getConnection()) {
            // Retrieve user information
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
    
                        // Display user information
                        System.out.println("Name: " + userName);
                        System.out.println("Spotify Username: " + spotifyUsername);
                        System.out.println();
                        System.out.println("Songs:");
    
                        // Create a list to store song names and their trend percentages
                        List<String[]> songs = new ArrayList<>();
    
                        // Iterate through user's songs and collect song names and their trend percentages
                        do {
                            String songName = resultSetUserInfo.getString("nombre_cancion");
                            int trendPercentage = compararCaracteristicas(songName);
                            songs.add(new String[]{songName, Integer.toString(trendPercentage)});
                        } while (resultSetUserInfo.next());
    
                        // Sort the songs based on trend percentages (in descending order)
                        Collections.sort(songs, new Comparator<String[]>() {
                            @Override
                            public int compare(final String[] entry1, final String[] entry2) {
                                final int trend1 = Integer.parseInt(entry1[1]);
                                final int trend2 = Integer.parseInt(entry2[1]);
                                return Integer.compare(trend2, trend1);
                            }
                        });
    
                        // Counter for enumeration
                        int songNumber = 1;
    
                        // Display songs in sorted order
                        for (String[] song : songs) {
                            System.out.println(songNumber + ". " + song[0] + ": " + song[1] + "%");
                            songNumber++;
                        }
                    } else {
                        System.out.println("No user information found.");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}