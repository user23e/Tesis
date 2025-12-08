import 'package:flutter/material.dart';

class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // La imagen se muestra y luego se navega de vuelta automáticamente.
    Future.delayed(Duration(seconds: 3), () {
      // Navegar a la ruta '/login' (definida en signin.dart)
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (Route<dynamic> route) => false, // No permitir rutas anteriores en el stack
      );
    });

    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/LogOut.jpeg')
        ),
      ),
    );
  }
}