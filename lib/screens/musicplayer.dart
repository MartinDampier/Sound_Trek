import 'package:sound_trek/main.dart';
import 'package:sound_trek/models/playlist.dart';
import 'package:sound_trek/widgets/musicplayer_buttons.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class AudioMetaData {
  final String title;
  final String genre;

  AudioMetaData({required this.title, required this.genre});
}

class _MusicPlayerState extends State<MusicPlayer> {
  late AudioPlayer _audioPlayer;
  
  @override
  void initState(){
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/water.mp3'),
      tag: AudioMetaData(title: 'Water', genre: 'Study')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/acoustic.mp3'),
      tag: AudioMetaData(title: 'Acoustic', genre: 'Study')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/town.mp3'),
      tag: AudioMetaData(title: 'Town', genre: 'Study')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/techno.mp3'),
      tag: AudioMetaData(title: 'Techno', genre: 'Techno Beat')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/sadge.mp3'),
      tag: AudioMetaData(title: 'Sadge', genre: 'Classical')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/piano.mp3'),
      tag: AudioMetaData(title: 'Piano', genre: 'Classical')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/lofi.mp3'),
      tag: AudioMetaData(title: 'Lofi', genre: 'Techno Beat')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/life.mp3'),
      tag: AudioMetaData(title: 'Life', genre: 'Study')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/kleinstadt.mp3'),
      tag: AudioMetaData(title: 'Kleinstadt', genre: 'Foreign')),
      AudioSource.uri(Uri.parse('asset:///assets/musicsample/irish.mp3'),
      tag: AudioMetaData(title: 'Irish', genre: 'Foreign')),
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
        child: SizedBox(
          child: SafeArea(
            child: Column(
              children: [
                IconButton(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Color.fromARGB(255, 98, 98, 98),
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const MyHomePage(title: 'Welcome to Sound Trek',);
                    }));
                  },
                ),
                Expanded(child: playlist(_audioPlayer)),
                PlayerButtons(_audioPlayer),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
