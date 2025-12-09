import 'package:flutter/material.dart';
import 'signin.dart';

// ============================================================================
// INICIO.DART - PANTALLA DE SPLASH ALTERNATIVA
// ============================================================================
// Archivo de respaldo que contiene la misma funcionalidad que main.dart.
// Muestra la imagen de portada durante 3 segundos antes de cargar la app.
// Se mantiene para compatibilidad con referencias existentes en el proyecto.
// ============================================================================

void main() {
  runApp(MainApp()); //Interfaz que muestra una imagen por 3 segundos como inicio de la aplicación.
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

