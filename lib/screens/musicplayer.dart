import 'dart:io';

import 'package:SoundTrek/widgets/musicplayer_buttons.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayer extends StatefulWidget {

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late AudioPlayer _audioPlayer;
  
  @override
  void initState(){
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/acoustic.mp3')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/beethoven.mp3')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/celtic.mp3')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/classical.mp3')),
    ]))
        .catchError((error){
          print("An error has occurred");
    });
  }
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PlayerButtons(_audioPlayer),
      ),
    );
  }
}
