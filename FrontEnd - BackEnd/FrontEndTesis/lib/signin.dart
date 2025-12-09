import 'package:flutter/material.dart';
import 'union.dart';
import 'signup.dart';
import 'menu.dart';
import 'music1.dart'; 
import 'music2.dart';
import 'profile.dart';
import 'logout.dart';

// ============================================================================
// SIGNIN.DART - PANTALLA DE INICIO DE SESIÓN
// ============================================================================
// Interfaz de autenticación donde los usuarios ingresan email y contraseña.
// Valida las credenciales contra el backend y redirige al menú principal
// si el login es exitoso. También permite navegar a la pantalla de registro.
// ============================================================================

void main() {
  runApp(MyApp()); // Interfaz de inicio de sesión.
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeTrend',
      initialRoute: '/login', // Ruta inicial
      routes: {
        '/login': (context) => LoginScreen(), // Ruta para la pantalla de inicio de sesión
        '/menu': (context) => BeTrendHomePage(), // Ruta para la pantalla de menú
        '/profile': (context) => UserProfilePage(),    // Perfil
        
        // Rutas de Música
        '/music1': (context) => MusicPage(),            // Subir/Buscar canción
        '/music2': (context) => MusicPage2(),           // Resultado de la canción
        
        // Ruta de Logout
        '/logout': (context) => LogoutScreen(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 400,
                  child: Center(
                    child: Image.asset(
                      'assets/Logo.jpeg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: 300,
                  height: 70,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 300,
                  height: 70,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {//Se verifica que el usuario esté dentro de la base de datos.
                      bool loggedIn = await getSignIn(email, password);
                      if (loggedIn == true) {//Si existe, se muestra la interfaz de menu
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BeTrendHomePage()));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Your email or password are incorrect.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      Navigator.push( //Si se aplasta el texto de Sign Up, se la redirige a esa interfaz.
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
