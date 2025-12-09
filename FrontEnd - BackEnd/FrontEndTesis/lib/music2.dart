import 'package:flutter/material.dart';
import 'union.dart';
import 'profile.dart';
import 'menu.dart';

// ============================================================================
// MUSIC2.DART - PANTALLA DE RESULTADOS Y ANÁLISIS DE CANCIONES
// ============================================================================
// Muestra el análisis completo de una canción: porcentaje de tendencia (con
// sistema de estrellas), y características musicales detalladas como danceability,
// energy, tempo, etc. Los datos se obtienen del backend mediante getMusic2().
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
      initialRoute: '/music2',
      routes: {
        '/music2': (context) => MusicPage2(),
        '/profile': (context) => UserProfilePage(),
        '/menu': (context) => BeTrendHomePage(),
      },
    );
  }
}

class MusicPage2 extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage2> {
  Map<String, dynamic> songData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getSongData();
  }

  Future<void> getSongData() async {
    try {
      Map<String, dynamic> data = await getMusic2();
      print("DEBUG - Song data received in music2: $data");
      setState(() {
        songData = data;
        isLoading = false;
      });
    } catch (e) {
      print("ERROR getting song data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Music'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
              SizedBox(height: 20),
              Text(
                'Your song has a',
                style: TextStyle(
                  fontSize: 30,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => Icon(
                            getStarIcon(index, songData['Percentage'] ?? 0),
                            color: Color(0xFF4DB6AC),
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${songData['Percentage'] ?? ''}%',
                        style: TextStyle(
                          fontSize: 53,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4DB6AC),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'to become a trend',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '     Characteristics of the song:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildCharacteristicRow('Song Duration (ms)', songData['Song Duration (ms)']),
              _buildCharacteristicRow('Acousticness', songData['Acousticness']),
              _buildCharacteristicRow('Danceability', songData['Danceability']),
              _buildCharacteristicRow('Energy', songData['Energy']),
              _buildCharacteristicRow('Instrumentalness', songData['Instrumentalness']),
              _buildCharacteristicRow('Liveness', songData['Liveness']),
              _buildCharacteristicRow('Loudness', songData['Loudness']),
              _buildCharacteristicRow('Audio Mode', songData['Audio Mode']),
              _buildCharacteristicRow('Speechiness', songData['Speechiness']),
              _buildCharacteristicRow('Tempo', songData['Tempo']),
              _buildCharacteristicRow('Audio Valence', songData['Audio Valence']),
              _buildCharacteristicRow('Time Signature', songData['Time Signature']),
              _buildCharacteristicRow('Key', songData['Key']),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCharacteristicRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SizedBox(width: 20),
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.yellow[700],
            ),
            child: Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Text(
            '${value ?? ''}',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

IconData getStarIcon(int index, num percentage) {
  if (percentage >= 80) {
    return Icons.star;
  } else if (percentage >= 60) {
    return index < 4 ? Icons.star : Icons.star_border;
  } else if (percentage >= 40) {
    return index < 3 ? Icons.star : Icons.star_border;
  } else if (percentage >= 20) {
    return index < 2 ? Icons.star : Icons.star_border;
  } else {
    return index < 1 ? Icons.star : Icons.star_border;
  }
}