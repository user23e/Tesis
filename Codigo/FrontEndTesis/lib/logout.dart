import 'package:flutter/material.dart';

void main() {
  runApp(MainApp()); //Interfaz que muestra una imagen como finalización de la aplicación.
}

class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Image(
            image: AssetImage('assets/LogOut.jpeg')
          ),
        ),
      ),
    );
  }
}