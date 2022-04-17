import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioUrlPage extends StatefulWidget {
  const AudioUrlPage({Key? key}) : super(key: key);


  // https://www.youtube.com/watch?v=MB3YGQ-O1lk

  @override
  _AudioUrlPageState createState() => _AudioUrlPageState();
}

class _AudioUrlPageState extends State<AudioUrlPage> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String url = "https://filesamples.com/samples/audio/mp3/sample3.mp3";


  String totalDuration = "00:00";
  double maxSeekbar = 0;

  @override
  void initState() {
    super.initState();




    // listen to state play,pause,stop
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;

        double maxx =    duration.inSeconds.toDouble();
        double cmax = maxx;
      });
    });

    // listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
        totalDuration = formatTime(duration);
        maxSeekbar = duration.inSeconds.toDouble();
      });
    });

    // listen to audio position
    audioPlayer.onAudioPositionChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "https://jpeg.org/images/jpegsystems-home.jpg",
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),


            Slider(
                min: 0,
                max: maxSeekbar,
                value: duration.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  await audioPlayer.seek(position);

                  //optionally play audio if was paused
                  await audioPlayer.resume();

                }),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(formatTime(duration)),
                  Text(totalDuration),

                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 35,
              child: IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                ),
                iconSize: 50,
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    await audioPlayer.play(url);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));


    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(":");
  }
}
