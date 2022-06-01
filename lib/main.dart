import 'package:flutter/material.dart';
import 'music.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ynovify',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 19, 34, 43)),
      home: const MyHomePage(title: 'YNOVIFY'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _player = AudioPlayer();

  bool doPlay = false;

  int index = 0;

  Duration duration = const Duration(seconds: 0);

  String formatDuration = "";

  String format(Duration duration) {
    return duration.toString().substring(2, 7);
  }

  void rewindMusic() {
    if (index == 0) {
      index = myMusicList.length - 1;
    } else {
      index--;
    }
    _init();
  }

  void play() {
    doPlay = !doPlay;
    if (doPlay == true) {
      _player.play();
    } else {
      _player.pause();
    }
  }

  void forwardMusic() {
    if (myMusicList.length - 1 == index) {
      index = 0;
    } else {
      index++;
    }
    _init();
  }

  void _init() async {
    await _player
        .setAudioSource(AudioSource.uri(Uri.parse(myMusicList[index].urlSong)))
        .then((value) {
      setState(() {
        duration = value!;
      });
    });
  }

  List<Music> myMusicList = [
    Music('A State Of Trance', 'Armin', 'assets/images/A-State-Of-Trance.jpg',
        'https://codiceo.fr/mp3/armin.mp3'),
    Music('Civilisation', 'Orelsan', 'assets/images/Civilisation.jpg',
        'https://codiceo.fr/mp3/civilisation.mp3'),
  ];

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(myMusicList[index].imagePath),
                      fit: BoxFit.fill)),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              myMusicList[index].title,
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              myMusicList[index].singer,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.fast_rewind,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      rewindMusic();
                    });
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: Icon(
                    (doPlay == false) ? Icons.play_arrow : Icons.stop,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {
                    setState(() {
                      play();
                    });
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.fast_forward,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      forwardMusic();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              format(duration),
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
