import 'package:flutter/material.dart';
import 'union.dart';
import 'menu.dart';

void main() {
  runApp(MyApp()); //Interfaz para crear una cuenta.
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeTrend',
      initialRoute: '/signup', // Ruta inicial para SignUpScreen
      routes: {
        '/signup': (context) => SignUpScreen(),
        '/menu': (context) => BeTrendHomePage(), // Ruta para la interfaz de menú
      },
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _spotifyAccountController = TextEditingController();
  bool _agreedToTerms = false;

  Future<void> _handleSignUp() async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final country = _countryController.text;
    final spotifyAccount = _spotifyAccountController.text;

    //Verificación de que se creó exitosamente la cuenta.
    final signUpSuccess = await getSignUp(
      firstName,
      lastName,
      email,
      password,
      country,
      spotifyAccount,
    );

    if (signUpSuccess) { //Si se creó la cuenta exitosamente, se le muestra el menu.
      // Navegar a la interfaz de menú
      Navigator.push(context, MaterialPageRoute(builder: (context) => BeTrendHomePage()));
    } else {
      // Mostrar un AlertDialog indicando que no se pudo crear el usuario
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('No se pudo crear el usuario. Por favor, inténtalo de nuevo.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.asset(
                    'assets/Logo.jpeg',
                    width: 300,
                    height: 300,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '       Sign Up',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        width: 300,
                        height: 40,
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      SizedBox(
                        width: 300,
                        height: 40,
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      SizedBox(
                        width: 300,
                        height: 40,
                        child: TextFormField(
                          controller: _countryController,
                          decoration: InputDecoration(
                            labelText: 'Country',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      SizedBox(
                        width: 300,
                        height: 40,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      SizedBox(
                        width: 300,
                        height: 40,
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      SizedBox(
                        width: 300,
                        height: 40,
                        child: TextFormField(
                          controller: _spotifyAccountController,
                          decoration: InputDecoration(
                            labelText: 'Spotify Account',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _agreedToTerms,
                              onChanged: (value) {
                                setState(() {
                                  _agreedToTerms = value!;
                                });
                              },
                            ),
                            Flexible(
                              child: Container(
                                width: 250,
                                child: Text(
                                  'I agree to the Terms of Services and Privacy Policy',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        width: 300,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: _agreedToTerms ? _handleSignUp : null, // Llama a _handleSignUp si se aceptaron los términos
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                        ),
                      ),
                    ],
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
