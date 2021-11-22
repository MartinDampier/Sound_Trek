import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_trek/screens/musicplayer.dart';
import 'package:sound_trek/widgets/musicplayer_buttons.dart';

class Playlist {
  late String title;
  late AudioPlayer _Playlist;

  void initState(){
    _Playlist = AudioPlayer();
    _Playlist.setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/water.mp3'),),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/acoustic.mp3'),),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/town.mp3'),),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/techno.mp3'),),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/sadge.mp3'),),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/piano.mp3'),),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/lofi.mp3'),),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/life.mp3'),),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/kleinstadt.mp3'),),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/irish.mp3'),),
    ]))
        .catchError((error){
      print("An error has occurred");
    });
  }
}
