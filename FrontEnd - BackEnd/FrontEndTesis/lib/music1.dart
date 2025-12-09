import 'package:flutter/material.dart';
import 'profile.dart';
import 'menu.dart';
import 'union.dart';
import 'music2.dart';

// ============================================================================
// MUSIC1.DART - PANTALLA DE BÚSQUEDA/SUBIDA DE CANCIONES
// ============================================================================
// Interfaz donde los usuarios ingresan el nombre de una canción para análisis.
// Valida que la canción exista en el backend y redirige a Music2 para mostrar
// el análisis completo con el porcentaje de tendencia y características musicales.
// ============================================================================

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 233, 195, 240),
        ),
      ),
      initialRoute: '/music1',
      routes: {
        '/music1': (context) => MusicPage(),
        '/profile': (context) => UserProfilePage(),
        '/menu': (context) => BeTrendHomePage(),
        '/music2': (context) => MusicPage2(),
      },
    );
  }
}

class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final _songNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '                           Music',
            style: TextStyle(
              color: Color(0xFF4DB6AC),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.account_circle,
            color: Color(0xFF4DB6AC),
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => UserProfilePage()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.purple[900],
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BeTrendHomePage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Text(
                'Will I be a trend?',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 233, 195, 240),
                    border: Border.all(color: Colors.deepPurple),
                  ),
                  child: Icon(Icons.music_note, color: Color(0xFF4DB6AC), size: 85),
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '       Enter the name of the song:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 300,
                height: 50,
                child: TextFormField(
                  controller: _songNameController,
                  decoration: InputDecoration(
                    labelText: 'Name of Song',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  String songName = _songNameController.text.trim();

                  if (songName.isNotEmpty) {
                    bool isSuccess = await getMusic1(songName);
                    print(isSuccess);

                    if (isSuccess) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MusicPage2()));
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('La canción no es correcta.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Ingrese el nombre de la canción.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text(
                  'Upload song',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}