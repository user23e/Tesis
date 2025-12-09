package betrend.demo;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// ============================================================================
// DATABASECONNECTOR.JAVA - GESTOR DE CONEXIÓN A LA BASE DE DATOS
// ============================================================================
// Clase Singleton que gestiona la conexión a la base de datos MySQL.
// Establece y mantiene la conexión con la BD 'tesis1' en localhost:3306.
// Utiliza el patrón Singleton para garantizar una única instancia de conexión
// y evitar múltiples conexiones innecesarias a la base de datos.
// ============================================================================

public class DatabaseConnector {
    private static DatabaseConnector conexion;

	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/tesis1";
    private static final String USER = "root";
    private static final String PASSWORD = "123Inglaterra";

    private static Connection bddconeccion;

    private DatabaseConnector () {
		
	}

    public static Connection getConnection() throws SQLException {
        if(conexion == null) { 
			conexion = new DatabaseConnector();
		}
        
        bddconeccion=DriverManager.getConnection(JDBC_URL, USER, PASSWORD);

        return bddconeccion;
    }
}

