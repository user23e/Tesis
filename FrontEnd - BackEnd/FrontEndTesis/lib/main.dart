import 'package:flutter/material.dart';
import 'signin.dart';

// ============================================================================
// MAIN.DART - PUNTO DE ENTRADA DE LA APLICACIÓN
// ============================================================================
// Este es el archivo principal que Flutter ejecuta al iniciar la app.
// Muestra una pantalla de splash con la imagen de portada durante 3 segundos
// y luego redirige automáticamente a la pantalla de inicio de sesión (SignIn).
// ============================================================================

void main() {
  runApp(MainApp()); // Interfaz que muestra una imagen por 3 segundos como inicio de la aplicación.
  Future.delayed(Duration(seconds: 3), () {
    runApp(MyApp());
  });
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Image(
            image: AssetImage('assets/Portada.jpeg')
          ),
        ),
      ),
    );
  }
}