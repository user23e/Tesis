import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'usuario_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main(List<String> arguments) async {
        ChangeNotifierProvider(create: (_) => UsuarioProvider());
        ChangeNotifierProvider(create: (_) => CancionProvider());
}

UsuarioProvider usuario = UsuarioProvider();
CancionProvider cancion = CancionProvider();

// Función para obtener la URL base según la plataforma
String getBaseUrl() {
  if (kIsWeb) {
    // Para navegadores web (Edge, Chrome, etc.)
    return 'http://localhost:8080';
  } else if (Platform.isAndroid) {
    // Para emulador Android: 10.0.2.2 apunta a localhost de la máquina
    return 'http://10.0.2.2:8080';
  } else if (Platform.isIOS) {
    // Para simulador iOS: localhost funciona
    return 'http://localhost:8080';
  } else {
    // Para otras plataformas (desktop, etc.)
    return 'http://localhost:8080';
  }
}

Future<bool> getSignIn(String emailInput, String passwordInput) async {
  var url = Uri.parse('${getBaseUrl()}/signIn?emailInput=$emailInput&passwordInput=$passwordInput');

  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      int userId = int.parse(response.body);
      
      if (userId > 0) {
        print("Welcome! You are logged in.");
        print("IdUser: $userId");
        usuario.setUserId(userId);
        return true;
      } else {
        print("Your email or password are incorrect.");
        return false;
      }
    } else {
      print("Your email or password are incorrect.");
      return false;
    }
  } catch (e) {
    print('Excepción al obtener al usuario (sign in): $e');
    return false;
  }
}

Future<bool> getSignUp(String nameInput, String lastInput, String emailInput, String passwordInput, String countryInput, String spotifyInput) async {
  var url = Uri.parse('${getBaseUrl()}/signUp?nameInput=$nameInput&lastInput=$lastInput&emailInput=$emailInput&passwordInput=$passwordInput&countryInput=$countryInput&spotifyInput=$spotifyInput');

  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      int userId = int.parse(response.body);
      
      if (userId > 0) {
        print("User registered successfully!");
        print("IdUser: $userId");
        usuario.setUserId(userId);
        return true;
      } else {
        print("Failed to register user.");
        return false;
      }
    } else {
      print("Failed to register user.");
      return false;
    }
  } catch (e) {
    print('Excepción al obtener al usuario (sign up): $e');
    return false;
  }
}

Future<bool> getMusic1(String nameSong) async {
  int userId = usuario.getUserId;
  var url = Uri.parse('${getBaseUrl()}/music1?userId=$userId&nameSong=$nameSong');

  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var bodyUtf8 = utf8.decode(response.bodyBytes);
      Map<String, dynamic> responseData = jsonDecode(bodyUtf8);

      if (responseData['success'] == true) {
        print("Song does exist for the user.");
        cancion.setCancion(nameSong);

        print('Song Information:');
        print('Song Name: ${responseData['songName']}');
        print('Trend Percentage: ${responseData['trendPercentage']}%');
        
        return true;
      } else {
        print("Song does not exist for the user (music1).");
        print('Message: ${responseData['message']}');
        return false;
      }
    } else {
      print("Song does not exist for the user (music1).");
      return false;
    }
  } catch (e) {
    print('Excepción al obtener la cancion (music1): $e');
    return false;
  }
}

Future<Map<String, dynamic>> getMusic2() async {
  String nameSong = cancion.getCancion;
  int userId = usuario.getUserId;
  var url = Uri.parse('${getBaseUrl()}/music1?userId=$userId&nameSong=$nameSong');
  
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var bodyUtf8 = utf8.decode(response.bodyBytes);
      Map<String, dynamic> responseData = jsonDecode(bodyUtf8);

      if (responseData['success'] == true) {
        print("Song does exist for the user.");
        
        Map<String, dynamic> songInfo = {
          'Percentage': responseData['trendPercentage'],
          'Song Duration (ms)': responseData['songDurationMs'] ?? 0,
          'Acousticness': responseData['acousticness'] ?? 0,
          'Danceability': responseData['danceability'] ?? 0,
          'Energy': responseData['energy'] ?? 0,
          'Instrumentalness': responseData['instrumentalness'] ?? 0,
          'Liveness': responseData['liveness'] ?? 0,
          'Loudness': responseData['loudness'] ?? 0,
          'Audio Mode': responseData['audioMode'] ?? 0,
          'Speechiness': responseData['speechiness'] ?? 0,
          'Tempo': responseData['tempo'] ?? 0,
          'Audio Valence': responseData['audioValence'] ?? 0,
          'Time Signature': responseData['timeSignature'] ?? 0,
          'Key': responseData['key'] ?? 0,
        };
        
        print('Song Information:');
        songInfo.forEach((key, value) {
          print('$key: $value');
        });
        
        return songInfo;
      } else {
        print("Song does not exist for the user (music2).");
        print('Message: ${responseData['message']}');
        return {};
      }
    } else {
      print("Song does not exist for the user (music2).");
      return {};
    }
  } catch (e) {
    print('Exception while getting the song (music2): $e');
    return {};
  }
}

Future<Map<String, dynamic>> getProfile() async {
  int userId = usuario.getUserId;
  var url = Uri.parse('${getBaseUrl()}/profile?userId=$userId');
  
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var bodyUtf8 = utf8.decode(response.bodyBytes);
      Map<String, dynamic> responseData = jsonDecode(bodyUtf8);

      if (responseData['success'] == true) {
        String userName = responseData['userName'];
        String spotifyUsername = responseData['spotifyUsername'];

        List<dynamic> songsData = responseData['songs'];
        List<Map<String, dynamic>> songs = songsData.map((songData) => {
          'songName': songData['songName'],
          'trendPercentage': songData['trendPercentage'],
        }).toList();

        var profile = {
          'name': userName,
          'spotifyUsername': spotifyUsername,
          'songs': songs,
        };

        print('User Profile:');
        print(profile);
        
        return profile;
      } else {
        print("Failed to fetch user profile.");
        print('Message: ${responseData['message']}');
        return {};
      }
    } else {
      print("Failed to fetch user profile.");
      return {};
    }
  } catch (e) {
    print('Exception while getting the user profile: $e');
    return {};
  }
}