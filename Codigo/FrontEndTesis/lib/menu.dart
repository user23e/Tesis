import 'package:flutter/material.dart';
import 'profile.dart';
import 'music1.dart';
import 'logout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeTrend',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 233, 195, 240),
        ),
      ),
      initialRoute: '/menu',
      routes: {
        '/menu': (context) => BeTrendHomePage(),
        '/profile': (context) => UserProfilePage(),
        '/music1': (context) => MusicPage(),
        '/logout': (context) => MainApp(),
      },
    );
  }
}

class BeTrendHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '                           Menu',
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            SizedBox(
              height: 500,
              child: Center(
                child: Image.asset(
                  'assets/Logo.jpeg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: 175,
              height: 75,
              color: Color.fromARGB(255, 233, 195, 240),
              padding: EdgeInsets.all(16),
              child: Icon(
                Icons.music_note,
                color: Colors.yellow[700],
                size: 48,
              ),
            ),
            SizedBox(
              width: 175,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => MusicPage()));
                },
                icon: Icon(Icons.music_note, color: Colors.white),
                label: Text(
                  'Upload Music',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 14),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MainApp()));
              },
              child: Text(
                'Log out',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}