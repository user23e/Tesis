import 'package:flutter/material.dart';

// ============================================================================
// USUARIO_PROVIDER.DART - GESTIÓN DE ESTADO GLOBAL
// ============================================================================
// Providers que mantienen el estado global de la sesión del usuario.
// UsuarioProvider: almacena el ID del usuario logueado durante toda la sesión.
// CancionProvider: guarda el nombre de la canción seleccionada para análisis.
// Usa ChangeNotifier para notificar cambios a los widgets que escuchan.
// ============================================================================

class UsuarioProvider with ChangeNotifier{
  int _userId = 0; // Variable global para almacenar el ID de usuario

  void setUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }

  int get getUserId => _userId; // Getter para obtener el ID de usuario
}

class CancionProvider with ChangeNotifier{
  String _cancion=""; // Variable global para almacenar la cancion del usuario

  void setCancion(String cancion) {
    _cancion = cancion;
    notifyListeners();
  }

  String get getCancion => _cancion; // Getter para obtener la cancion del usuario
}
