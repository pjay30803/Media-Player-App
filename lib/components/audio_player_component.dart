import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerComponent extends StatefulWidget {
  const AudioPlayerComponent({super.key});

  @override
  State<AudioPlayerComponent> createState() => _AudioPlayerComponentState();
}

class _AudioPlayerComponentState extends State<AudioPlayerComponent> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration? totalDuration;
  Duration? currentPosition;
  int currentIndex = 0;

  List<Map<String, String>> songs = [
    {"path": "audio/003.mp3", "name": "Pushpa Pushpa"},
    {"path": "audio/004.mp3", "name": "Sanam Teri Kasam"},
    {"path": "audio/Jaane_Tu.mp3", "name": "Jaane Tu"},
    {"path": "audio/Aaj_Ki_Raat.mp3", "name": "Aaj Ki Raat"},
    {"path": "audio/ahista.mp3", "name": "Ahista Ahista"},
  ];

  @override
  void initState() {
    super.initState();
    loadAudio();
  }

  Future<void> loadAudio() async {
    await audioPlayer.setSource(AssetSource(songs[currentIndex]["path"]!));
  }

  void playSong(int index) async {
    setState(() {
      currentIndex = index;
    });
    await audioPlayer.stop();
    await audioPlayer.setSource(AssetSource(songs[currentIndex]["path"]!));
    await audioPlayer.play(AssetSource(songs[currentIndex]["path"]!));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select a Song",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              DropdownButton<int>(
                value: currentIndex,
                isExpanded: true,
                items: List.generate(songs.length, (index) {
                  return DropdownMenuItem(
                    value: index,
                    child: Text(songs[index]["name"]!),
                  );
                }),
                onChanged: (index) {
                  if (index != null) {
                    playSong(index);
                  }
                },
              ),
              SizedBox(height: 20),
              StreamBuilder(
                stream: audioPlayer.onPositionChanged,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    currentPosition = snapshot.data;
                    return Text(
                      "${currentPosition.toString().split(".")[0]}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              SizedBox(height: 8),
              StreamBuilder(
                stream: audioPlayer.onDurationChanged,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    totalDuration = snapshot.data;
                    return Text(
                      "${totalDuration.toString().split(".")[0]}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              SizedBox(height: 12),
              StreamBuilder(
                stream: audioPlayer.onPositionChanged,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    currentPosition = snapshot.data;
                    return Slider(
                      min: 0,
                      max: totalDuration == null
                          ? 0
                          : totalDuration!.inSeconds.toDouble(),
                      value: currentPosition == null
                          ? 0
                          : currentPosition!.inSeconds.toDouble(),
                      onChanged: (val) async {
                        await audioPlayer.seek(Duration(seconds: val.toInt()));
                      },
                      activeColor: Colors.blueAccent,
                      inactiveColor: Colors.grey.shade400,
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await audioPlayer
                          .play(AssetSource(songs[currentIndex]["path"]!));
                    },
                    icon: Icon(Icons.play_arrow, size: 32, color: Colors.green),
                  ),
                  IconButton(
                    onPressed: () async {
                      await audioPlayer.pause();
                    },
                    icon: Icon(Icons.pause, size: 32, color: Colors.blue),
                  ),
                  IconButton(
                    onPressed: () async {
                      await audioPlayer.stop();
                    },
                    icon: Icon(Icons.stop, size: 32, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
