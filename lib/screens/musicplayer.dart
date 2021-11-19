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
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/water.mp3')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/acoustic.mp3')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/town.mp3')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/techno.mp3')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/sadge.mp3')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/piano.mp3')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/lofi.mp3')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/life.mp3')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/kleinstadt.mp3')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/irish.mp3')),
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
