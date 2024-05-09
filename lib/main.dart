import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_video_player.dart';
import 'video_list.dart';
import 'social_media_icons.dart';
import 'qr-scan.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ),
  );
  runApp(Videoplayer());
}

class Videoplayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LSM Revival',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedUrl = '';
  bool _isVideoPlaying = false;
  Key _videoPlayerKey = UniqueKey();

  Future<void> _scanQRCode() async {
    final String? scannedUrl = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => QRScannerPage(),
      ),
    );
    if (scannedUrl!= null) {
      setState(() {
        _selectedUrl = scannedUrl;
        _isVideoPlaying = true;
        _videoPlayerKey = UniqueKey(); // Generate a new key
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset(
            'assets/steen.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        title: const Text(
          'LSM Revival',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            color: Colors.white,
            onPressed: _scanQRCode,
          ),
        ],
      ),
      body: Column(
        children: [
          _selectedUrl.isEmpty
              ? Container(
            height: 200,
            color: Colors.black,
            child: Center(
              child: GestureDetector(
                onTap: _scanQRCode,
                child: Text(
                  'Klik hier om je QR Code te scannen',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          )
              : CustomVideoPlayer(key: _videoPlayerKey, videoUrl: _selectedUrl),
          const SizedBox(height: 80.0),
          Text(
            'Kies je locatie:',
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: VideoList(
              onSelect: (String url) {
                setState(() {
                  _selectedUrl = url;
                  _isVideoPlaying = false;
                  _videoPlayerKey = UniqueKey(); // Generate a new key
                });
              },
              isVideoPlaying: _isVideoPlaying,
              onVideoPlayingChanged: () {
                setState(() {
                  _isVideoPlaying = true;
                });
              },
            ),
          ),
          const SizedBox(height: 20.0),
          SocialMediaIcons(),
        ],
      ),
    );
  }
}