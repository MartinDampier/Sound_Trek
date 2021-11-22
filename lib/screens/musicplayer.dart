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

class _MusicPlayerState extends State<MusicPlayer> {
  late AudioPlayer _audioPlayer;

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
                PlayerButtons(_audioPlayer),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
