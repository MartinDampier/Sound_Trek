// ignore_for_file: prefer_const_constructors

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final String audioPath;
  const AudioFile({Key? key, required this.advancedPlayer, required this.audioPath}) : super(key: key);

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  Color color = Colors.black;
  List<IconData> _icons = [Icons.play_circle_fill, Icons.pause_circle_filled,];
  final song = AudioCache();

  @override
  void initState(){
    super.initState();
    widget.advancedPlayer.onDurationChanged.listen((d) {setState(() {_duration = d;});});
    widget.advancedPlayer.onAudioPositionChanged.listen((p) {setState(() {_position = p;});});
    widget.advancedPlayer.setUrl(widget.audioPath);
    widget.advancedPlayer.onPlayerCompletion.listen((event) {setState(() {
      _position = Duration(seconds: 0);
      if(isRepeat == true){
        isPlaying = true;
      }
      else{
        isPlaying = false;
        isRepeat = false;
      }
    });});

    song.play('acoustic.mp3');
  }

  // Widget startButton() {
  //   return IconButton(
  //     padding: const EdgeInsets.only(bottom: 10),
  //     icon: isPlaying == false?Icon(_icons[0]):Icon(_icons[1]),
  //     onPressed: () {
  //       if (isPlaying == false) {
  //         widget.advancedPlayer.play(widget.audioPath);
  //         setState(() {
  //           isPlaying = true;
  //         });
  //       } else if (isPlaying == true) {
  //         widget.advancedPlayer.pause();
  //         setState(() {
  //           isPlaying = false;
  //         });
  //       }
  //     }
  //     );
  // }

  // Widget skipButton() {
  //   return IconButton(
  //     icon: ImageIcon(
  //       AssetImage('img/forward.png'),
  //       size: 15,
  //       color: Colors.black,
  //     ),
  //     onPressed: () {
  //       widget.advancedPlayer.setPlaybackRate(); //will deal with it later
  //     },
  //   );
  // }

  // Widget previousButton() {
  //   return IconButton(
  //     icon: ImageIcon(
  //       AssetImage('img/backward.png'),
  //       size: 15,
  //       color: Colors.black,
  //     ),
  //     onPressed: () {
  //       widget.advancedPlayer.setPlaybackRate(); //will deal with it later
  //     },
  //   );
  // }

  //Will implement shuffle button later
  // Widget shuffleButton() {
  //   return IconButton(onPressed: onPressed, icon: icon);
  // }

  Widget repeatButton() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('img/repeat.png'),
        size: 15,
        color: color,
      ),
      onPressed: () {
        if(isRepeat == false){
          widget.advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            isRepeat = true;
            color = Colors.blue;
          });
        }
        else if (isRepeat == true) {
          widget.advancedPlayer.setReleaseMode(ReleaseMode.RELEASE);
          color = Colors.black;
          isRepeat = false;
        }
      },
    );
  }

  Widget slider() {
    return Slider(
      activeColor: Colors.red,
      inactiveColor: Colors.grey,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          secondsConverter(value.toInt());
          value = value;
        });
      },
    );
  }

  void secondsConverter (int second){
    Duration newDuration = Duration(seconds: second);
    widget.advancedPlayer.seek(newDuration);
  }

  Widget loadAsset() {
    return Column(
      children: [
        Padding(padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_position.toString().split(".")[0], style: TextStyle(fontSize: 16),),
            Text(_duration.toString().split(".")[0], style: TextStyle(fontSize: 16),),
          ],
        ),),
        slider(),
        loadAsset(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
