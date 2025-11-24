import 'package:flutter/material.dart';
import 'signin.dart';

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

