package betrend.demo;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DatabaseConnector {
    private static DatabaseConnector conexion;

	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/tesis";
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

