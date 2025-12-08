import 'package:flutter/material.dart';
import 'union.dart';
import 'music2.dart';
import 'menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 233, 195, 240),
        ),
      ),
      initialRoute: '/profile',
      routes: {
        '/profile': (context) => UserProfilePage(),
        '/menu': (context) => BeTrendHomePage(),
        '/music2': (context) => MusicPage2(),
      },
    );
  }
}

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Map<String, dynamic> _profileData = {};

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    Map<String, dynamic> profileData = await getProfile();
    print("DEBUG - Profile data received: $profileData");
    setState(() {
      _profileData = profileData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.account_circle,
          color: Color(0xFF4DB6AC),
        ),
        title: Text(
          '                           Profile',
          style: TextStyle(
            color: Color(0xFF4DB6AC),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  Icons.account_circle,
                  size: 250,
                  color: Colors.yellow[700],
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '${_profileData['name'] ?? ''}',
                        style: TextStyle(fontSize: 12.0),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Spotify Username:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '${_profileData['spotifyUsername'] ?? ''}',
                        style: TextStyle(fontSize: 12.0),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Songs:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    ...(_profileData['songs'] as List<dynamic>?)?.map((song) {
                          print("DEBUG - Song data: $song");
                          return SongListTile(
                            songName: song['songName']?.toString() ?? '',
                            percentage: song['trendPercentage'] ?? 0,
                            fontSize: 16.0,
                          );
                        }).toList() ??
                        [],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SongListTile extends StatelessWidget {
  final String songName;
  final dynamic percentage;
  final num fontSize;

  SongListTile({
    required this.songName,
    required this.percentage,
    this.fontSize = 16.0,
  });

  Future<void> onSongTap(BuildContext context) async {
    print('Canción seleccionada: $songName');

    bool isSuccess = await getMusic1(songName);
    print("DEBUG - getMusic1 result: $isSuccess");

    if (isSuccess) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MusicPage2()));
    }
  }

  @override
  Widget build(BuildContext context) {
    int percentValue = 0;
    if (percentage is int) {
      percentValue = percentage;
    } else if (percentage is num) {
      percentValue = percentage.round();
    } else if (percentage is String) {
      percentValue = int.tryParse(percentage) ?? 0;
    }

    return GestureDetector(
      onTap: () => onSongTap(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Text(
                songName,
                style: TextStyle(
                  color: Color(0xFF4DB6AC),
                  fontSize: fontSize.toDouble(),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 4, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min, 
                children: [
                  Flexible(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 70, 
                        minWidth: 50,
                      ),
                      height: 15,
                      decoration: BoxDecoration(
                        color: Color(0xFF4DB6AC).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (percentValue / 100).clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF4DB6AC),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6.0), 
                  Container( 
                    width: 42,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '$percentValue%',
                      style: TextStyle(
                        color: Color(0xFF4DB6AC),
                        fontSize: fontSize.toDouble(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}