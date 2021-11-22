import 'package:just_audio/just_audio.dart';
import 'package:sound_trek/models/user.dart';

class Playlist {

  String title = 'Unnamed';
  late ConcatenatingAudioSource _songs;

  Playlist(ConcatenatingAudioSource songs, String name) {
    _songs = songs;
    title = name;
  }

  void passToMusicPlayer (User user) {
    user.setMusicPlayer(_songs);
  }

}