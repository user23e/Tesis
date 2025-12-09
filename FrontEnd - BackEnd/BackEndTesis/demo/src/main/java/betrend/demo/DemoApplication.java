package betrend.demo;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

// ============================================================================
// DEMOAPPLICATION.JAVA - CLASE PRINCIPAL DE SPRING BOOT
// ============================================================================
// Punto de entrada de la aplicación Spring Boot del backend.
// Inicializa el servidor Tomcat embebido en el puerto 8080 y configura
// todos los componentes de Spring (controladores REST, servicios, etc.).
// Esta clase arranca toda la infraestructura del servidor backend.
// ============================================================================

@SpringBootApplication
public class DemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

}
