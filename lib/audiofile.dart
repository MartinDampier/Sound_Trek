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

  @override
  void initState(){
    super.initState();
    widget.advancedPlayer.onDurationChanged.listen((d) {setState(() {_duration = d;});});
    widget.advancedPlayer.onAudioPositionChanged.listen((p) {setState(() {_position = p;});})
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
  }

  Widget startButton() {
    return IconButton(onPressed: onPressed, icon: icon);
  }

  Widget fastforwardButton() {
    return IconButton(onPressed: onPressed, icon: icon);
  }

  Widget slowButton() {
    return IconButton(onPressed: onPressed, icon: icon);
  }

  Widget loopButton() {
    return IconButton(onPressed: onPressed, icon: icon);
  }

  Widget repeatButton() {
    return IconButton(onPressed: onPressed, icon: icon);
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
    return Container(
      child: Column(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
